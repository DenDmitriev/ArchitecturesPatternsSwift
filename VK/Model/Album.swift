//
//  Album.swift
//  VK
//
//  Created by Denis Dmitriev on 08.02.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

final class Album: Decodable {
    var id: String?
    var ownerId: Int?
    var title: String?
    var size: Int?
    var urlThumb: String?
    
    //MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case title
        case size
        case urlThumb = "thumb_src"
    }
    
    //MARK: - Decodable
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        self.id = String(id)
        self.ownerId = try? container.decode(Int.self, forKey: .ownerId)
        self.title = try? container.decode(String.self, forKey: .title)
        self.size = try? container.decode(Int.self, forKey: .size)
        self.urlThumb = try? container.decode(String.self, forKey: .urlThumb)
    }
    
}
