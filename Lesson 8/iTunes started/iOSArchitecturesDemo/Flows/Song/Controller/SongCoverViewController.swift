//
//  SongCoverViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongCoverViewController: UIViewController {
    
    public var song: ITunesSong
    
    private let imageDownloader = ImageDownloader()
    
    private var songCoverView: SongCoverView {
        return self.view as! SongCoverView
    }
    
    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = SongCoverView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congureUI()
    }
    
    private func congureUI() {
        downloadImage()
    }
    
    private func downloadImage() {
        guard let url = self.song.artwork else { return }
        
        self.imageDownloader.getImage(fromUrl: url) { [weak self] (image, error) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.songCoverView.coverImageView.image = image
            }
        }
    }
}
