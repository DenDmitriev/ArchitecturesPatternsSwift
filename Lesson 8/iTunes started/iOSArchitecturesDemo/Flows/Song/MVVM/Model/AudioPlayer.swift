//
//  AudioPlayer.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 19.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import AVFoundation

protocol AudioPlayerOutput {
    func playerDidFinishPlaying()
}

class AudioPlayer: NSObject {
    
    static let shared = AudioPlayer()
    
    var player: AVAudioPlayer?
    var url: String?
    
    private var viewModel: AudioPlayerOutput?
    
    private override init() {
        super.init()   
    }
    
    func music(from data: Data, by url: String, with viewModel: AudioPlayerOutput) {
        
        guard player?.data != data else { return }
        
        do {
            player = try AVAudioPlayer(data: data)
            player?.numberOfLoops = 0
            player?.delegate = self
            self.viewModel = viewModel
            self.url = url
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension AudioPlayer: AudioPlayerOutput {
    func playerDidFinishPlaying() {
        viewModel?.playerDidFinishPlaying()
    }
}

extension AudioPlayer: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        player.currentTime = 0
        playerDidFinishPlaying()
    }
}
