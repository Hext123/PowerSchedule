//
//  AutoWakePlist.swift
//  PowerSchedule
//
//  Created by HeXiaoTian on 2023/5/10.
//

import Foundation

struct AutoWakePlist: Decodable {
    let RepeatingPowerOff: RepeatingPower?
    let RepeatingPowerOn: RepeatingPower?
    let WARNING: String?
    let poweron: [SchedulePower]?
    let restart: [SchedulePower]?
    let shutdown: [SchedulePower]?
    let sleep: [SchedulePower]?
    let wake: [SchedulePower]?
    let wakepoweron: [SchedulePower]?
}

struct RepeatingPower: Decodable {
    /// 事件类型, 如 wakepoweron, poweron, wake, sleep, restart, shutdown
    let eventtype: String
    /// 时间的分钟数
    ///
    /// 例如:
    /// - 00:00 为 0,
    /// - 01:00 为 60,
    /// - 02:59 为 179
    let time: Int
    /// 周期的二进制表示法
    ///
    /// 例如, 以此类推:
    /// | 十进制  | 二进制     | 含义        |
    /// | ------ | ----------| -----------|
    /// | 1      | 0b0000001 | 周一        |
    /// | 64     | 0b1000000 | 周日        |
    /// | 31     | 0b0011111 | 周一到周五   |
    /// | 127    | 0b1111111 | 每天        |
    let weekdays: Int

    // MARK: - 下面是便捷属性

    /// 命令行设置时使用的类型,
    /// 除了 wakepoweron 要改成 wakeorpoweron, 其它跟 eventtype 一致
    var type: String {
        if eventtype == "wakepoweron" {
            return "wakeorpoweron"
        }
        return eventtype
    }

    /// 根据设置定时的时间的分钟数, 返回 Date 时间, 考虑时区, 用于界面显示 "HH:mm".
    ///
    /// - 如 time 为 0 则返回 1970-01-01 00:00:00;
    /// - 如 time 为 120 则返回 1970-01-01 02:00:00;
    var datetime: Date {
        let secondsFromGMT = TimeZone.current.secondsFromGMT(for: Date(timeIntervalSince1970: 0))
        let seconds = time * 60 - secondsFromGMT
        return Date(timeIntervalSince1970: TimeInterval(seconds))
    }

    var weekdaysCode: String {
        // MTWRFSU: 周一到周日
        let codeArr = ["M", "T", "W", "R", "F", "S", "U"]
        var weekdaysCodeArr: [String] = []
        codeArr.enumerated().forEach { offset, element in
            if (weekdays & (1 << offset)) != 0 {
                weekdaysCodeArr.append(element)
            }
        }
        return weekdaysCodeArr.joined()
    }
}

struct SchedulePower: Decodable {
    let appPID: Int
    let eventtype: String
    let scheduledby: String
    let time: Date
}
