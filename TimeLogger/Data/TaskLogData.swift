//
//  TaskLogData.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2016/01/02.
//  Copyright © 2016年 halhorn. All rights reserved.
//

import Foundation
import RealmSwift

class TaskLogData {
    var realm : Realm?
    
    init() throws {
        try self.realm = Realm()
    }
    
    func create(taskId taskId: Int) throws -> TaskLog {
        let taskLog = TaskLog(value: ["taskId": taskId, "startedAt": getCurrentDate()])
        try realm?.write {
            realm?.add(taskLog)
        }
        return taskLog
    }

    func readList() -> Results<TaskLog>? {
        return self.realm?.objects(TaskLog)
    }
    
    func end(taskLog : TaskLog) throws -> TaskLog {
        try realm?.write {
            taskLog.endedAt = getCurrentDate()
        }
        return taskLog
    }
    
    func delete(taskLog : TaskLog) throws {
        try realm?.write {
            realm?.delete(taskLog)
        }
    }
    
    // for DI
    var getCurrentDate = {
        return NSDate()
    }
}
