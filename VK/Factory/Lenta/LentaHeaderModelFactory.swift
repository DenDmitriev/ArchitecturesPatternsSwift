//
//  LentaHeaderModelFactory.swift
//  VK
//
//  Created by Denis Dmitriev on 04.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit
import Kingfisher

class LentaHeaderModelFactory: LentaModelFactory {

    func constractViewModel(from post: Post) -> LentaModel {
        setSource(for: post)
        //let date = LentaHeaderModelFactory.dateFormatter.string(from: Date(timeIntervalSince1970: post.date))
        let date = post.date
        let name = getAuthor(from: post)
        let avatar = getAvatar(from: post)
        
        return LentaHeaderModel(avatar: avatar, name: name, date: date)
    }
    
    //MARK: - Private
    
    private enum Source {
        case user
        case group
    }
    
    private var source: Source = .user
    
    private func setSource(for post: Post) {
        let userIsExists = post.user != nil
        source = userIsExists ? .user : .group
    }
    
    private func getAvatar(from post: Post) -> URL {
        var avatar: String? = ""
        switch source {
        case .user:
            avatar = post.user?.avatar
        case .group:
            avatar = post.group?.avatar
        }
        let url = URL(string: avatar ?? "")!
        return url
    }
    
    private func getAuthor(from post: Post) -> String {
        switch source {
        case .user:
            let user = post.user
            return (user?.name ?? "") + " " + (user?.lastname ?? "")
        case .group:
            let group = post.group
            return group?.title ?? ""
        }
    }
    
}
