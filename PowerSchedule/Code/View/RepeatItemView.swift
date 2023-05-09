//
//  RepeatItemView.swift
//  PowerSchedule
//
//  Created by HeXiaoTian on 2023/5/9.
//

import SwiftUI

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

struct RepeatItemView: View {
    @Binding var repeatItem: RepeatItem

    var body: some View {
        HStack {
            Toggle(isOn: $repeatItem.enable) {
            }
            Group {
                Picker(selection: $repeatItem.type) {
                    ForEach(repeatItem.typeArr) { type in
                        Text(type.name).tag(type.code)
                    }
                } label: {
                    EmptyView()
                }

                Picker(selection: $repeatItem.weekdays) {
                    ForEach(WeekCycle.all) { weekCycle in
                        if weekCycle.code == "-" {
                            Divider()
                        } else {
                            Text(weekCycle.name).tag(weekCycle.code)
                        }
                    }
                } label: {
                    EmptyView()
                }

                DatePicker("于", selection: $repeatItem.time, displayedComponents: .hourAndMinute)
            }
            .disabled(!repeatItem.enable)
        }
    }
}

struct RepeatItemView_Previews: PreviewProvider {
    static var previews: some View {
        RepeatItemView(repeatItem: .constant(RepeatItem.powerOn))
    }
}
