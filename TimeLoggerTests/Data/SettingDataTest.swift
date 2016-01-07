//
//  SettingDataTest.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2016/01/04.
//  Copyright © 2016年 halhorn. All rights reserved.
//

import XCTest
@testable import TimeLogger

class SettingDataTest: HALTestCase {
    func testSetting() {
        let key = "SettingDataTest"
        let setting = SettingData<Bool>(key: key)
        setting.remove()
        XCTAssertNil(setting.load())
        let result : Bool? = setting.load(defaultValue: false)
        XCTAssertFalse(result!)
        try! setting.save(true)
        XCTAssertTrue(setting.load()!)
        
        let setting2 = SettingData<Bool>(key: key)
        XCTAssertTrue(setting2.load()!)
    }
    
    func testInvalidSetting() {
        let setting = SettingData<(String) -> Bool>(key: "SettingDataTest2")
        setting.remove()
        do {
            try setting.save({(str: String) in return true})
            XCTFail()
        } catch SettingDataError.InvalidParameterType {
            // success
        } catch {
            XCTFail()
        }
    }
}
