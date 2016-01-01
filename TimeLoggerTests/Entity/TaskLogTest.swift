//
//  TaskLogTest.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2015/12/30.
//  Copyright © 2015年 halhorn. All rights reserved.
//

import XCTest
import RealmSwift
@testable import TimeLogger

class TaskLogTest: HALTestCase {
    var token : NotificationToken?
    
    func testProperty() {
        let taskLog = TaskLog(value: ["taskId": 1, "startedAt": NSDate(timeIntervalSince1970: 1), "endedAt": NSDate(timeIntervalSince1970: 10)])
        XCTAssertEqual(taskLog.taskId, 1)
        XCTAssertEqual(taskLog.startedAt, NSDate(timeIntervalSince1970: 1))
        XCTAssertEqual(taskLog.endedAt, NSDate(timeIntervalSince1970: 10))
    }
    
    func testStore() {
        
        var notificationCalled = false;
        let taskLog = TaskLog(value: ["taskId": 1, "startedAt": NSDate(timeIntervalSince1970: 1)])
        taskLog.getCurrentDate = {
            return NSDate(timeIntervalSince1970: 10)
        }
        
        let realm2 = try! Realm();
        token = realm2.addNotificationBlock { (notification, realm) -> Void in
            notificationCalled = true;
        }
        let realm = try! Realm();
        try! realm.write {
            realm.add(taskLog)
            taskLog.end()
        }
        XCTAssertEqual(realm.objects(TaskLog).first, taskLog)
        XCTAssertEqual(realm.objects(TaskLog).first!.endedAt, NSDate(timeIntervalSince1970: 10))
        XCTAssertTrue(notificationCalled)
    }
    
    func testEqual() {
        XCTAssertEqual(
            TaskLog(value: ["taskId": 1, "startedAt": NSDate(timeIntervalSince1970: 0), "endedAt": NSDate(timeIntervalSince1970: 10)]),
            TaskLog(value: ["taskId": 1, "startedAt": NSDate(timeIntervalSince1970: 0), "endedAt": NSDate(timeIntervalSince1970: 10)])
        )
        XCTAssertNotEqual(
            TaskLog(value: ["taskId": 2, "startedAt": NSDate(timeIntervalSince1970: 0), "endedAt": NSDate(timeIntervalSince1970: 10)]),
            TaskLog(value: ["taskId": 1, "startedAt": NSDate(timeIntervalSince1970: 0), "endedAt": NSDate(timeIntervalSince1970: 10)])
        )
        XCTAssertNotEqual(
            TaskLog(value: ["taskId": 1, "startedAt": NSDate(timeIntervalSince1970: 1), "endedAt": NSDate(timeIntervalSince1970: 10)]),
            TaskLog(value: ["taskId": 1, "startedAt": NSDate(timeIntervalSince1970: 0), "endedAt": NSDate(timeIntervalSince1970: 10)])
        )
        XCTAssertNotEqual(
            TaskLog(value: ["taskId": 1, "startedAt": NSDate(timeIntervalSince1970: 0), "endedAt": NSDate(timeIntervalSince1970: 11)]),
            TaskLog(value: ["taskId": 1, "startedAt": NSDate(timeIntervalSince1970: 0), "endedAt": NSDate(timeIntervalSince1970: 10)])
        )
    }
}
