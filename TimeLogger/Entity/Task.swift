//
//  Task.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2015/12/30.
//  Copyright © 2015年 halhorn. All rights reserved.
//

import Foundation

enum TaskProperty {
    case TaskId
    case GroupId
    case Name
    case CreatedAt
}

protocol ITaskDelegate : class {
    func didTaskUpdate(property : TaskProperty, task : Task)
}

class Task : Equatable {
    private(set) var taskId : Int
    private(set) var groupId : Int
    var name : String {
        didSet (value) {
            self.delegate?.didTaskUpdate(.Name, task: self)
        }
    }
    private(set) var createdAt : NSDate
    weak var delegate : ITaskDelegate?
    
    init(taskId : Int, groupId : Int, name : String, createdAt : NSDate) {
        self.taskId = taskId
        self.groupId = groupId
        self.name = name
        self.createdAt = createdAt
    }
}

func == (left : Task, right: Task) -> Bool {
    return left.taskId == right.taskId
}

func != (left : Task, right: Task) -> Bool {
    return !(left == right)
}
