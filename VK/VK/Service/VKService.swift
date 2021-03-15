//
//  VKService.swift
//  VK
//
//  Created by Denis Dmitriev on 29.07.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import Foundation
import RealmSwift

class VKService {

    let requestService = RequestLoggingProxy(requestService: RequestService())
    
    func getFriends(completion: @escaping (() -> Void)) {
        requestService.request(.friends) { (data) in
            guard let data = data else {
                return
            }
            do {
                let response = try JSONDecoder().decode(Response<UserRealm>.self, from: data)
                let users = response.items.filter() { $0.name.lowercased() != "deleted"}
                RealmService.shared.saveData(users)
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getPhotos(ownerID: String, completion: @escaping (([Photo]) -> Void)) {
        requestService.request(.photos(id: ownerID)) { (data) in
            guard let data = data else {
                completion([])
                return
            }
            do {
                let response = try JSONDecoder().decode(Response<Photo>.self, from: data)
                let photos = response.items
                DispatchQueue.main.async {
                    completion(photos)
                }
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func getGroups(completion: @escaping (() -> Void)) {
        requestService.request(.groups) { (data) in
            guard let data = data else {
                return
            }
            do {
                let response = try JSONDecoder().decode(Response<GroupRealm>.self, from: data)
                RealmService.shared.saveData(response.items)
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getGroupsSearch(text: String, completion: @escaping ([GroupRealm]) -> Void) {
        requestService.request(.searchGroups(text: text)) { (data) in
            guard let data = data else {
                completion([])
                return
            }
            do {
                let response = try JSONDecoder().decode(Response<GroupRealm>.self, from: data)
                DispatchQueue.main.async {
                    completion(response.items)
                }
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func getWall(from startTime: TimeInterval? = nil, before startFrom: String? = nil, completion: @escaping (([Post], String) -> Void)) {
        
        var parameters: [String : String] = [:]
        
        if let startTime = startTime {
            parameters["start_time"] = String(startTime + 1)
        }
        if let startFrom = startFrom {
            parameters["start_from"] = startFrom
        }
        
        requestService.request(.wall, add: parameters) { (data) in
            guard let data = data else {
                completion([], "")
                return
            }
            do {
                let response = try JSONDecoder().decode(ResponsePost.self, from: data)
                response.findAuthorOfPost()
                DispatchQueue.main.async {
                    completion(response.items, response.nextFrom)
                }
            } catch {
                print(error.localizedDescription)
                completion([], "")
            }
        }
    }
    
    func getAlbums(ownerID: String, completion: @escaping (([Album]) -> Void)) {
        requestService.request(.album(id: ownerID)) { (data) in
            guard let data = data else {
                completion([])
                return
            }
            do {
                let response = try JSONDecoder().decode(Response<Album>.self, from: data)
                let albums = response.items
                DispatchQueue.main.async {
                    completion(albums)
                }
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func getPhotoByAlbom(ownerId: String, albumId: String, completion: @escaping (([Photo]) -> Void)) {
        requestService.request(.photosByAlbom(ownerId: ownerId, albomId: albumId)) { (data) in
            guard let data = data else {
                completion([])
                return
            }
            do {
                let response = try JSONDecoder().decode(Response<Photo>.self, from: data)
                let photos = response.items
                DispatchQueue.main.async {
                    completion(photos)
                }
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
}
