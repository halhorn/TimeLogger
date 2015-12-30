//
//  TaskLogTest.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2015/12/30.
//  Copyright © 2015年 halhorn. All rights reserved.
//

import XCTest

class TaskLogTest: XCTestCase, ITaskLogDelegate {
    var changedProperty : TaskLogProperty?
    var changedValue : TaskLog?
    
    override func setUp() {
        super.setUp()
        self.changedProperty = nil
        self.changedValue = nil
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProperty() {
        let task = TaskLog(taskId: 1, groupId: 2, startedAt: NSDate(timeIntervalSince1970: 0), endedAt: NSDate(timeIntervalSince1970: 10))
        XCTAssertEqual(task.taskId, 1)
        XCTAssertEqual(task.groupId, 2)
        XCTAssertEqual(task.startedAt, NSDate(timeIntervalSince1970: 0))
        XCTAssertEqual(task.endedAt, NSDate(timeIntervalSince1970: 10))
    }
    
    func testNameChange() {
        let taskLog = TaskLog(taskId: 1, groupId: 2, startedAt: NSDate(timeIntervalSince1970: 0))
        taskLog.getCurrentDate = {
            return NSDate(timeIntervalSince1970: 10);
        };
        taskLog.delegate = self;
        XCTAssertNil(self.changedProperty)
        XCTAssertNil(self.changedValue)
        
        taskLog.finalize()
        XCTAssertEqual(taskLog.endedAt, NSDate(timeIntervalSince1970: 10))
        XCTAssertEqual(self.changedProperty!, TaskLogProperty.EndedAt)
        XCTAssertEqual(self.changedValue!, taskLog)
        XCTAssertEqual(self.changedValue!.endedAt, NSDate(timeIntervalSince1970: 10))
    }
    
    func didTaskLogUpdate(property: TaskLogProperty, taskLog: TaskLog) {
        self.changedProperty = property
        self.changedValue = taskLog
    }
}
