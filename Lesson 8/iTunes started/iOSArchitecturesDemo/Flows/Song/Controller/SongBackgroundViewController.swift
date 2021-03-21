//
//  SongBackgroundViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 19.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongBackgroundViewController: UIViewController {
    
    public var imageUrl: String?
    
    private let imageDownloader = ImageDownloader()
    
    private var songBackgroundView: SongBackgroundView {
        return self.view as! SongBackgroundView
    }
    
    init(imageUrl: String?) {
        self.imageUrl = imageUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = SongBackgroundView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congureUI()
    }
    
    private func congureUI() {
        downloadImage()
    }
    
    private func downloadImage() {
        guard let url = imageUrl else { return }
        
        self.imageDownloader.getImage(fromUrl: url) { [weak self] (image, error) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.songBackgroundView.imageView.image = image
            }
        }
    }
}
