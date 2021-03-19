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
    
    var player: AVAudioPlayer?
    
    private var viewModel: AudioPlayerOutput?
    
    init(data: Data, viewModel: AudioPlayerOutput) {
        super.init()
        do {
            player = try AVAudioPlayer(data: data)
            player?.numberOfLoops = 0
            player?.delegate = self
            self.viewModel = viewModel
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
