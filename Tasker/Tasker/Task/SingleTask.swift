//
//  SingleTask.swift
//  Tasker
//
//  Created by Denis Dmitriev on 12.03.2021.
//

import Foundation

class SingleTask: Task {

    var name: String
    var isCompleted: Bool 
    
    init(name: String) {
        self.name = name
        self.isCompleted = false
    }
    
    var description: String {
        return "Task \(name) type \(SingleTask.self), status \(isCompleted)"
    }
    
}
