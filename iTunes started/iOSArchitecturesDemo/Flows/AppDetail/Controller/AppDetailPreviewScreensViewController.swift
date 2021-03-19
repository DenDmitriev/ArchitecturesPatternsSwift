//
//  AppDetailPreviewScreensViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Denis Dmitriev on 17.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailPreviewScreensViewController: UIViewController {
    
    private let previews: [String]
    private var images: [UIImage] = []
    
    private let imageDownloader = ImageDownloader()
    
    private var appDetailPreviewScreensView: AppDetailPreviewScreensView {
        return self.view as! AppDetailPreviewScreensView
    }
    
    init(previews: [String]) {
        self.previews = previews
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life circle
    
    override func loadView() {
        self.view = AppDetailPreviewScreensView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congureUI()
    }
    
    //MARK: - Private methods
    
    private func congureUI() {
        previews.enumerated().forEach { (index, url) in
            images.append(UIImage())
            downloadScren(by: index)
        }
        
        appDetailPreviewScreensView.previewCollectionView.delegate = self
        appDetailPreviewScreensView.previewCollectionView.dataSource = self

        appDetailPreviewScreensView.previewCollectionView.register(PreviewCollectionViewCell.self, forCellWithReuseIdentifier: PreviewCollectionViewCell.identifier)
        
    }
    
    private func downloadScren(by index: Int) {
        guard let url = URL(string: previews[index]) else { return}

        self.imageDownloader.getImage(fromUrl: url) { [weak self] (image, error) in
            guard let self = self else { return }
            guard let image = image else { return }
            self.images[index] = image
            DispatchQueue.main.async {
                self.updateLayout(by: index, with: self.sizeToFitCollectionView(for: image))
                self.appDetailPreviewScreensView.previewCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
        }
    }
    
    //MARK: Layout methods
    
    fileprivate func updateLayout(by index: Int, with sizeItem: CGSize) {
        if index == 1 {
            self.appDetailPreviewScreensView.previewCollectionView.heightAnchor.constraint(equalToConstant: sizeItem.height).isActive = true
        }
    }
    
    private func sizeToFitCollectionView(for image: UIImage) -> CGSize {
        guard image.size != CGSize(width: 0, height: 0) else { return CGSize(width: 0, height: 0) }
        
        let width = (appDetailPreviewScreensView.previewCollectionView.bounds.width - Layout.space) / Layout.itemsPerLine
        let aspect = image.size.width / image.size.height
        let height = width / aspect
        return CGSize(width: width, height: height)
    }
    
}

extension AppDetailPreviewScreensViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = appDetailPreviewScreensView.previewCollectionView.dequeueReusableCell(withReuseIdentifier: PreviewCollectionViewCell.identifier, for: indexPath) as! PreviewCollectionViewCell
        let image = images[indexPath.item]
        cell.previewImageView.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let page = indexPath.item
        let previewScreensPageViewController = PreviewScreensPageViewController(with: images, transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        previewScreensPageViewController.startPageIndex = page
        navigationController?.pushViewController(previewScreensPageViewController, animated: true)
    }
    
}

extension AppDetailPreviewScreensViewController: UICollectionViewDelegateFlowLayout {

    private enum Layout {
        static let itemsPerLine: CGFloat = 1.5
        static let space: CGFloat = 12
        static let zero: CGFloat = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Layout.zero, left: Layout.zero, bottom: Layout.zero, right: Layout.zero)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeToFitCollectionView(for: images[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.space
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.space
    }
}
