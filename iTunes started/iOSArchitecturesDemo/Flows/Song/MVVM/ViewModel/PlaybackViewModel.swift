//
//  PlaybackViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 19.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation
import AVFoundation

protocol PlaybackViewModelInput {
    func play()
    func stop()
    func sync()
}

protocol PlaybackViewModelOutput {
    var onProgressViewChanged: ((Double) -> Void)? { get set }
    var timecodeChanged: ((String) -> Void)? { get set }
    var playbackChanged: ((Bool) -> Void)? { get set }
    var trackAvailable: ((Bool, String?) -> Void)? { get set }
}

class PlaybackViewModel: PlaybackViewModelOutput {
    
    private var audioPlayer = AudioPlayer.shared
    
    private let musicDownloader = MusicDownloader()
    
    private var musicUrl: String
    
    var playbackChanged: ((Bool) -> Void)?
    var timecodeChanged: ((String) -> Void)?
    var onProgressViewChanged: ((Double) -> Void)?
    var trackAvailable: ((Bool, String?) -> Void)?
    
    private var progress: Double {
        didSet {
            onProgressViewChanged?(progress)
        }
    }
    
    private var timecode: String {
        didSet {
            timecodeChanged?(timecode)
        }
    }
    
    private var timers = [Timer?]()
    
    init(music url: String, progress: Double, timecode: String, onProgressViewChanged: ((Double) -> Void)?, timecodeChanged: ((String) -> Void)?, playbackChanged: ((Bool) -> Void)?, trackAvailable: ((Bool, String?) -> Void)?) {
        self.musicUrl = url
        self.onProgressViewChanged = onProgressViewChanged
        self.timecodeChanged = timecodeChanged
        self.progress = progress
        self.timecode = timecode
        self.playbackChanged = playbackChanged
        self.trackAvailable = trackAvailable
        
        onProgressViewChanged?(progress)
        timecodeChanged?(timecode)
        self.trackAvailable?(false, nil)
        downloadMusic()
    }
    
    //MARK: - Network
    
    private func downloadMusic() {
        musicDownloader.getMusic(from: musicUrl) { [weak self] (data, error) in
            guard let self = self else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard
                    let self = self,
                    let data = data
                else { return }
                
                self.audioPlayer.music(from: data, by: self.musicUrl, with: self)
                self.trackAvailable?(true, self.duration.timecode())
            }
        }
    }
    
    //MARK: - AudioPlayer
    
    private lazy var duration: TimeInterval = {
        guard let duration = audioPlayer.player?.duration else { return 0 }
        return duration
    }()
    
    private var currentTime: TimeInterval {
        guard let currentTime = audioPlayer.player?.currentTime else { return 0 }
        return currentTime
    }
    
    //MARK: - UI Methods
    
    private func updateUI() {
        updateProgress()
        updateButtons()
    }
    
    private func updateButtons() {
        playbackChanged?(audioPlayer.player?.isPlaying ?? false)
    }
    
    private func updateProgress() {
        guard let isPlaying = audioPlayer.player?.isPlaying  else { return }
        if isPlaying {
            invalidateTimers()
            
            let timerProgress = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                if self.duration == 0 {
                    self.progress = 0
                } else {
                    self.progress = self.currentTime / self.duration
                }
            }
            
            let timerTimecode = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                self.timecode = (timer.timeInterval + self.currentTime).timecode()
            }
            
            timers.append(contentsOf: [timerProgress, timerTimecode])
        } else {
            invalidateTimers()
            
            self.progress = currentTime / duration
            self.timecode = currentTime.timecode()
        }
    }
    
    //MARK: - Helpers
    
    private func invalidateTimers() {
        timers.forEach { $0?.invalidate() }
        timers.removeAll()
    }
}

extension PlaybackViewModel: PlaybackViewModelInput {
    
    func sync() {
        guard let musicUrl = audioPlayer.url else { return }
        
        if musicUrl == self.musicUrl {
            updateUI()
        }
    }
    
    
    func play() {
        guard let isPlaying = audioPlayer.player?.isPlaying else { return }
        
        switch isPlaying {
        case false:
            audioPlayer.player?.play()
        case true:
            audioPlayer.player?.pause()
        }
        
        updateUI()
    }
    
    func stop() {
        audioPlayer.player?.stop()
        audioPlayer.player?.currentTime = 0

        updateUI()
    }
}

extension PlaybackViewModel: AudioPlayerOutput {
    
    func playerDidFinishPlaying() {
        updateUI()
        invalidateTimers()
    }
}
