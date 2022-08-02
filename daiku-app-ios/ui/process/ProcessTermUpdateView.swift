//
//  ProcessTermUpdateView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/27.
//

import SwiftUI

struct ProcessTermUpdateView: View {
    @EnvironmentObject var processTermUpdateVM: ProcessTermUpdateViewModel
    @EnvironmentObject var processDetailVM: ProcessDetailViewModel
    private var start: Date = Date()
    private var end: Date = Date()
    
    private var processId: Int = 0
    private var goalCreateDate: String = ""
    private var goalId: Int = 0
    
    init(start: Date = Date(), end: Date = Date(), processId: Int = 0, goalCreateDate: String = "", goalId: Int = 0) {
        self.start = start
        self.end = end
        self.processId = processId
        self.goalId = goalId
        self.goalCreateDate = goalCreateDate
    }
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack {
                    ZStack(alignment: .leading) {
                        
                        HStack {
                            Text("開始: ")
                                .foregroundColor(.gray)
                                
                            DatePicker("開始", selection: $processTermUpdateVM.start, displayedComponents: .date)
                                .environment(\.locale, Locale(identifier: "ja_JP"))
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .contentShape(Rectangle())
                    ZStack(alignment: .leading) {
                        
                        HStack {
                            Text("完了: ")
                                .foregroundColor(.gray)
                                
                            DatePicker("完了", selection: $processTermUpdateVM.end, displayedComponents: .date)
                                .environment(\.locale, Locale(identifier: "ja_JP"))
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
                        processDetailVM.changeTermUpdateSheet()
                    }, label: {
                        Text("閉じる")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        processTermUpdateVM.update {res in
                            processDetailVM.getProcessDetail(processId: res.id, goalCreateDate: res.goalCreateDate, goalId: res.goalId)
                            processDetailVM.changeTermUpdateSheet()
                        }
                    }, label: {
                        Text("保存")
                    })
                }
            }
        }
        .onAppear{
            processTermUpdateVM.initItem(start: start, end: end, processId: processId, goalCreateDate: goalCreateDate, goalId: goalId)
        }
    }
}

struct ProcessTermUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessTermUpdateView()
    }
}
