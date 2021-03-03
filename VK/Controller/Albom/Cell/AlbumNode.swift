//
//  AlbumNode.swift
//  VK
//
//  Created by Denis Dmitriev on 08.02.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class AlbumNode: ASCellNode {
    
    //MARK: - Nodes

    let titleTextNode = ASTextNode()
    let thumbImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        node.cornerRadius = AlbomSize.cornerRadius
        return node
    }()
    
    //MARK: - Life Circle
    
    init(album: Album) {
        super.init()
        
        automaticallyManagesSubnodes = true
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.label,
            NSAttributedString.Key.paragraphStyle : paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: AlbomSize.fontSize)
        ]
        titleTextNode.attributedText = NSAttributedString(string: album.title ?? "Альбом", attributes: attributes)
        
        guard let url = URL(string: album.urlThumb!) else { return }
        thumbImageNode.url = url
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    //MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.alignItems = .center
        verticalStack.spacing = 0
        
        //let width = (constrainedSize.max.width - Size.seporator) / 2
        let width = constrainedSize.max.width
        let heightTitle = (AlbomSize.fontSize + (AlbomSize.seporator / 2))
        thumbImageNode.style.preferredSize = CGSize(width: width , height: (width - heightTitle))
        
        
        titleTextNode.style.preferredSize = CGSize(width: width, height: heightTitle)
        titleTextNode.style.alignSelf = .center
        
        verticalStack.children = [thumbImageNode, titleTextNode]
        
        return verticalStack
    }

}
