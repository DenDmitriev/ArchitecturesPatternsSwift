//
//  ResponsePost.swift
//  1l_ДмитриевДенис
//
//  Created by Denis Dmitriev on 01.07.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit

class ResponsePost: Decodable {
    var items: [Post]
    var users: [UserRealm]?
    var groups: [GroupRealm]?
    
    var nextFrom: String
    
    enum CodingKeys: String, CodingKey {
        case response
        case items
        case users = "profiles"
        case groups = "groups"
        case nextFrom = "next_from"
    }
    
    required init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try topContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        self.items = try container.decode([Post].self, forKey: .items)
        self.users = try? container.decode([UserRealm].self, forKey: .users)
        self.groups = try? container.decode([GroupRealm].self, forKey: .groups)
        self.nextFrom = try container.decode(String.self, forKey: .nextFrom)
    }
    
    func findAuthorOfPost() {
        guard
            let users = self.users,
            let groups = self.groups
        else { return }
        for user in users {
            items.forEach { (post) in
                if post.id == user.id {
                    post.user = user
                }
            }
        }
        for group in groups {
            items.forEach { (post) in
                if post.id == (group.id * (-1)) {
                    post.group = group
                }
            }
        }
    }
}


final class Post: Decodable {
    var id: Int = 0
    var date: TimeInterval = 0
    
    var type: PostType = .post
    
    var text: String?
    var textMode: TextMode = .short
    
    var photos: [Photo]?
    var photoMode: AlbomMode? {
        get {
            switch photos?.count {
            case 0:
                return .empty
            case 1:
                return .single
            case 2:
                return .double
            default:
                return .triple
            }
        }
    }
    
    var likes: Social?
    var comments: Social?
    var views: Social?
    var reposts: Social?
    
    var user: UserRealm?
    var group: GroupRealm?
    
    //MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "source_id"
        case date
        case text
        case type
        case photos
        case photo
        case items
        case attachments
        case likes
        case comments
        case views
        case reposts
    }
    
    //MARK: - Decodable
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.date = try container.decode(TimeInterval.self, forKey: .date)
        self.text = try? container.decode(String.self, forKey: .text)
        self.type = try container.decode(PostType.self, forKey: .type)
        
        switch self.type {
        case .photo:
            let photosContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)
            self.photos = try? photosContainer?.decode([Photo].self, forKey: .items)
        case .post:
            let attachments = try? container.decode([Attachments].self, forKey: .attachments)
            photos = []
            attachments?.forEach({ (attachment) in
                photos?.append(attachment.photo)
            })
        }
        
        self.likes = try? container.decode(Social.self, forKey: .likes)
        self.comments = try? container.decode(Social.self, forKey: .comments)
        self.views = try? container.decode(Social.self, forKey: .views)
        self.reposts = try? container.decode(Social.self, forKey: .reposts)
    }
    
    enum TextMode {
        case full
        case short
    }
    
    enum AlbomMode {
        case empty
        case single
        case double
        case triple
    }
}

enum PostType: String, Decodable {
    case post
    case photo
}

struct Social: Decodable {
    let count: Int
}

struct Attachments: Decodable {
    var type: AttachmentsType
    var photo: Photo
}

enum AttachmentsType: String, Decodable {
    case photo
}


