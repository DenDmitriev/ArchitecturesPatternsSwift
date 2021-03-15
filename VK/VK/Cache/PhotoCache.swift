//
//  PhotoCache.swift
//  VK
//
//  Created by Denis Dmitriev on 29.01.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

class PhotoCache {
    
    static let shared = PhotoCache()
    
    var images = [String : UIImage]()
}
