//
//  WeekCycle.swift
//  PowerSchedule
//
//  Created by HeXiaoTian on 2023/5/9.
//

import Foundation

struct WeekCycle: Identifiable {
    var id: String {
        code
    }

    var name: String
    var code: String

    static let all = [
        WeekCycle(name: "工作日", code: "MTWRF"),
        WeekCycle(name: "周末", code: "SU"),
        WeekCycle(name: "每天", code: "MTWRFSU"),
        WeekCycle(name: "-", code: "-"),
        WeekCycle(name: "星期一", code: "M"), // Monday
        WeekCycle(name: "星期二", code: "T"), // Tuesday
        WeekCycle(name: "星期三", code: "W"), // Wednesday
        WeekCycle(name: "星期四", code: "R"), // Thursday
        WeekCycle(name: "星期五", code: "F"), // Friday
        WeekCycle(name: "星期六", code: "S"), // Saturday
        WeekCycle(name: "星期日", code: "U"), // Sunday
    ]
}
