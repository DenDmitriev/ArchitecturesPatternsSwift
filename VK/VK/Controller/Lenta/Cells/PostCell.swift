//
//  PostCell.swift
//  VK
//
//  Created by Denis Dmitriev on 14.01.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

typealias PostCell = UITableViewCell & PostSet

protocol PostSet: class {
    func configure(with viewModel: LentaModel?)
}

