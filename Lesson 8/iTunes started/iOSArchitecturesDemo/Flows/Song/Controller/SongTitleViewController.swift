//
//  SongTitleViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 19.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongTitleViewController: UIViewController {
    
    public var song: ITunesSong
    
    private var songTitleView: SongTitleView {
        return self.view as! SongTitleView
    }
    
    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = SongTitleView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        songTitleView.trackLabel.text = song.trackName
        songTitleView.artistLabel.text = song.artistName
    }
}
