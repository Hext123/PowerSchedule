//
//  PowerPlistTool.swift
//  PowerSchedule
//
//  Created by HeXiaoTian on 2023/5/10.
//

import Foundation

struct PowerPlistTool {
    static func readPlist() -> AutoWakePlist? {
        let url = URL(fileURLWithPath: "/Library/Preferences/SystemConfiguration/com.apple.AutoWake.plist")
        do {
            let data = try Data(contentsOf: url)
            let autoWakePlist = try PropertyListDecoder().decode(AutoWakePlist.self, from: data)
            print(autoWakePlist)
            return autoWakePlist
        } catch {
            print("Error while reading plist: \(error.localizedDescription)")
        }
        return nil
    }
}
