//
//  MockedSettingData.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2016/01/07.
//  Copyright © 2016年 halhorn. All rights reserved.
//

import Foundation
@testable import TimeLogger

class MockedSettingData<T> : SettingData<T> {
    let key : String
    
    override init(key: String) {
        self.key = key
        super.init(key: key)
    }
    
    override func load(defaultValue defaultValue : T? = nil) -> T? {
        let result = DataStore.dict[key] as? T
        return result != nil ? result : defaultValue
    }
    
    override func save(value : T) throws {
        guard let object = value as? AnyObject else {
            throw SettingDataError.InvalidParameterType
        }
        DataStore.dict[key] = object
    }
    
    override func remove() {
        DataStore.dict.removeValueForKey(key)
    }
}

private class DataStore {
    static var dict : [String: AnyObject] = [:]
}