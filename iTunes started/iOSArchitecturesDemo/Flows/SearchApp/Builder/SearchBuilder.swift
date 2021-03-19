//
//  SearchBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Evgenii Semenov on 11.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SearchBuilder {
    
    static func build() -> (UIViewController & SearchViewInput) {
        
        let router = SearchAppRouter()
        let interactor = SearchAppInteractor()
        
        let presenter = SearchPresenter(interactor: interactor, router: router)
        
        let viewController = SearchViewController(presenter: presenter)
        presenter.viewInput = viewController
        router.viewController = viewController
        
        return viewController
    }
}
