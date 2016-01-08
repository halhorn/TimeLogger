//
//  PreInstallerModelTest.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2016/01/04.
//  Copyright © 2016年 halhorn. All rights reserved.
//

import XCTest
import RealmSwift
@testable import TimeLogger

class PreInstallerModelTest: HALTestCase {

    override func setUp() {
        PreInstallerModel.setting = MockedSettingData<Bool>(key: "test")
    }
    
    override func tearDown() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        super.tearDown()
    }

    func testPreInstall() {
        XCTAssertFalse(PreInstallerModel.isPreInstalled())
        try! PreInstallerModel.install()
        XCTAssertTrue(PreInstallerModel.isPreInstalled())
        let taskData = try! TaskData()
        let taskList = taskData.readList()
        XCTAssertTrue(taskList?.count > 0)
    }
}

