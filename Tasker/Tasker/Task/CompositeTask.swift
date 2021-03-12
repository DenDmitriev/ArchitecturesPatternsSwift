//
//  CompositeTask.swift
//  Tasker
//
//  Created by Denis Dmitriev on 12.03.2021.
//

import Foundation

class CompositeTask: Task {
    
    var name: String
    var isCompleted: Bool
    
    var tasks: [Task]
    
    init(name: String, tasks: [Task]) {
        self.name = name
        self.tasks = tasks
        self.isCompleted = false
    }
    
    init(from task: Task) {
        self.name = task.name
        self.isCompleted = task.isCompleted
        self.tasks = []
    }
    
    var description: String {
        return "Task \(name) type \(CompositeTask.self), contains\n \(tasks.compactMap { $0.description }.joined(separator: "\n"))" + "\n"
    }

}
