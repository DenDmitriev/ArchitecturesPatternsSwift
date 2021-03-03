//
//  VKService.swift
//  VK
//
//  Created by Denis Dmitriev on 29.07.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import Foundation
import RealmSwift

final class VKService {
    
    let session = Session.shared
    
    enum Method {
        case friends
        case photos(id: String)
        case groups
        case searchGroups(text: String)
        case wall
        case album(id: String)
        case photosByAlbom(ownerId: String, albomId: String)
        
        var path: String {
            switch self {
            case .friends:
                return "/method/friends.get"
            case .photos:
                return "/method/photos.getAll"
            case .groups:
                return "/method/groups.get"
            case .searchGroups:
                return "/method/groups.search"
            case .wall:
                return "/method/newsfeed.get"
            case .album:
                return "/method/photos.getAlbums"
            case .photosByAlbom:
                return "/method/photos.get"
            }
        }
        
        var parameters: [String: String] {
            switch self {
            case .friends:
                return ["order": "name", "fields": "photo_100"]
            case .photos(id: let id):
                return ["owner_id": id, "count": "99"]
            case .groups:
                return ["extended": "1", "fields": "photo_100"]
            case .searchGroups(text: let text):
                return ["q": text, "type": "group"]
            case .wall:
                return ["filters": "post,photo", "return_banned": "0", "count": "10"]
            case .album(id: let id):
                return ["owner_id": id, "need_covers": "1"]
            case .photosByAlbom(ownerId: let ownerId, albomId: let albomId) :
                return ["owner_id": ownerId, "album_id": albomId]
            }
        }
        
    }
    
    func request(_ method: Method, add parameters: [String:String]? = nil, comletion: @escaping ((Data?) -> Void)) {
        DispatchQueue.global().async {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.vk.com"
            components.path = method.path
            var queryItems = [
                URLQueryItem(name: "access_token", value: self.session.token),
                URLQueryItem(name: "v", value: "5.21")
            ]
            if let parameters = parameters {
                parameters.forEach { (key, value) in
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
            }
            let methodQueryItems = method.parameters.map { URLQueryItem(name: $0, value: $1) }
            components.queryItems = queryItems + methodQueryItems
            
            guard let url = components.url
            else {
                comletion(nil)
                return
            }
            
            let session = URLSession.shared
            print(url)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                }
                comletion(data)
            }
            task.resume()
        }
    }
    
    //MARK: - Methods api
    
    func getFriends(completion: @escaping (() -> Void)) {
        request(.friends) { (data) in
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
        request(.photos(id: ownerID)) { (data) in
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
        request(.groups) { (data) in
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
        request(.searchGroups(text: text)) { (data) in
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
        
        request(.wall, add: parameters) { (data) in
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
        request(.album(id: ownerID)) { (data) in
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
        request(.photosByAlbom(ownerId: ownerId, albomId: albumId)) { (data) in
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
