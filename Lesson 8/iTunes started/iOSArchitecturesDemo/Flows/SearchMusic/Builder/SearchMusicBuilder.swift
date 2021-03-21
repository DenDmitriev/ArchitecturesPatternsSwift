//
//  SearchMusicBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SearchMusicBuilder {
    
    static func build() -> (UIViewController & SearchMusicViewInput) {
        let router = SearchMusicRouter()
        let interactor = SearchMusicInteractor()
        
        let presenter = SearchMusicPresenter(router: router, interactor: interactor)
        
        let viewController = SearchMusicViewController(presenter: presenter)
        presenter.viewInput = viewController
        router.viewController = viewController
        
        return viewController
    }
}
