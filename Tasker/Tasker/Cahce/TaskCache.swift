//
//  TaskCache.swift
//  Tasker
//
//  Created by Denis Dmitriev on 12.03.2021.
//

import Foundation

class TaskCache {
    
    static let shared = TaskCache()
    
    var task: CompositeTask = CompositeTask(name: "Task", tasks: [SingleTask(name: "First Task")])
    
}
