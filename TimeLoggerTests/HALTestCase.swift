//
//  HALTestCase.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2016/01/01.
//  Copyright © 2016年 halhorn. All rights reserved.
//

import XCTest
import RealmSwift

class HALTestCase: XCTestCase {
    override func setUp() {
        super.setUp()
        
        // DB をメモリ上に配置する
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
}