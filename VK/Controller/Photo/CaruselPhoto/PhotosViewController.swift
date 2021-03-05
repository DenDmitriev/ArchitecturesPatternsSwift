//
//  PhotosViewController.swift
//  VK
//
//  Created by Denis Dmitriev on 08.07.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift
import Kingfisher

class PhotosViewController: UIViewController {
    
    var alboms: [Photo]!
    var albom: Photo!
    
    var imageTemp: UIImage!
    var currentIndex = 0 {
        didSet {
            title = "\(currentIndex+1) из \(alboms.count)"
        }
    }
    var uiHidden: Bool = false {
        didSet {
            navigationController?.navigationBar.isHidden = uiHidden
            tabBarController?.tabBar.isHidden = uiHidden
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIndex()
        loadFromNetwork(imageView: imageView, albom: alboms[currentIndex])
        setupGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        defaultCenter = imageView.center
        defaultFrame = imageView.frame
        assistImageView.frame = defaultFrame
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        uiHidden = false
    }
    
    //MARK: - Setup
    
    func setupIndex() {
        imageView.image = imageTemp
        title = "\(currentIndex + 1) из \(alboms.count)"
    }
    
    func setup(_ alboms: [Photo], _ albom: Photo, _ photo: UIImage?, _ index: Int) {
        self.alboms = alboms
        self.albom = albom
        self.imageTemp = photo
        self.currentIndex = index
    }
    
    func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        imageView.addGestureRecognizer(panGesture)
    }
    
    //MARK: - Load photos
    
    private func loadFromNetwork(imageView: UIImageView, albom: Photo) {
        if imageView.image == nil {
            let placeholder = UIImage.imageWithColor(color: .gray)
            imageView.image = placeholder
        }
        guard
            let urlPath = albom.photo(.photo1280),
            let url = URL(string: urlPath)
        else { return }
        let resource = ImageResource(downloadURL: url)
        imageView.kf.setImage(with: resource)
    }
    
    //MARK: - Animation carusel
    
    enum Direction {
        case next, previous
        init(x: CGFloat) {
            self = x > 0 ? .previous : .next
        }
    }
    
    lazy var animator = UIViewPropertyAnimator()
    lazy var defaultCenter = CGPoint()
    lazy var defaultFrame = CGRect()
    lazy var move: CGFloat = 0
    lazy var currentDirection: Direction = .next
    lazy var assistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    
    func gestureAniamtionSetup(direction: Direction, nextIndex: Int) {
        
        currentDirection = direction
        
        switch direction {
        case .next:
            assistImageView.center.x += (view.frame.width + CaruselControl.separator)
            move = -(view.frame.width + CaruselControl.separator)
        case .previous:
            assistImageView.center.x -= (view.frame.width + CaruselControl.separator)
            move = +(view.frame.width + CaruselControl.separator)
        }
        
        loadFromNetwork(imageView: assistImageView, albom: alboms[nextIndex])
        
        view.addSubview(assistImageView)
        
        animator = UIViewPropertyAnimator(duration: CaruselControl.duration, curve: .easeInOut) {
            self.imageView.center.x += self.move
            self.assistImageView.center = self.defaultCenter
        }
        
        animator.addCompletion { position in
            guard position == .end else { return }
            self.imageView.center = self.defaultCenter
            self.assistImageView.removeFromSuperview()
            self.assistImageView.center = self.defaultCenter
            self.currentIndex = nextIndex
            //self.imageView.image = self.photos[nextIndex]
            self.loadFromNetwork(imageView: self.imageView, albom: self.alboms[nextIndex])
        }
        
    }
    
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: sender.view)
        let direction = Direction(x: translation.x)
        
        guard ready(direction: direction, index: currentIndex) else {
            animator.stopAnimation(true)
            toDefault(direction: direction)
            return
        }
        
        let nextIndex = direction == .next ? currentIndex + 1 : currentIndex - 1
        
        switch sender.state {
        case .began:
            gestureAniamtionSetup(direction: direction, nextIndex: nextIndex)
            //animator.pauseAnimation()
        case .changed:
            if direction == currentDirection {
                animator.fractionComplete = abs(translation.x) / sender.view!.frame.width
            } else {
                animator.stopAnimation(true)
                self.assistImageView.removeFromSuperview()
                self.assistImageView.center = self.defaultCenter
                gestureAniamtionSetup(direction: direction, nextIndex: nextIndex)
            }
        case .ended:
            if  animator.fractionComplete > 0.5 {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            } else {
                animator.stopAnimation(true)
                toDefault(direction: direction)
            }
        default:
            break
        }
    }
    
    func ready(direction: Direction, index: Int) -> Bool {
        switch direction {
        case .next:
            guard index != alboms.count - 1 else { return false }
        case .previous:
            guard index != 0 else { return false }
        }
        return true
    }
    
    func toDefault(direction: Direction) {
        UIView.animate(withDuration: 0.25, animations: {
            self.imageView.center = self.defaultCenter
            switch direction {
            case .next: self.assistImageView.center.x = self.view.frame.width*3/2 + CaruselControl.separator
            case .previous: self.assistImageView.center.x = -self.view.frame.width/2 - CaruselControl.separator
            }
        }) { _ in
            self.assistImageView.removeFromSuperview()
            self.assistImageView.center = self.defaultCenter
        }
    }
}
