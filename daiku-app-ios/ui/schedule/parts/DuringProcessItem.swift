//
//  ProcessHistoryItem.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/29.
//

import SwiftUI

struct DurirngProcessItem: View {
    @EnvironmentObject var scheduleMainVM: ScheduleMainViewModel
    private var duringProcess: DuringProcess = DuringProcess()
    
    init(duringProcess: DuringProcess) {
        self.duringProcess = duringProcess
    }
    
    var body: some View {
        
        VStack {
            Text(duringProcess.goalTitle)
                .fontWeight(.bold)
            Text(duringProcess.processTitle)
                .font(.caption2)
            Text(duringProcess.processBody)
                .font(.caption2)
        }
        .padding(8)
        .foregroundColor(.primary)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.red, lineWidth: 2)
        )
        .onTapGesture {
            scheduleMainVM.openGoalDetail(item: duringProcess)
        }
    }
}

struct DurirngProcessItem_Previews: PreviewProvider {
    static var previews: some View {
        DurirngProcessItem(duringProcess: DuringProcess())
    }
}
