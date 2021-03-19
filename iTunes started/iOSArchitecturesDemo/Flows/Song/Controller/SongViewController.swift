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
    
    lazy var songBackgroundViewController = SongBackgroundViewController(imageUrl: song.artwork)
    lazy var songCoverViewController = SongCoverViewController(song: song)
    lazy var songTitleViewController = SongTitleViewController(song: song)
    lazy var songControlViewController = SongControlViewController(song: song)
    
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
        
        addBackground()
        addCover()
        addTitle()
        addControl()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopActions()
    }
    
    // MARK: - Private
    
    private func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addBackground() {
        
        self.view.addSubview(songBackgroundViewController.view)
        addChild(songBackgroundViewController)
        
        songBackgroundViewController.didMove(toParent: self)
        
        songBackgroundViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            songBackgroundViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            songBackgroundViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            songBackgroundViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            songBackgroundViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func addCover() {
        
        self.view.addSubview(songCoverViewController.view)
        addChild(songCoverViewController)
        
        songCoverViewController.didMove(toParent: self)
        
        songCoverViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let width = self.view.bounds.width / 1.6
        let topHeightEdge = (self.view.bounds.width - width) / 2
        
        NSLayoutConstraint.activate([
            songCoverViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: topHeightEdge),
            songCoverViewController.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            songCoverViewController.view.widthAnchor.constraint(equalToConstant: width)
        ])
        
    }
    
    private func addTitle() {
        
        self.view.addSubview(songTitleViewController.view)
        addChild(songTitleViewController)
        
        songTitleViewController.didMove(toParent: self)
        
        songTitleViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            songTitleViewController.view.topAnchor.constraint(equalTo: songCoverViewController.view.bottomAnchor),
            songTitleViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            songTitleViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
        ])
        
    }
    
    private func addControl() {
        
        self.view.addSubview(songControlViewController.view)
        addChild(songControlViewController)
        
        songControlViewController.didMove(toParent: self)
        
        songControlViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            songControlViewController.view.topAnchor.constraint(equalTo: songTitleViewController.view.bottomAnchor, constant: 12),
            songControlViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            songControlViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
        ])
    }
    
    private func stopActions() {
        songControlViewController.close()
    }
    
    
}
