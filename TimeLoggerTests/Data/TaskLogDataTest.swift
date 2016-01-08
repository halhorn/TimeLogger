//
//  TaskLogDataTest.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2016/01/02.
//  Copyright © 2016年 halhorn. All rights reserved.
//

import XCTest
import RealmSwift
@testable import TimeLogger

class TaskLogDataTest: HALTestCase {
    var taskLogData : TaskLogData?
    var time : NSTimeInterval = 1

    override func setUp() {
        super.setUp()
        taskLogData = try! TaskLogData()
        taskLogData?.getCurrentDate = {
            return NSDate(timeIntervalSince1970: self.time)
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
        self.time = 1
        let log1 = try! self.taskLogData!.create(taskId: 1)
        self.time = 10
        let log2 = try! self.taskLogData!.create(taskId: 2)
        
        let results = self.taskLogData!.readList()
        XCTAssertEqual(results![0], log1)
        XCTAssertEqual(results![1], log2)
    }
    
    func testCurrentTaskLog() {
        self.time = 1
        XCTAssertNil(self.taskLogData!.readCurrentTaskLog())
        let log1 = try! self.taskLogData!.create(taskId: 1)
        self.time = 10
        try! self.taskLogData?.end(log1)
        let log2 = try! self.taskLogData!.create(taskId: 2)
        
        XCTAssertEqual(self.taskLogData!.readCurrentTaskLog(), log2)
    }
    
    func testEnd() {
        self.time = 1
        let log1 = try! self.taskLogData!.create(taskId: 1)
        self.time = 10
        try! self.taskLogData!.end(log1)
        try! self.taskLogData!.create(taskId: 2)
        
        let results = self.taskLogData?.readList()
        XCTAssertEqual(results![0].endedAt, NSDate(timeIntervalSince1970: 10))
        XCTAssertNil(results![1].endedAt)
    }
    
    func testDelete() {
        self.time = 1
        let log1 = try! self.taskLogData!.create(taskId: 1)
        self.time = 10
        let log2 = try! self.taskLogData!.create(taskId: 2)

        let results = self.taskLogData?.readList()
        XCTAssertEqual(results![0], log1)
        XCTAssertEqual(results![1], log2)
        try! self.taskLogData!.delete(log1)
        XCTAssertEqual(results![0], log2)
    }
}
