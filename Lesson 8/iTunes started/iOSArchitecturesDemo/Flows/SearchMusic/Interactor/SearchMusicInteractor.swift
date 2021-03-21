//
//  SearchMusicInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 19.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Alamofire

protocol SearchMusicInteractorInput {
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void)
    func addToCache(for query: String, songs: [ITunesSong]?)
}


class SearchMusicInteractor: SearchMusicInteractorInput {
    
    private let searchService = ITunesSearchService()
    private let cache: CacheSongInterface = Cache.shared
    
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        if let songs = cache.getSongs(by: query) {
            DispatchQueue.main.async {
                completion(.success(songs))
            }
        } else {
            self.searchService.getSongs(forQuery: query, completion: completion)
        }
    }
    
    func addToCache(for query: String, songs: [ITunesSong]?) {
        guard let songs = songs else { return }
        self.cache.addSongs(for: query, songs: songs)
    }
}
