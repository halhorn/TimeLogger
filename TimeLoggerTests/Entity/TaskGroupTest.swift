//
//  taskGroupGroupTest.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2015/12/30.
//  Copyright © 2015年 halhorn. All rights reserved.
//

import XCTest
@testable import TimeLogger

class TaskGroupTest: XCTestCase, ITaskGroupDelegate {
    var changedProperty : TaskGroupProperty?
    var changedValue : TaskGroup?
    
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
        let taskGroup = TaskGroup(groupId: 2, name: "name")
        XCTAssertEqual(taskGroup.groupId, 2)
        XCTAssertEqual(taskGroup.name, "name")
    }
    
    func testNameChange() {
        let taskGroup = TaskGroup(groupId: 2, name: "name")
        taskGroup.delegate = self;
        XCTAssertNil(self.changedProperty)
        XCTAssertNil(self.changedValue)
        
        taskGroup.name = "newName"
        XCTAssertEqual(taskGroup.name, "newName")
        XCTAssertEqual(self.changedProperty!, TaskGroupProperty.Name)
        XCTAssertEqual(self.changedValue!, taskGroup)
        XCTAssertEqual(self.changedValue!.name, "newName")
    }
    
    func didTaskGroupUpdate(property: TaskGroupProperty, taskGroup: TaskGroup) {
        self.changedProperty = property
        self.changedValue = taskGroup
    }

}
