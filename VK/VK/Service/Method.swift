//
//  Methods.swift
//  VK
//
//  Created by Denis Dmitriev on 15.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

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
