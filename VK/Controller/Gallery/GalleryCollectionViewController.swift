//
//  GalleryCollectionViewController.swift
//  VK
//
//  Created by Denis Dmitriev on 05.02.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

class GalleryCollectionViewController: UICollectionViewController {
    
    let service = VKService()
    var photoService: PhotoService?
    
    var user: User!
    var album: Album!
    var photos: [Photo] = []
    var size: Photo.Size = .photo130
    
    var itemsPerLine: CGFloat {
        let screenSize = UIScreen.main.bounds
        let items = screenSize.width / Photo().size(size)
        return items.rounded(.up)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUser()
        setupCollectionView()
        loadFromNetwork()
    }
    
    //MARK: - Load Gallery
    
    private func loadFromNetwork() {
//        service.getPhotos(ownerID: String(user.id)) { (photos) in
//            self.photos = photos
//            print("get \(self.photos.count) photos")
//            self.collectionView.reloadData()
//        }
        guard let albumId = album.id else { return }
        service.getPhotoByAlbom(ownerId: String(user.id), albumId: String(albumId)) { (photos) in
            self.photos = photos
            print("get \(self.photos.count) photos")
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Setup Gallery
    
    private func setupUser() {
        title = album.title
    }
    
    private func setupCollectionView() {
        collectionView.isUserInteractionEnabled = true
        collectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        photoService = PhotoService(container: collectionView)
    }

    
    // MARK: - Navigation
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? GalleryCollectionViewCell,
            let photo = cell.imagePhotoView.image
        else { return }
        let caruselViewController = PhotosViewController(nibName: "PhotosViewController", bundle: nil)
        caruselViewController.setup(photos, photos[indexPath.row], photo, indexPath.item)
        navigationController?.pushViewController(caruselViewController, animated: true)
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! GalleryCollectionViewCell
        guard let url = photos[indexPath.row].photo(size) else { return cell }
        cell.imagePhotoView.image = photoService?.photo(atIndexpath: indexPath, byUrl: url)
        return cell
    }

}

extension GalleryCollectionViewController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let space = collectionView.contentSize.width - ((itemsPerLine - 1) * GallerySize.seporator)
        let width = space / itemsPerLine
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: GallerySize.zero, left: GallerySize.zero, bottom: GallerySize.zero, right: GallerySize.zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return GallerySize.seporator
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return GallerySize.seporator
    }
}
