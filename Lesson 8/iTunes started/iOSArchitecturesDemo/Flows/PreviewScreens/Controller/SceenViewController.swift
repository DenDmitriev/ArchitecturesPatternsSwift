//
//  SceenPageViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SceenViewController: UIViewController {
    
    public var image: UIImage
    
    private var previewScreenView: PreviewScreenView {
        return self.view as! PreviewScreenView
    }
    
    //MARK: - initialize
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func loadView() {
        self.view = PreviewScreenView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        congureUI()
    }
    
    //MARK: - Private
    
    private func congureUI() {
        previewScreenView.imageView.image = image
        
        let aspect = image.size.height / image.size.width
        previewScreenView.imageView.heightAnchor.constraint(equalTo: previewScreenView.imageView.widthAnchor, multiplier: aspect).isActive = true
    }

}
