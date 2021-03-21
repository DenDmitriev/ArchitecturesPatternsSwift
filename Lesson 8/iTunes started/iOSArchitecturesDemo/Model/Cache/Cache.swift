//
//  Cache.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 19.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol CacheCoverInterface {
    func addImage(on url: String?, with image: UIImage)
    func getImage(by url: String?) -> UIImage?
}

protocol CacheAppsInterface {
    func addApps(for query: String, apps: [ITunesApp])
    func getApps(by query: String) -> [ITunesApp]?
}

protocol CacheSongInterface {
    func addSongs(for query: String, songs: [ITunesSong])
    func getSongs(by query: String) -> [ITunesSong]?
}

protocol CacheMusicInterface {
    func addMusic(on url: String?, with data: Data)
    func getMusic(by url: String?) -> Data?
}

final class Cache {
    
    static let shared = Cache()
    
    private var images = [String : UIImage]()
    private var music = [String : Data]()
    private var apps = [String : [ITunesApp]]()
    private var songs = [String : [ITunesSong]]()
    
    private init() {}
}

extension Cache: CacheCoverInterface {
    
    func addImage(on url: String?, with image: UIImage) {
        guard let url = url else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.images[url] = image
        }
    }
    
    func getImage(by url: String?) -> UIImage? {
        guard
            let url = url,
            let image = images[url]
        else { return nil }
        print("get image from cache")
        return image
    }
}

extension Cache: CacheAppsInterface {
    
    func addApps(for query: String, apps: [ITunesApp]) {
        if self.apps[query] == nil {
            DispatchQueue.global().async {
                self.apps[query] = apps
            }
        }
    }
    
    func getApps(by query: String) -> [ITunesApp]? {
        guard let apps = apps[query] else { return nil }
        print("get app from cache")
        return apps
    }
}

extension Cache: CacheSongInterface {
    
    func addSongs(for query: String, songs: [ITunesSong]) {
        if self.songs[query] == nil {
            DispatchQueue.global().async {
                self.songs[query] = songs
            }
        }
    }
    
    func getSongs(by query: String) -> [ITunesSong]? {
        guard let song = songs[query] else { return nil }
        print("get song from cache")
        return song
    }
}


extension Cache: CacheMusicInterface {
    func addMusic(on url: String?, with data: Data) {
        guard let url = url else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.music[url] = data
        }
    }
    
    func getMusic(by url: String?) -> Data? {
        guard
            let url = url,
            let music = music[url]
        else { return nil }
        print("get music from cache")
        return music
    }
}
