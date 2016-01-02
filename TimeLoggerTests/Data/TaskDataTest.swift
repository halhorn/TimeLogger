//
//  TaskDataTest.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2016/01/01.
//  Copyright © 2016年 halhorn. All rights reserved.
//

import XCTest
import RealmSwift
@testable import TimeLogger

class TaskDataTest: HALTestCase {
    var taskData : TaskData?

    override func setUp() {
        super.setUp()
        self.taskData = try! TaskData()
        self.taskData?.getCurrentDate = {
            return NSDate(timeIntervalSince1970: 1)
        }
    }
    
    override func tearDown() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        super.tearDown()
    }
    
    func testCreate() {
        let task1 = try! self.taskData!.create(name: "hoge")
        XCTAssertEqual(task1.taskId, 1)
        XCTAssertEqual(task1.name, "hoge")
        XCTAssertEqual(task1.color, "#f0fff0")
        XCTAssertEqual(task1.createdAt, NSDate(timeIntervalSince1970: 1))
        
        let task2 = try! self.taskData!.create(name: "fuga", color: "#000000")
        XCTAssertEqual(task2.taskId, 2)
        XCTAssertEqual(task2.name, "fuga")
        XCTAssertEqual(task2.color, "#000000")
        XCTAssertEqual(task2.createdAt, NSDate(timeIntervalSince1970: 1))
        
        let stored1 = self.taskData!.read(1)!
        XCTAssertEqual(stored1.taskId, 1)
        XCTAssertEqual(stored1.name, "hoge")
        XCTAssertEqual(stored1.color, "#f0fff0")
        XCTAssertEqual(stored1.createdAt, NSDate(timeIntervalSince1970: 1))
        
        let stored2 = self.taskData!.read(2)!
        XCTAssertEqual(stored2.taskId, 2)
        XCTAssertEqual(stored2.name, "fuga")
        XCTAssertEqual(stored2.color, "#000000")
        XCTAssertEqual(stored2.createdAt, NSDate(timeIntervalSince1970: 1))
    }
    
    func testReadList() {
        let task1 = try! self.taskData!.create(name: "hoge")
        
        let results = self.taskData?.readList()
        XCTAssertEqual(results?.count, 1)
        XCTAssertEqual(results?[0], task1)
        
        let task2 = try! self.taskData!.create(name: "fuga", color: "#000000")
        XCTAssertEqual(results?.count, 2)
        XCTAssertEqual(results?[0], task1)
        XCTAssertEqual(results?[1], task2)
    }
    
    func testUpdateName() {
        let task1 = try! self.taskData!.create(name: "hoge")
        let task2 = try! self.taskData!.create(name: "fuga", color: "#000000")
        
        try! self.taskData!.updateName("moge", task: task1)
        XCTAssertEqual(task1.name, "moge")
        XCTAssertEqual(task2.name, "fuga")
        XCTAssertEqual(self.taskData!.read(1)!.name, "moge")
        XCTAssertEqual(self.taskData!.read(2)!.name, "fuga")
    }
    
    func testUpdateColor() {
        let task1 = try! self.taskData!.create(name: "hoge", color: "#111111")
        let task2 = try! self.taskData!.create(name: "fuga", color: "#000000")
        
        try! self.taskData!.updateColor("#222222", task: task1)
        XCTAssertEqual(task1.color, "#222222")
        XCTAssertEqual(task2.color, "#000000")
        XCTAssertEqual(self.taskData!.read(1)!.color, "#222222")
        XCTAssertEqual(self.taskData!.read(2)!.color, "#000000")
    }
    
    func testDelete() {
        let task1 = try! self.taskData!.create(name: "hoge", color: "#111111")
        try! self.taskData!.create(name: "fuga", color: "#000000")
        
        try! self.taskData!.delete(task1)
        XCTAssertNil(self.taskData!.read(1))
        XCTAssertNotNil(self.taskData!.read(2))
    }
}
