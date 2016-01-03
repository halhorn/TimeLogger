//
//  LoggingModel.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2016/01/03.
//  Copyright © 2016年 halhorn. All rights reserved.
//

import Foundation
import RealmSwift

class LoggingModel {
    private var taskData : TaskData?
    private var taskLogData : TaskLogData?
    var taskList : Results<Task>?
    var taskLogList : Results<TaskLog>?
    var currentTaskId : Int? {
        return self.taskLogData?.readCurrentTaskLog()?.taskId
    }
    
    init() throws {
        self.taskData = try TaskData()
        self.taskLogData = try TaskLogData()
        self.taskList = self.taskData?.readList()
        self.taskLogList = self.taskLogData?.readList()
    }
    
    func endCurrentTask() throws {
        if let currentTaskLog = self.taskLogData?.readCurrentTaskLog() {
            try self.taskLogData?.end(currentTaskLog)
        }
    }
    
    func startNewTask(taskId : Int) throws {
        try self.endCurrentTask()
        try self.taskLogData?.create(taskId: taskId)
    }
}