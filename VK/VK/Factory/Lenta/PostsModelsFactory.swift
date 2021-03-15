//
//  PostsModelsFactory.swift
//  VK
//
//  Created by Denis Dmitriev on 05.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

class PostsModelsFactory {
    
    enum Structure {
        case header
        case text
        case photo
        case footer
    }
    
    func constractViewModels(from posts: [Post]) -> [PostModel] {
        var postModels = [PostModel]()
        posts.forEach { post in
            let headerViewModel = getPostElement(in: post, for: .header) as! LentaHeaderModel
            let textViewModel = getPostElement(in: post, for: .text) as! LentaTextModel
            let photoViewModel = getPostElement(in: post, for: .photo) as! LentaPhotoModel
            let footerViewModel = getPostElement(in: post, for: .footer) as! LentaFooterModel
            
            let postModel = PostModel(header: headerViewModel, text: textViewModel, photo: photoViewModel, footer: footerViewModel)
            
            postModels.append(postModel)
            
        }
        
        return postModels
    }
    
    private func getPostElement(in post: Post, for element: Structure) -> LentaModel {
        switch element {
        case .header:
            let lentaHeaderModelFactory = LentaHeaderModelFactory()
            let headerViewModel = lentaHeaderModelFactory.constractViewModel(from: post)
            return headerViewModel
        case .text:
            let lentaTextModelFactory = LentaTextModelFactory()
            let textViewModel = lentaTextModelFactory.constractViewModel(from: post)
            return textViewModel
        case .photo:
            let lentaPhotoHeaderModelFactory = LentaPhotoModelFactory()
            let photoViewModel = lentaPhotoHeaderModelFactory.constractViewModel(from: post)
            return photoViewModel
        case .footer:
            let lentaFooterModelFactory = LentaFooterModelFactory()
            let footerViewModel = lentaFooterModelFactory.constractViewModel(from: post)
            return footerViewModel
        }
    }
    
    func getViewModel(from postModel: PostModel, for element: Structure) -> LentaModel? {
        switch element {
        case .header:
            return postModel.header
        case .text:
            return postModel.text
        case .photo:
            return postModel.photo
        case .footer:
            return postModel.footer
        }
    }
}
