//
//  GalleryNode.swift
//  VK
//
//  Created by Denis Dmitriev on 09.02.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class GalleryNode: ASCellNode {
    
    //MARK: - Nodes

    let photoImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    //MARK: - Life Circle
    
    init(photo: Photo) {
        super.init()
        automaticallyManagesSubnodes = true
        guard
            let urlString = photo.photo(.photo130),
            let url = URL(string: urlString)
        else { return }
        photoImageNode.url = url
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    //MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let verticalStack = ASStackLayoutSpec.vertical()
        
        let width = constrainedSize.max.width
        photoImageNode.style.preferredSize = CGSize(width: width , height: width)
        
        verticalStack.children = [photoImageNode]
        
        return verticalStack
    }

}
