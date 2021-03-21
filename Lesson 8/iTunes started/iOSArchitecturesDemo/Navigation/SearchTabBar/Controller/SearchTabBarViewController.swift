//
//  SearchTabBarViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SearchTabBarViewController: UITabBarController {
    
    //MARK: - Tabs
    
    lazy public var searchAppController: UIViewController = {
        
        let viewController = SearchBuilder.build()
        
        let titleNavigation = "Search Apps via iTunes"
        viewController.navigationItem.title = titleNavigation
        
        let navigationController = configuredNavigationController(with: viewController)
        
        let titleTab = "Apps"
        let defaultImage = UIImage(systemName: "app")!
        let selectedImage = UIImage(systemName: "app.fill")!
        let tabBarItem = UITabBarItem(title: titleTab, image: defaultImage, selectedImage: selectedImage)
        viewController.tabBarItem = tabBarItem
        
        return navigationController
    }()
    
    lazy public var searchMusicController: UIViewController = {
        
        let viewController = SearchMusicBuilder.build()
        
        let titleNavigation = "Search Music via iTunes"
        viewController.navigationItem.title = titleNavigation
        
        let navigationController = configuredNavigationController(with: viewController)
        
        let titleTab = "Music"
        let defaultImage = UIImage(systemName: "music.note")!
        let selectedImage = UIImage(systemName: "music.note.list")!
        let tabBarItem = UITabBarItem(title: titleTab, image: defaultImage, selectedImage: selectedImage)
        viewController.tabBarItem = tabBarItem
        
        return navigationController
    }()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [searchAppController, searchMusicController]
    }
    
    //MARK: - Private
    
    private func configuredNavigationController(with viewController: UIViewController) -> UINavigationController {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.viewControllers = [viewController]
        return navVC
    }

}
