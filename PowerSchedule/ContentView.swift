//
//  ContentView.swift
//  PowerSchedule
//
//  Created by HeXiaoTian on 2023/5/8.
//

import SwiftUI

struct ContentView: View {
    @State var planned = ""
    @State var repeatPowerOn = RepeatItem.powerOn
    @State var repeatPowerOff = RepeatItem.powerOff

    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            Text("设置 Mac 启动、关机、睡眠或从睡眠唤醒的特定时间。")
//            Text("仅当连接电源适配器时，Mac 才会定时启动。")

            RepeatItemView(repeatItem: $repeatPowerOn)
            RepeatItemView(repeatItem: $repeatPowerOff)

            HStack {
                Button {
                    getPlanned()
                } label: {
                    Label("恢复上次的设置", systemImage: "arrow.triangle.2.circlepath")
                }
                Button {
                    saveRepeat()
                } label: {
                    Label("应用", systemImage: "archivebox")
                }
            }

            Divider()

            HStack {
                Text("已设定计划")
                Button {
                    getPlanned(updateUI: false)
                } label: {
                    Label("刷新", systemImage: "arrow.triangle.2.circlepath")
                }
            }
            Text(planned)
        }
        .padding()
        .onAppear {
            getPlanned()
        }
    }

    func getPlanned(updateUI: Bool = true) {
        planned = CommandTool.getPlanned()
        if updateUI {
            readPlistUpdateUI()
        }
    }

    func readPlistUpdateUI() {
        let autoWakePlist = PowerPlistTool.readPlist()
        // RepeatingPowerOn
        if let repeatingPowerOn = autoWakePlist?.RepeatingPowerOn {
            repeatPowerOn.enable = true
            repeatPowerOn.type = repeatingPowerOn.type
            repeatPowerOn.time = repeatingPowerOn.datetime
            repeatPowerOn.weekdays = repeatingPowerOn.weekdaysCode
        } else {
            repeatPowerOn.enable = false
        }
        // RepeatingPowerOff
        if let repeatingPowerOff = autoWakePlist?.RepeatingPowerOff {
            repeatPowerOff.enable = true
            repeatPowerOff.type = repeatingPowerOff.type
            repeatPowerOff.time = repeatingPowerOff.datetime
            repeatPowerOff.weekdays = repeatingPowerOff.weekdaysCode
        } else {
            repeatPowerOff.enable = false
        }
    }

    func saveRepeat() {
        CommandTool.saveRepeat(repeatItems: [
            repeatPowerOn,
            repeatPowerOff,
        ])
        getPlanned()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
