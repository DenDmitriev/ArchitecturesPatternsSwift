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
    func close()
}

protocol PlaybackViewModelOutput {
    var onProgressViewChanged: ((Double) -> Void)? { get set }
    var timecodeChanged: ((String) -> Void)? { get set }
    var playbackChanged: ((Bool) -> Void)? { get set }
    var trackAvailable: ((Bool, String?) -> Void)? { get set }
}

class PlaybackViewModel: PlaybackViewModelOutput {
    
    private var audioPlayer: AudioPlayer?
    
    private var musicUrl: String
    
    var playbackChanged: ((Bool) -> Void)?
    var timecodeChanged: ((String) -> Void)?
    var onProgressViewChanged: ((Double) -> Void)?
    var trackAvailable: ((Bool, String?) -> Void)?
    
    private let musicDownloader = MusicDownloader()
    
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
    
    private lazy var duration: TimeInterval = {
        guard let duration = audioPlayer?.player?.duration else { return 0 }
        return duration
    }()
    
    private var currentTime: TimeInterval {
        guard let currentTime = audioPlayer?.player?.currentTime else { return 0 }
        return currentTime
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
                guard let self = self else { return }
                self.createPlayer(with: data)
                self.trackAvailable?(true, self.getTimecode(from: self.duration))
            }
        }
    }
    
    //MARK: - AudioPlayer
    
    private func createPlayer(with data: Data?) {
        guard let music = data else { return }
        audioPlayer = AudioPlayer(data: music, viewModel: self)
    }
    
    //MARK: - UI Methods
    
    private func updateUI() {
        updateProgress()
        updateButtons()
    }
    
    private func updateButtons() {
        playbackChanged?(audioPlayer?.player?.isPlaying ?? false)
    }
    
    private func updateProgress() {
        guard let isPlaying = audioPlayer?.player?.isPlaying  else { return }
        if isPlaying {
            invalidateTimers()
            
            let timerProgress = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                self.progress = self.currentTime / self.duration
            }
            
            let timerTimecode = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                self.timecode = self.getTimecode(from: timer.timeInterval + self.currentTime)
            }
            
            timers.append(contentsOf: [timerProgress, timerTimecode])
        } else {
            invalidateTimers()
            
            self.progress = currentTime / duration
            self.timecode = getTimecode(from: currentTime)
        }
    }
    
    //MARK: - Helpers
    
    private func invalidateTimers() {
        timers.forEach { $0?.invalidate() }
        timers.removeAll()
    }
    
    private func getTimecode(from timeInterval: TimeInterval) -> String {
        let durationInSeconds = Int(timeInterval)
        //print(durationInSeconds)
        let minutes = durationInSeconds / 60
        let seconds = durationInSeconds - minutes * 60
        return String(format: "%02d:%02d", minutes,seconds) as String
    }
}

extension PlaybackViewModel: PlaybackViewModelInput {
    
    func close() {
        //print(#function)
        stop()
        audioPlayer = nil
    }
    
    
    func play() {
        //print(#function)
        guard let isPlaying = audioPlayer?.player?.isPlaying else { return }
        
        switch isPlaying {
        case false:
            audioPlayer?.player?.play()
        case true:
            audioPlayer?.player?.pause()
        }
        
        updateUI()
    }
    
    func stop() {
        //print(#function)
        audioPlayer?.player?.stop()
        audioPlayer?.player?.currentTime = 0

        updateUI()
    }
}

extension PlaybackViewModel: AudioPlayerOutput {
    
    func playerDidFinishPlaying() {
        updateUI()
        invalidateTimers()
    }
}
