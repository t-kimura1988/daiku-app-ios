//
//  StatusUpdateView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/14.
//

import SwiftUI

struct StatusUpdateView: View {
    @EnvironmentObject var processDetailVM: ProcessDetailViewModel
    @EnvironmentObject var statusUpdateVM: StatusUpdteViewModel
    private var status: ProcessStatus
    private var priority: ProcessPriority
    
    init(status: ProcessStatus, priority: ProcessPriority) {
        self.status = status
        self.priority = priority
    }
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack {
                    ZStack(alignment: .leading) {
                        
                        HStack {
                            Text("ステータスの選択: ")
                                .foregroundColor(.gray)
                                
                            Picker("ステータス", selection: $statusUpdateVM.processStatus) {
                                ForEach(ProcessStatus.allCases, id: \.self) { item in
                                    Text(item.title)
                                }
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .contentShape(Rectangle())
                    ZStack(alignment: .leading) {
                        
                        HStack {
                            Text("優先順位の選択: ")
                                .foregroundColor(.gray)
                                
                            Picker("優先順位", selection: $statusUpdateVM.priority) {
                                ForEach(ProcessPriority.allCases, id: \.self) { item in
                                    Text(item.title)
                                }
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .contentShape(Rectangle())
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        processDetailVM.changeStatusUpdateSheet()
                        
                    }, label: {
                        Text("閉じる")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        statusUpdateVM.updateStatus() { processHistory in
                            processDetailVM.getProcessDetail(
                                processId: processHistory.processId,
                                goalCreateDate: processHistory.goalCreateDate,
                                goalId: processHistory.goalId)
                            
                            processDetailVM.changeStatusUpdateSheet()
                        }
                    }, label: {
                        Text("保存")
                    })
                }
            }
        }
        .onAppear{
            statusUpdateVM.initItem(currentStatus: status, currentPriority: priority, processId: processDetailVM.process.id)
        }
        .navigationViewStyle(.stack)
    }
}

struct StatusUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        StatusUpdateView(status: .New, priority: .Normal)
    }
}
