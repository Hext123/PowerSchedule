//
//  CommandTool.swift
//  PowerSchedule
//
//  Created by HeXiaoTian on 2023/5/9.
//

import Foundation

struct CommandTool {
    /// 执行 shell 命令, 通过 appleScript 可以执行 sudo 命令
    @discardableResult
    static func exec(shell: String, needAdmin: Bool = false) -> String {
        // do shell script "xxx"
        // do shell script "sudo xxx" with administrator privileges
        let myAppleScript = """
        do shell script "\(shell)" \(needAdmin ? "with administrator privileges" : "")
        """
        print("exec appleScript:", myAppleScript, separator: "\n")
        var error: NSDictionary?
        let scriptObject = NSAppleScript(source: myAppleScript)!
        let result = scriptObject.executeAndReturnError(&error)
        let resultStr = result.stringValue ?? ""
        print("exec result:", resultStr, separator: "\n")
        return resultStr
    }

    /// 获取电源定时计划
    static func getPlanned() -> String {
        let shell = "pmset -g sched"
        return exec(shell: shell)
    }

    /// 保存周期性定时设置
    static func saveRepeat(repeatItems: [RepeatItem]) {
        let commandArr: [String] = repeatItems.compactMap { repeatItem in
            generateCommand(repeatItem: repeatItem)
        }

        var shell: String
        if commandArr.isEmpty {
            shell = "sudo pmset repeat cancel"
        } else {
            // sudo pmset repeat wakeorpoweron T 12:00:00 sleep MTWRFSU 20:00:00
            shell = "sudo pmset repeat " + commandArr.joined(separator: " ")
        }
        print(shell)
        exec(shell: shell, needAdmin: true)
    }

    static let dateFormatter = DateFormatter()

    /// 根据 RepeatItem 生成命令
    static func generateCommand(repeatItem: RepeatItem) -> String? {
        if !repeatItem.enable {
            return nil
        }
        dateFormatter.dateFormat = "HH:mm:ss"
        let timeStr = dateFormatter.string(from: repeatItem.time)
        return "\(repeatItem.type) \(repeatItem.weekdays) '\(timeStr)'"
    }
}
