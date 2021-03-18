//
//  PreviewScreensPageViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class PreviewScreensPageViewController: UIPageViewController {
    
    public var screens = [UIImage]()
    
    public var startPageIndex: Int = 0
    
    lazy var sceenPageViewControllers = {
        self.screens.compactMap { SceenViewController(image: $0) }
    }()
    
    init(with screens: [UIImage], transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        self.screens = screens
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        configureNavigationController()
        
        dataSource = self
        delegate = self
        
        setViewControllers([sceenPageViewControllers[startPageIndex]], direction: .forward, animated: true, completion: nil)
    }
    
    //MARK: - Private
    
    private func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
    }

}

extension PreviewScreensPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let page = sceenPageViewControllers.index(of: viewController as! SceenViewController) else { return nil }
        let previousPage = page - 1
        guard previousPage >= 0 else { return sceenPageViewControllers.last }
        guard sceenPageViewControllers.count > previousPage else { return nil }
        
        return sceenPageViewControllers[previousPage]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let page = sceenPageViewControllers.index(of: viewController as! SceenViewController) else { return nil }
        let nextPage = page + 1
        guard nextPage < sceenPageViewControllers.count else { return sceenPageViewControllers.first }
        guard sceenPageViewControllers.count > nextPage else { return nil }
        
        return sceenPageViewControllers[nextPage]
    }
}

extension PreviewScreensPageViewController: UIPageViewControllerDelegate {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return sceenPageViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstPageViewController = pageViewController.viewControllers?.first as? SceenViewController else {
            return 0
        }
        guard let firstPage = sceenPageViewControllers.index(of: firstPageViewController) else {
            return 0
        }
        
        return firstPage
    }
}
