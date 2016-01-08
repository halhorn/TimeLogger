//
//  PreInstallerModel.swift
//  TimeLogger
//
//  Created by 信田 春満 on 2016/01/04.
//  Copyright © 2016年 halhorn. All rights reserved.
//

import Foundation

class PreInstallerModel {
    static var setting = SettingData<Bool>(key: "PreInstallModel.preInstallKey")
    
    private static let preInstallData = [
        (name: "コーディング", color: "#f0fff0"),
        (name: "レビュー", color: "#fff0ff"),
        (name: "会議", color: "#f0f0ff"),
    ]
    
    class func isPreInstalled() -> Bool {
        return setting.load() ?? false
    }
    
    class func install() throws {
        let taskData = try TaskData()
        for arg in preInstallData {
            try taskData.create(name: arg.name, color: arg.color)
        }

        try setting.save(true)
   }
}