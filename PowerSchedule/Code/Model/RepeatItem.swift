//
//  RepeatItem.swift
//  PowerSchedule
//
//  Created by HeXiaoTian on 2023/5/10.
//

import Foundation

struct RepeatItem {
    var typeArr: [PowerEventType]
    var enable = false
    var type: String
    var weekdays = WeekCycle.all.first!.code
    var time = Date(timeIntervalSince1970: 0)

    init(typeArr: [PowerEventType]) {
        self.typeArr = typeArr
        let type = typeArr.first?.code ?? ""
        self.type = type
    }

    static let powerOn = RepeatItem(typeArr: PowerEventType.onClassify)

    static let powerOff = RepeatItem(typeArr: PowerEventType.offClassify)
}
