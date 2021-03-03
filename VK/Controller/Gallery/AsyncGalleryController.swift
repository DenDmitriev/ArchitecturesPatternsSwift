//
//  AsyncGalleryController.swift
//  VK
//
//  Created by Denis Dmitriev on 09.02.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class AsyncGalleryController: ASDKViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDataSource {
    
    let service = VKService()
    
    var user: User!
    var album: Album!
    var photos: [Photo] = []
    var size: Photo.Size = .photo130
    
    var itemsPerLine: CGFloat {
        let screenSize = UIScreen.main.bounds
        let items = screenSize.width / Photo().size(size)
        return items.rounded(.up)
    }

    var collectionNode: ASCollectionNode!
    var flowLayout: UICollectionViewFlowLayout!
    
    override init() {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = GallerySize.seporator
        flowLayout.minimumInteritemSpacing = GallerySize.seporator
        
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        collectionNode.backgroundColor = .systemBackground
        collectionNode.contentInset = UIEdgeInsets(top: GallerySize.inset, left: GallerySize.inset, bottom: GallerySize.inset, right: GallerySize.inset)
        super.init(node: collectionNode)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUser()
        setupCollectionView()
        loadFromNetwork()
    }
    
    //MARK: - Load Gallery
    
    private func loadFromNetwork() {
        guard let albumId = album.id else { return }
        service.getPhotoByAlbom(ownerId: String(user.id), albumId: String(albumId)) { (photos) in
            self.photos = photos
            print("get \(self.photos.count) photos")
            self.collectionNode.reloadData()
        }
    }
    
    //MARK: - Setup Gallery
    
    private func setupUser() {
        title = album.title
    }
    
    private func setupCollectionView() {
        self.collectionNode.delegate = self
        self.collectionNode.dataSource = self
        self.collectionNode.isUserInteractionEnabled = true
    }
    
    // MARK: - Navigation
    
    //MARK: - ASCollectionDataSource
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let photo = photos[indexPath.item]
        let nodeBlock: ASCellNodeBlock = {
            return GalleryNode(photo: photo)
        }
        return nodeBlock
    }
}

extension AsyncGalleryController: ASCollectionDelegateFlowLayout {
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        
        let contentSizeWidth = collectionNode.calculatedSize.width - (collectionNode.contentInset.left + collectionNode.contentInset.right)
        let spaceWidth = contentSizeWidth - ((itemsPerLine - 1) * GallerySize.seporator)
        let width = (spaceWidth / itemsPerLine).rounded(.down)
        
        return ASSizeRange(min: CGSize(width: 0, height: 0), max: CGSize(width: width, height: width))
    }
    
}
