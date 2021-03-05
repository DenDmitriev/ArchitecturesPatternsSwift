//
//  AsyncAlbumController.swift
//  VK
//
//  Created by Denis Dmitriev on 08.02.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class AsyncAlbumController: ASDKViewController<ASDisplayNode>, ASCollectionDelegate, ASCollectionDataSource {
    
    let service = VKService()
    
    var user: User!
    var albums: [Album] = []

    var collectionNode: ASCollectionNode!
    var flowLayout: UICollectionViewFlowLayout!

    override init() {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = AlbomSize.seporator * 2
        flowLayout.minimumInteritemSpacing = AlbomSize.seporator
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        collectionNode.backgroundColor = .systemBackground
        collectionNode.contentInset = UIEdgeInsets(top: AlbomSize.inset, left: AlbomSize.inset, bottom: AlbomSize.inset, right: AlbomSize.inset)
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
        loadAlbums()
        loadDefaultAlbums()
    }
    
    //MARK: - Navigation

    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        let album = albums[indexPath.item]
        let galleryASCollectionNode = AsyncGalleryController()
        galleryASCollectionNode.user = user
        galleryASCollectionNode.album = album
        navigationController?.pushViewController(galleryASCollectionNode, animated: true)
    }
    
    //MARK: - Load Gallery
    
    fileprivate func loadDefaultAlbums() {
        let defaultAlbums = ["wall" : "Стена", "profile": "Профиль"]
        var albums: [Album] = []
        defaultAlbums.forEach { (defaultAlbum) in
            service.getPhotoByAlbom(ownerId: String(user.id), albumId: defaultAlbum.key) { (photos) in
                let album = Album()
                album.id = defaultAlbum.key
                album.ownerId = self.user.id
                album.title = defaultAlbum.value
                album.size = photos.count
                let urlThumb = photos.last?.photo(.photo604)
                album.urlThumb = urlThumb
                albums.append(album)
                if albums.count == defaultAlbums.count {
                    self.appendAndUpdateAlbums(albums: albums)
                }
            }
        }
    }
    
    fileprivate func loadAlbums() {
        self.service.getAlbums(ownerID: String(self.user.id)) { (albums) in
            self.appendAndUpdateAlbums(albums: albums)
        }
    }
    
    fileprivate func appendAndUpdateAlbums(albums: [Album]) {
        var indexPaths: [IndexPath] = []
        for (index, _) in albums.enumerated() {
            let lastIndex = self.albums.count
            let newIndex = lastIndex + index
            indexPaths.append(IndexPath(item: newIndex, section: 0))
        }
        self.albums.append(contentsOf: albums)
        self.collectionNode.insertItems(at: indexPaths)
    }
    
    //MARK: - Setup Gallery
    
    private func setupUser() {
        title = "Альбомы " + user.fullName
    }
    
    private func setupCollectionView() {
        self.collectionNode.delegate = self
        self.collectionNode.dataSource = self
        collectionNode.isUserInteractionEnabled = true
    }
    
    //MARK: - ASCollectionDataSource
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let album = albums[indexPath.item]
        let nodeBlock: ASCellNodeBlock = {
            return AlbumNode(album: album)
        }
        return nodeBlock
    }
    
    
}

extension AsyncAlbumController: ASCollectionDelegateFlowLayout {
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        
        let contentSizeWidth = collectionNode.calculatedSize.width - (collectionNode.contentInset.left + collectionNode.contentInset.right)
        let width = (contentSizeWidth - ( (AlbomSize.itemsPerLine - 1) * AlbomSize.seporator)) / AlbomSize.itemsPerLine
        
        return ASSizeRange(min: CGSize(width: 0, height: 0), max: CGSize(width: width, height: width))
    }
    
}
