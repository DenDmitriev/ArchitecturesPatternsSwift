//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    public var app: ITunesApp
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private(set) lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var headerDetailViewController = AppDetailHeaderViewController(app: app)
    lazy var releaseNotesViewController = AppDetailReleaseNotesViewController(app: app)
    lazy var previewScreensViewController = AppDetailPreviewScreensViewController(previews: app.screenshotUrls)
    
//    private var appDetailView: AppDetailView {
//        return self.view as! AppDetailView
//    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
//    override func loadView() {
//        super.loadView()
//        self.view = AppDetailView()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.configureNavigationController()
//        self.downloadImage()
        
        addScrollView()
        addContentView()
        
        addChildViewController()
        
        addDescriptionViewController()
        
        addPreviewScreensViewController()
    }
    
    // MARK: - Private
    
    private func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addScrollView() {
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addContentView() {
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: self.view.bounds.width)
        ])
    }
    
    private func addChildViewController() {
        
        scrollView.addSubview(headerDetailViewController.view)
        addChild(headerDetailViewController)
        
        headerDetailViewController.didMove(toParent: self)
        
        headerDetailViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerDetailViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerDetailViewController.view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            headerDetailViewController.view.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
    }
    
    private func addDescriptionViewController() {
        
        scrollView.addSubview(releaseNotesViewController.view)
        addChild(releaseNotesViewController)
        
        releaseNotesViewController.didMove(toParent: self)
        
        releaseNotesViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            releaseNotesViewController.view.topAnchor.constraint(equalTo: headerDetailViewController.view.bottomAnchor, constant: 12),
            releaseNotesViewController.view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            releaseNotesViewController.view.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    private func addPreviewScreensViewController() {
        
        scrollView.addSubview(previewScreensViewController.view)
        addChild(previewScreensViewController)
        
        previewScreensViewController.didMove(toParent: self)
        
        previewScreensViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            previewScreensViewController.view.topAnchor.constraint(equalTo: releaseNotesViewController.view.bottomAnchor, constant: 12),
            previewScreensViewController.view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            previewScreensViewController.view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            previewScreensViewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
