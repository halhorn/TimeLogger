//
//  Task.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2015/12/30.
//  Copyright © 2015年 halhorn. All rights reserved.
//

import RealmSwift

class Task : Object, Equatable {
    dynamic var taskId = 0
    dynamic var name = ""
    dynamic var color = "#000000"
    dynamic var createdAt = NSDate(timeIntervalSince1970: 0)

    override static func primaryKey() -> String? {
        return "taskId"
    }
}

func == (left : Task, right: Task) -> Bool {
    return left.taskId == right.taskId
}

func != (left : Task, right: Task) -> Bool {
    return !(left == right)
}
