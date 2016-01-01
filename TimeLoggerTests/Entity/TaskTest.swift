//
//  TaskTest.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2015/12/30.
//  Copyright © 2015年 halhorn. All rights reserved.
//

import XCTest
import RealmSwift
@testable import TimeLogger

class TaskTest: HALTestCase {
    var token : NotificationToken?

    func testProperty() {
        let task = Task(value: ["taskId": 1, "name": "name", "color": "#ffffff", "createdAt": NSDate(timeIntervalSince1970: 0)])
        XCTAssertEqual(task.taskId, 1)
        XCTAssertEqual(task.name, "name")
        XCTAssertEqual(task.color, "#ffffff")
        XCTAssertEqual(task.createdAt, NSDate(timeIntervalSince1970: 0))
    }
    
    func testStore() {
        var notificationCalled = false;
        let task = Task(value: ["taskId": 1, "name": "name", "color": "#ffffff", "createdAt": NSDate(timeIntervalSince1970: 0)])
        
        let realm2 = try! Realm();
        token = realm2.addNotificationBlock { (notification, realm) -> Void in
            notificationCalled = true;
        }
        let realm = try! Realm();
        try! realm.write {
            realm.add(task)
        }
        XCTAssertEqual(realm.objects(Task).first, task)
        XCTAssertTrue(notificationCalled)
    }
}
