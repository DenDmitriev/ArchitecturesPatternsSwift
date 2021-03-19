//
//  SongViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongViewController: UIViewController {
    
    public let song: ITunesSong
    
    lazy var songCoverViewController = SongCoverViewController(song: song)
    
    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        configureNavigationController()
        
        addCover()
    }
    
    // MARK: - Private
    
    private func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addCover() {
        
        self.view.addSubview(songCoverViewController.view)
        addChild(songCoverViewController)
        
        songCoverViewController.didMove(toParent: self)
        
        songCoverViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            songCoverViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            songCoverViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            songCoverViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
    }
    
    
}
