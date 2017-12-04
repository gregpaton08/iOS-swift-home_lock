//
//  HLSettings.swift
//  HomeLockControl
//
//  Created by Greg Paton on 10/14/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import Foundation

public class HLSettings {
    
    public enum SettingKeys: String {
        case address
    }
    
    static private let suiteName = "group.GSP.TodayExtensionSharingDefaults"
    static private let defaults = UserDefaults.init(suiteName: suiteName)!
    
    public class func getSetting(_ key: SettingKeys) -> Any? {
        return defaults.object(forKey: key.rawValue)
    }
    
    public class func setSetting(_ setting: Any?, forKey key: SettingKeys) {
        if let settingString = setting as? String {
            defaults.set(settingString, forKey: key.rawValue)
            defaults.synchronize()
        }
    }
    
}
