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
    
    private var viewPostsModeles = [PostModel]()
    private let viewPostsModelesFactory = PostsModelsFactory()
    
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
        let frashDate = viewPostsModeles.first?.header?.date
        service.getWall(from: frashDate) { [weak self] (posts, nextFrom) in
            guard let self = self else { return }
            self.nextFrom = nextFrom
            self.refreshControl?.endRefreshing()
            print("add new \(posts.count) posts")
            
            self.viewPostsModeles = self.viewPostsModelesFactory.constractViewModels(from: posts) + self.viewPostsModeles
            
            self.tableView.reloadData()
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
        viewPostsModeles.isEmpty ? tableView.showPlaceholder(message: "Лента не загружена") : tableView.dissmisPlaceholder()
        return viewPostsModeles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellType = CellType(rawValue: indexPath.row) ?? .text
        
        var cellIdentifier = ""
        var viewModel: LentaModel?
        
        switch cellType {
        case .header:
            cellIdentifier = "HeaderTableViewCell"
            viewModel = viewPostsModeles[indexPath.section].header
        case .text:
            cellIdentifier = "TextTableViewCell"
            viewModel = viewPostsModeles[indexPath.section].text
        case .photo:
            cellIdentifier = "PhotoTableViewCell"
            viewModel = viewPostsModeles[indexPath.section].photo
        case .footer:
            cellIdentifier = "FooterTableViewCell"
            viewModel = viewPostsModeles[indexPath.section].footer
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostCell
        cell.configure(with: viewModel)
        
        if let cellText = cell as? TextTableViewCell {
            cellText.delegate = self
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let postModel = viewPostsModeles[indexPath.section]
        
        guard let cellType = CellType(rawValue: indexPath.row) else { return UITableView.automaticDimension }
        
        switch cellType {
        case .text:
            let textModel = postModel.text
            let calculatTextView = UITextView(frame: self.view.bounds)
            calculatTextView.text = textModel?.text
            var textHeight = calculatTextView.calculateViewHeightWithCurrentWidth()
            var buttonHeight: CGFloat?
            
            switch (textHeight - Size.Post.text) / Size.Post.text {
            case ..<1:
                buttonHeight = Size.Post.zero
            default:
                if textModel?.textMode == .short {
                    textHeight = Size.Post.text
                }
                buttonHeight = Size.Post.button
            }
            return textHeight + (buttonHeight ?? 0)
        case .photo:
            let postModel = postModel.photo
            let photos = postModel?.photos ?? []
            var photoHeight: CGFloat?
            switch postModel?.photoMode {
            case .empty:
                photoHeight = 0
            case .single:
                let scale = tableView.bounds.width / (photos.first!.width ?? tableView.bounds.width)
                photoHeight = (photos.first!.height ?? tableView.bounds.width) * scale
            case .double:
                let scale = tableView.bounds.width / ((photos.first!.width ?? tableView.bounds.width) + Size.Post.seporator + (photos.last!.width ?? tableView.bounds.width))
                photoHeight = (photos.first!.height ?? tableView.bounds.width) * scale
            default:
                photoHeight = Size.Post.photo
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
              maxSections > viewPostsModeles.count - 3,
              isLoading == false
        else { return }
        isLoading = true
        service.getWall(before: nextFrom) { [weak self] (posts, nextFrom) in
            guard let self = self else { return }
            print("Add old \(posts.count) posts")
            self.viewPostsModeles.append(contentsOf: self.viewPostsModelesFactory.constractViewModels(from: posts))
            self.nextFrom = nextFrom
            let newSections = (maxSections..<(maxSections + posts.count)).map { $0 }
            self.tableView.insertSections(IndexSet(newSections), with: .automatic)
            self.isLoading = false
        }
    }
}

extension LentaTableViewController: TextTableViewCellDelegate {
    
    func updateCell(sender: TextTableViewCell) {
        print(#function)
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        let textModel = viewPostsModeles[indexPath.section].text
        let textMode = viewPostsModeles[indexPath.section].text?.textMode
        textModel?.textMode = (textMode == .short) ? .full : .short
        viewPostsModeles[indexPath.section].text = textModel
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        let scrollIndexPath = IndexPath(item: 0, section: indexPath.section)
        tableView.scrollToRow(at: scrollIndexPath, at: .top, animated: true)
    }
    
}
