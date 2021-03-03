//
//  LentaTableViewController.swift
//  1l_ДмитриевДенис
//
//  Created by Denis Dmitriev on 01.07.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

class LentaTableViewController: UITableViewController {
    
    let service = VKService()
    var photoService: PhotoService?
    lazy var realm = try! Realm()
    
    var posts: [Post] = []
    
    private var isLoading = false
    private var nextFrom = ""
    
    //MARK: - Life circle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        loadPullRefresh()
        registerCell()
        refresh()
    }
    
    
    //MARK: - Data loading
    
    fileprivate func loadPullRefresh() {
        refreshControl = UIRefreshControl()
        let color = UIColor.gray
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: color
        ]
        refreshControl?.tintColor = color
        refreshControl?.attributedTitle = NSAttributedString(string: "Загрузка...", attributes: attributes)
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl?.beginRefreshing()
    }
    
    @objc func refresh() {
        print(#function)
        let frashDate = posts.first?.date
        service.getWall(from: frashDate) { [weak self] (posts, nextFrom) in
            guard let strongSelf = self else { return }
            strongSelf.nextFrom = nextFrom
            strongSelf.refreshControl?.endRefreshing()
            print("add new \(posts.count) posts")
            strongSelf.posts = posts + strongSelf.posts
            strongSelf.tableView.reloadData()
        }
    }
    

    // MARK: - Table view data source
    
    func registerCell() {
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        tableView.register(UINib(nibName: "FooterTableViewCell", bundle: nil), forCellReuseIdentifier: "FooterTableViewCell")
        tableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "TextTableViewCell")
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
    }
    
    enum CellType: Int, CaseIterable {
        case header
        case text
        case photo
        case footer
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        posts.isEmpty ? tableView.showPlaceholder(message: "Лента не загружена") : tableView.dissmisPlaceholder()
        return posts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        let cellType = CellType(rawValue: indexPath.row) ?? .text
        var cellIdentifier = ""
        
        switch cellType {
        case .header:
            cellIdentifier = "HeaderTableViewCell"
        case .text:
            cellIdentifier = "TextTableViewCell"
        case .photo:
            cellIdentifier = "PhotoTableViewCell"
        case .footer:
            cellIdentifier = "FooterTableViewCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostCell
        
        if let cellText = cell as? TextTableViewCell {
            cellText.delegate = self
        }
        
        cell.set(post: post)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.section]
        
        guard let cellType = CellType(rawValue: indexPath.row) else { return UITableView.automaticDimension }
        
        switch cellType {
        case .text:
            let calculatTextView = UITextView(frame: self.view.bounds)
            calculatTextView.text = post.text
            var textHeight = calculatTextView.calculateViewHeightWithCurrentWidth()
            var buttonHeight: CGFloat?
            
            switch (textHeight - PostSize.text) / PostSize.text {
            case ..<1:
                buttonHeight = PostSize.zero
            default:
                if posts[indexPath.section].textMode == .short {
                    textHeight = PostSize.text
                }
                buttonHeight = PostSize.button
            }
            return textHeight + (buttonHeight ?? 0)
        case .photo:
            let photos = post.photos ?? []
            var photoHeight: CGFloat?
            switch post.photoMode {
            case .empty:
                photoHeight = 0
            case .single:
                let scale = tableView.bounds.width / (photos.first!.width ?? tableView.bounds.width)
                photoHeight = (photos.first!.height ?? tableView.bounds.width) * scale
            case .double:
                let scale = tableView.bounds.width / ((photos.first!.width ?? tableView.bounds.width) + PostSize.seporator + (photos.last!.width ?? tableView.bounds.width))
                photoHeight = (photos.first!.height ?? tableView.bounds.width) * scale
            default:
                photoHeight = PostSize.photo
            }
            return photoHeight ?? 0
        default:
            return UITableView.automaticDimension
        }
    }
}

extension LentaTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSections = indexPaths.map({ $0.section }).max(),
              maxSections > posts.count - 3,
              isLoading == false
        else { return }
        isLoading = true
        service.getWall(before: nextFrom) { [weak self] (posts, nextFrom) in
            guard let strongSelf = self else { return }
            print("Add old \(posts.count) posts")
            strongSelf.posts.append(contentsOf: posts)
            strongSelf.nextFrom = nextFrom
            let newSections = (maxSections..<(maxSections + posts.count)).map { $0 }
            strongSelf.tableView.insertSections(IndexSet(newSections), with: .automatic)
            strongSelf.isLoading = false
        }
    }
}

extension LentaTableViewController: TextTableViewCellDelegate {
    
    func updateCell(sender: TextTableViewCell) {
        print(#function)
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let post = posts[indexPath.section]
        post.textMode = (post.textMode == .short) ? .full : .short
        tableView.beginUpdates()
        sender.set(post: posts[indexPath.section])
        tableView.endUpdates()
        let scrollIndexPath = IndexPath(item: 0, section: indexPath.section)
        tableView.scrollToRow(at: scrollIndexPath, at: .top, animated: true)
    }
    
}
