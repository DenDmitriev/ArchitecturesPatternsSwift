//
//  AlbumsCollectionViewController.swift
//  VK
//
//  Created by Denis Dmitriev on 08.02.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

class AlbumsCollectionViewController: UICollectionViewController {

    let service = VKService()
    var photoService: PhotoService?
    
    var user: User!
    var albums: [Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUser()
        setupCollectionView()
        loadFromNetwork()
    }
    
    //MARK: - Load Gallery
    
    private func loadFromNetwork() {
        let defaultAlbums = ["wall" : "Стена", "profile": "Профиль"]
        defaultAlbums.forEach { (defaultAlbum) in
            service.getPhotoByAlbom(ownerId: String(user.id), albumId: defaultAlbum.key) { (photos) in
                let album = Album()
                album.id = defaultAlbum.key
                album.ownerId = self.user.id
                album.title = defaultAlbum.value
                album.size = photos.count
                let urlThumb = photos.last?.photo(.photo604)
                album.urlThumb = urlThumb
                self.albums.append(album)
                let indexPath = IndexPath(item: (self.albums.count - 1), section: 0)
                self.collectionView.insertItems(at: [indexPath])
            }
        }
        self.service.getAlbums(ownerID: String(self.user.id)) { (albums) in
            self.albums += albums
            print("get \(self.albums.count) albums")
            var indexPaths: [IndexPath] = []
            albums.forEach { (albom) in
                let indexPath = IndexPath(item: (self.albums.count - 1), section: 0)
                indexPaths.append(indexPath)
            }
            self.collectionView.insertItems(at: indexPaths)
        }
    }
    
    //MARK: - Setup Gallery
    
    private func setupUser() {
        title = "Альбомы " + user.fullName
    }
    
    private func setupCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: AlbomSize.seporator, left: AlbomSize.seporator, bottom: AlbomSize.seporator, right: AlbomSize.seporator)
        collectionView.isUserInteractionEnabled = true
        collectionView.register(UINib(nibName: "AlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AlbumCell")
        photoService = PhotoService(container: collectionView)
    }

    
    // MARK: - Navigation
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let album = albums[indexPath.item]
        let storyboard = UIStoryboard(name: "Gallery", bundle: nil)
        let galleryViewController = storyboard.instantiateViewController(identifier: "GalleryController") as! GalleryCollectionViewController
        galleryViewController.user = user
        galleryViewController.album = album
        navigationController?.pushViewController(galleryViewController, animated: true)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let album = albums[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCollectionViewCell
        guard let urlThumb = album.urlThumb else { return cell }
        cell.thumbImageView.image = photoService?.photo(atIndexpath: indexPath, byUrl: urlThumb)
        cell.set(album: album)
        return cell
    }

}

extension AlbumsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let width = (collectionView.contentSize.width - AlbomSize.seporator) / 2
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: AlbomSize.zero, left: AlbomSize.zero, bottom: AlbomSize.zero, right: AlbomSize.zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return AlbomSize.seporator
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return AlbomSize.seporator
    }
}
