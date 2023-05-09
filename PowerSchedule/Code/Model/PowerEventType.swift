//
//  PowerEventType.swift
//  PowerSchedule
//
//  Created by HeXiaoTian on 2023/5/9.
//

import Foundation

struct PowerEventType: Identifiable {
    var id: String {
        code
    }

    var name: String
    var code: String

    static let onClassify = [
        PowerEventType(name: "启动或唤醒", code: "wakeorpoweron"), // 系统实际存储的类型是 "wakepoweron"
        PowerEventType(name: "启动", code: "poweron"),
        PowerEventType(name: "唤醒", code: "wake"),
    ]

    static let offClassify = [
        PowerEventType(name: "睡眠", code: "sleep"),
        PowerEventType(name: "重新启动", code: "restart"),
        PowerEventType(name: "关机", code: "shutdown"),
    ]
}
