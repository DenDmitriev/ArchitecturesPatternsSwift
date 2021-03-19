//
//  SearchAppRouterInput.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 20.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchAppRouterInput {
    
    func openApp(for app: ITunesApp)
    
}

class SearchAppRouter: SearchAppRouterInput {
    
    weak var viewController: UIViewController?
    
    func openApp(for app: ITunesApp) {
        let appDetailViewController = AppDetailViewController(app: app)
        viewController?.navigationController?.pushViewController(appDetailViewController, animated: true)
    }
}
