//
//  RepeatItemView.swift
//  PowerSchedule
//
//  Created by HeXiaoTian on 2023/5/9.
//

import SwiftUI

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
