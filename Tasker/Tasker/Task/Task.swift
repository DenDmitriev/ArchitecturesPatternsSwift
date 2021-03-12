//
//  Task.swift
//  Tasker
//
//  Created by Denis Dmitriev on 12.03.2021.
//

import Foundation

protocol Task {
    var name: String { get set }
    var isCompleted: Bool { get set }
    
    var description: String { get }
}
