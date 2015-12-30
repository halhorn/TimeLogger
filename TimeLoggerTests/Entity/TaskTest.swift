//
//  TaskTest.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2015/12/30.
//  Copyright © 2015年 halhorn. All rights reserved.
//

import XCTest

class TaskTest: XCTestCase, ITaskDelegate {
    var changedProperty : TaskProperty?
    var changedValue : Task?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testProperty() {
        let task = Task(taskId: 1, groupId: 2, name: "name", createdAt: NSDate(timeIntervalSince1970: 0))
        XCTAssertEqual(task.taskId, 1)
        XCTAssertEqual(task.groupId, 2)
        XCTAssertEqual(task.name, "name")
        XCTAssertEqual(task.createdAt, NSDate(timeIntervalSince1970: 0))
    }
    
    func testNameChange() {
        let task = Task(taskId: 1, groupId: 2, name: "name", createdAt: NSDate(timeIntervalSince1970: 0))
        task.delegate = self;
        
        self.changedProperty = nil
        self.changedValue = nil
        task.name = "newName"
        XCTAssertEqual(task.name, "newName")
        XCTAssertEqual(self.changedProperty!, TaskProperty.Name)
        XCTAssertEqual(self.changedValue!, task)
        XCTAssertEqual(self.changedValue!.name, "newName")
    }
    
    func didTaskUpdate(property: TaskProperty, task: Task) {
        self.changedProperty = property
        self.changedValue = task
    }
}
