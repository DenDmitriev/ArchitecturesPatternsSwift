//
//  SearchAppInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 20.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Alamofire

protocol SearchAppInteractorInput {
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void)
    func addToCache(for query: String, apps: [ITunesApp]?)
}


class SearchAppInteractor: SearchAppInteractorInput {
    
    private let searchService = ITunesSearchService()
    private let cache: CacheAppsInterface = Cache.shared
    
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void) {
        if let apps = cache.getApps(by: query) {
            DispatchQueue.main.async {
                completion(.success(apps))
            }
        } else {
            self.searchService.getApps(forQuery: query, then: completion)
        }
    }
    
    func addToCache(for query: String, apps: [ITunesApp]?) {
        guard let apps = apps else { return }
        self.cache.addApps(for: query, apps: apps)
    }
}
