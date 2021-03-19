//
//  SongControlViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 19.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongControlViewController: UIViewController {
    
    public var song: ITunesSong
    
    private var viewModel: PlaybackViewModelInput?
    
    private var songControlView: SongControlView {
        return self.view as! SongControlView
    }
    
    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = SongControlView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Public
    
    func close() {
        viewModel?.close()
    }
    
    //MARK: - Private methods
    
    private func configureUI() {
        //from view to controller
        songControlView.viewController = self
        
        //from controller to view model
        viewModel = PlaybackViewModel(music: song.previewUrl ?? "", progress: 0, timecode: "00:00", onProgressViewChanged: { [weak self] progress in
            self?.songControlView.progressView.setProgress(Float(progress), animated: false)
        }, timecodeChanged: { [weak self] timecode in
            self?.songControlView.updateTimecode(timecode: timecode)
        }, playbackChanged: { [weak self] isPlaying in
            self?.songControlView.updatePlayButton(isPlaying: isPlaying)
        }, trackAvailable: { [weak self] (isAvailable, duration)  in
            self?.songControlView.trackAvailable(isAvailable: isAvailable, with: duration)
        })
    }
    
    
}

extension SongControlViewController: SongControlViewOutput {
    func playAction(sender: UIButton) {
        viewModel?.play()
    }
    
    func stopAction(sender: UIButton) {
        viewModel?.stop()
    }
}
