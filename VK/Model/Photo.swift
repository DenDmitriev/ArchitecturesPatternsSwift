//
//  Photo.swift
//  VK
//
//  Created by Denis Dmitriev on 12.01.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

final class Photo: Decodable {
    var url: [CodingKeys : String] = [:]
    var id: Int?
    var albumId: Int?
    var height: CGFloat?
    var width: CGFloat?
    
    var aspectRatio: CGFloat? {
        if let height = height, let width = width {
            return width / height
        } else {
            return nil
        }
    }
    
    //MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "owner_id"
        case albomId = "album_id"
        case height
        case width
        
        case photo75 = "photo_75"
        case photo130 = "photo_130"
        case photo604 = "photo_604"
        case photo807 = "photo_807"
        case photo1280 = "photo_1280"
        case photo2560 = "photo_2560"
    }
    
    //MARK: - Decodable
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.albumId = try? container.decode(Int.self, forKey: .albomId)

        self.height = try? container.decode(CGFloat.self, forKey: .height)
        self.width = try? container.decode(CGFloat.self, forKey: .width)

        let sizes: [CodingKeys] = [ .photo75, .photo130, .photo604, .photo807, .photo1280, .photo2560]
        sizes.forEach { key in
            guard let value = try? container.decode(String.self, forKey: key) else { return }
            self.url[key] = value
        }
    }
    
    //MARK: - Methods
    
    enum Size: CGFloat, CaseIterable {
        case photo75 = 75
        case photo130 = 130
        case photo604 = 604
        case photo807 = 807
        case photo1280 = 1280
        case photo2560 = 2560
    }
    
    func photo(_ height: Size) -> String? {
        var key: CodingKeys?
        switch height.rawValue {
        case Size.photo1280.rawValue...Size.photo2560.rawValue:
            guard url[.photo2560] != nil else { fallthrough }
            key = .photo2560
        case Size.photo807.rawValue...Size.photo1280.rawValue:
            guard url[.photo1280] != nil else { fallthrough }
            key = .photo1280
        case Size.photo604.rawValue...Size.photo807.rawValue:
            guard url[.photo807] != nil else { fallthrough }
            key = .photo807
        case Size.photo130.rawValue...Size.photo604.rawValue:
            guard url[.photo604] != nil else { fallthrough }
            key = .photo604
        case Size.photo75.rawValue...Size.photo130.rawValue:
            guard url[.photo130] != nil else { fallthrough }
            key = .photo130
        case ...Size.photo75.rawValue:
            guard url[.photo75] != nil else { fallthrough }
            key = .photo75
        default:
            key = .photo75
        }
        return url[key!]
    }
    
    func size(_ size: Size) -> CGFloat {
        return size.rawValue
    }
    
}


