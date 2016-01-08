//
//  LoggingModelTest.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2016/01/04.
//  Copyright © 2016年 halhorn. All rights reserved.
//

import XCTest
import RealmSwift
@testable import TimeLogger

class LoggingModelTest: HALTestCase {
    var taskData : TaskData?
    var taskLogData : TaskLogData?
    
    override func setUp() {
        super.setUp()
        self.taskData = try! TaskData()
        self.taskLogData = try! TaskLogData()
    }
    
    override func tearDown() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        super.tearDown()
    }

    func testInit() {
        try! self.taskData?.create(name: "task1")
        try! self.taskData?.create(name: "task2")
        try! self.taskLogData?.create(taskId: 1)
        let model = try! LoggingModel()
        XCTAssertEqual(model.taskList!.count, 2)
        XCTAssertEqual(model.taskList![0].name, "task1")
        XCTAssertEqual(model.taskList![1].name, "task2")
        XCTAssertEqual(model.taskLogList!.count, 1)
        XCTAssertEqual(model.taskLogList![0].taskId, 1)
        XCTAssertEqual(model.currentTaskId, 1)
    }
    
    func testEndCurrentTask() {
        try! self.taskData?.create(name: "task1")
        try! self.taskData?.create(name: "task2")
        try! self.taskLogData?.create(taskId: 1)
        let model = try! LoggingModel()
        XCTAssertEqual(model.currentTaskId, 1)
        try! model.endCurrentTask()
        XCTAssertNil(model.currentTaskId)
        XCTAssertNotNil(model.taskLogList![0])
        try! model.endCurrentTask()
        XCTAssertNil(model.currentTaskId)
        XCTAssertNotNil(model.taskLogList![0])
    }
    
    func testStartNewTask() {
        try! self.taskData?.create(name: "task1")
        try! self.taskData?.create(name: "task2")
        try! self.taskLogData?.create(taskId: 1)
        let model = try! LoggingModel()
        XCTAssertEqual(model.currentTaskId, 1)
        try! model.startNewTask(2)
        XCTAssertEqual(model.currentTaskId, 2)
    }
}
