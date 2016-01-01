//
//  TaskLog.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2015/12/30.
//  Copyright © 2015年 halhorn. All rights reserved.
//

import Foundation
import RealmSwift

class TaskLog : Object, Equatable {
    dynamic var taskId = 0
    dynamic var startedAt = NSDate(timeIntervalSince1970: 0)
    dynamic var endedAt : NSDate?

    func end() {
        self.endedAt = self.getCurrentDate()
    }
    
    // DI for testing
    var getCurrentDate = {
        return NSDate()
    }
    
    override static func ignoredProperties() -> [String] {
        return ["getCurrentDate"]
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
