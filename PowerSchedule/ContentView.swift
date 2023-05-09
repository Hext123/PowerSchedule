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

            Button {
                saveRepeat()
            } label: {
                Label("保存", systemImage: "archivebox")
            }

            Divider()

            HStack {
                Text("已设定计划")
                Button {
                    getPlanned()
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

    func getPlanned() {
        planned = CommandTool.getPlanned()
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
