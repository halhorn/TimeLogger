//
//  SettingData.swift
//  TimeLogger
//
//  簡単な設定情報を保存・読込するクラスです
//  内部実装は UserDefaults ですが、内部実装を隠蔽することが目的です
//
//  Created by 信田 春満 on 2016/01/04.
//  Copyright © 2016年 halhorn. All rights reserved.
//

import Foundation

enum SettingDataError : ErrorType {
    case InvalidParameterType
}

class SettingData<T> {
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    private let key : String
    
    init(key: String) {
        let prefix = "SettingData."
        self.key = prefix + key
    }
    
    func load(defaultValue defaultValue : T? = nil) -> T? {
        let result = userDefaults.valueForKey(key) as? T
        return result != nil ? result : defaultValue
    }
    
    func save(value : T) throws {
        guard let object = value as? AnyObject else {
            throw SettingDataError.InvalidParameterType
        }
        userDefaults.setValue(object, forKey: key)
    }
    
    func remove() {
        userDefaults.removeObjectForKey(key)
    }
}
