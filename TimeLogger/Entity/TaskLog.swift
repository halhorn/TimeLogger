//
//  TaskLog.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2015/12/30.
//  Copyright © 2015年 halhorn. All rights reserved.
//

import Foundation

enum TaskLogProperty {
    case TaskId
    case GroupId
    case StartedAt
    case EndedAt
}

protocol ITaskLogDelegate : class {
    func didTaskLogUpdate(property : TaskLogProperty, taskLog : TaskLog)
}


class TaskLog : Equatable {
    private(set) var taskId : Int
    private(set) var groupId : Int
    private(set) var startedAt : NSDate
    private(set) var endedAt : NSDate? {
        didSet (value) {
            self.delegate?.didTaskLogUpdate(.EndedAt, taskLog: self)
        }
    }
    
    weak var delegate : ITaskLogDelegate?
    
    init(taskId : Int, groupId : Int, startedAt : NSDate, endedAt : NSDate? = nil) {
        self.taskId = taskId
        self.groupId = groupId
        self.startedAt = startedAt
        self.endedAt = endedAt
    }
    
    func finalize() {
        self.endedAt = self.getCurrentDate()
    }
    
    // DI for testing
    var getCurrentDate = {
        return NSDate()
    }
}

func == (left : TaskLog, right: TaskLog) -> Bool {
    return left.taskId == right.taskId
        && left.startedAt == right.startedAt
        && left.endedAt == right.endedAt
}

func != (left : TaskLog, right: TaskLog) -> Bool {
    return !(left == right)
}
