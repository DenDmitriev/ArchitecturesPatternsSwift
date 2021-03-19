//
//  SearchMusicPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit
import Alamofire

protocol SearchMusicViewInput: class {
    
    var searchResults: [ITunesSong] { get set }
    func showError(error: Error)
    func hideNoResults()
    func showNoResults()
    func throbber(show: Bool)
}

protocol SearchMusicViewOutput {
    
    func viewDidSearch(with query: String)
    func viewDidSelectSong(_ song: ITunesSong)
}

class SearchMusicPresenter {
    
    let interactor: SearchMusicInteractorInput
    let router: SearchMusicRouterInput
    
    init(router: SearchMusicRouterInput, interactor: SearchMusicInteractorInput) {
        self.interactor = interactor
        self.router = router
    }
    
    weak var viewInput: (UIViewController & SearchMusicViewInput)?
    
    private func requestSongs(with query: String) {
        interactor.requestSongs(with: query) { [weak self] result in
            guard let self = self else { return }
            
            self.interactor.addToCache(for: query, songs: result.value)
            
            self.viewInput?.throbber(show: false)
            result.withValue { song in
                guard !song.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = song
            }.withError {
                self.viewInput?.showError(error: $0)
            }
        }
    }
    
    private func openSong(with song: ITunesSong) {
        router.openSong(for: song)
    }
}

extension SearchMusicPresenter: SearchMusicViewOutput {
    
    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        requestSongs(with: query)
    }
    
    func viewDidSelectSong(_ song: ITunesSong) {
        openSong(with: song)
    }
}
