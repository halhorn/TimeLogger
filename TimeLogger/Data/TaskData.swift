//
//  TaskData.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2016/01/01.
//  Copyright © 2016年 halhorn. All rights reserved.
//

import Foundation
import RealmSwift

class TaskData {
    var realm : Realm?
    
    init() throws {
        try self.realm = Realm()
    }
    
    func create(name name : String, color : String = "#f0fff0") throws -> Task {
        let maxId : Int = readList()?.sorted("taskId", ascending: false).first?.taskId ?? 0
        let task = Task(value: ["taskId": maxId + 1, "name": name, "color": color, "createdAt" : getCurrentDate()])
        try realm?.write {
            realm?.add(task)
        }
        return task
    }
    
    func read(taskId : Int) -> Task? {
        let predicate = NSPredicate(format: "taskId = %d", taskId)
        return self.realm?.objects(Task).filter(predicate).first
    }
    
    func readList() -> Results<Task>? {
        return self.realm?.objects(Task)
    }
    
    func updateName(name : String, task : Task) throws -> Task {
        try realm?.write {
            task.name = name
        }
        return task
    }

    func updateColor(color : String, task : Task) throws -> Task {
        try realm?.write {
            task.color = color
        }
        return task
    }

    func delete(task : Task) throws {
        try realm?.write {
            realm?.delete(task)
        }
    }
    
    // for DI
    var getCurrentDate = {
        return NSDate()
    }
}
