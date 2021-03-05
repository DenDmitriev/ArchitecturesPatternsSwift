//
//  PhotoTableViewCell.swift
//  VK
//
//  Created by Denis Dmitriev on 02.02.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell, PostSet {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photoService: PhotoService?
    var photos: [Photo] = []
    var photoMode: Post.AlbomMode = .empty
    
    //MARK: - Life circle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configurate()
    }

    //MARK: - Setup cell
    
    func configure(with viewModel: LentaModel?) {
        guard let photoModel = viewModel as? LentaPhotoModel else { return }
        self.photos = photoModel.photos
        photoMode = photoModel.photoMode
        
    }
    
    private func reset() {
        photos.removeAll()
        collectionView.reloadData()
    }
    
    fileprivate func configurate() {
        photoService = PhotoService(container: collectionView)
        collectionView.register(UINib(nibName: "PhotosMiniCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "item")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layoutMargins = UIEdgeInsets(top: PostSize.zero, left: PostSize.zero, bottom: PostSize.zero, right: PostSize.zero)
        collectionView.contentInset = UIEdgeInsets(top: PostSize.zero, left: PostSize.zero, bottom: PostSize.zero, right: PostSize.zero)
        
    }
}

extension PhotoTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! PhotosMiniCollectionViewCell
        guard let url = photos[indexPath.item].photo(.photo604) else { return cell }
        cell.imagePhotoView.image = photoService?.photo(atIndexpath: indexPath, byUrl: url)
        return cell
    }
    
}

extension PhotoTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: PostSize.zero, left: PostSize.zero, bottom: PostSize.zero, right: PostSize.zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return PostSize.seporator
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return PostSize.seporator
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        var width = collectionView.frame.width
        
        switch photoMode {
        case .empty:
            height = 0
        case .single:
            let scale = self.bounds.width / (photos.first!.width ?? self.bounds.width)
            height = (photos.first!.height ?? self.bounds.width) * scale
            width = self.bounds.width
        case .double:
            let scale = self.bounds.width / ((photos.first!.width ?? self.bounds.width) + PostSize.seporator + (photos.last!.width ?? self.bounds.width))
            height = (photos.first!.height ?? self.bounds.height) * scale
            width = scale * (photos[indexPath.item].width ?? self.bounds.width)
        default:
            height = PostSize.photo
            width = (photos[indexPath.item].aspectRatio ?? 1) * height
        }
        
        return CGSize(width: width, height: height.rounded(.down))
    }
}
