//
//  MusicDownloader.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 19.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation
import Alamofire

typealias DownloadMusicCompletion = (_ music: Data?, _ error: Error?) -> Void

final class MusicDownloader {
    
    public func getMusic(from url: String, completion: @escaping DownloadMusicCompletion) {
        Alamofire.request(url).response { dataResponse in
            if let error = dataResponse.error {
                completion(nil, error)
                return
            }
            
            guard let musicData = dataResponse.data else {
                let errorUserInfo = [NSLocalizedDescriptionKey: "Ошибка: нет данных"]
                let error = NSError(domain:"Music", code:401, userInfo:errorUserInfo)
                completion(nil, error)
                return
            }
            
            completion(musicData, nil)
            
        }
    }
}
