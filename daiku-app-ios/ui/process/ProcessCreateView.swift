//
//  ProcessCreate.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/06.
//

import SwiftUI

struct ProcessCreateView: View {
    @EnvironmentObject var goalDetailVM: GoalDetailViewModel
    @EnvironmentObject var processCreateVM: ProcessCreateViewModel
    
    var process: () -> Void
    
    init(process: @escaping () -> Void) {
        self.process = process
    }
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack {
                    ZStack(alignment: .leading) {
                        if processCreateVM.title.isEmpty {
                            
                            Text("タイトルを入力してください")
                                .foregroundColor(.gray)
                        } else {
                            Text(processCreateVM.title)
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        processCreateVM.openTitleForm()
                    }
                    ZStack(alignment: .leading) {
                        if processCreateVM.body.isEmpty {
                            
                            Text("内容を入力してください")
                                .foregroundColor(.gray)
                        } else {
                            Text(processCreateVM.body)
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        processCreateVM.openBodyForm()
                    }
                    ZStack(alignment: .leading) {
                        
                        HStack {
                            Text("ステータスの選択: ")
                                .foregroundColor(.gray)
                                
                            Picker("ステータス", selection: $processCreateVM.selectedProcessStatus) {
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
                                
                            Picker("優先順位", selection: $processCreateVM.selectedProcessPriority) {
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
            .fullScreenCover(isPresented: $processCreateVM.isFormSheet) {
                switch processCreateVM.formType {
                case .Title:
                    DaikuFormEditor(
                        text: processCreateVM.title,
                        maxSize: processCreateVM.textCount()) { text in
                            processCreateVM.changeText(text: text)
                        
                    }
                case .Body:
                    DaikuFormEditor(
                        text: processCreateVM.body,
                        maxSize: processCreateVM.textCount()) { text in
                            processCreateVM.changeText(text: text)
                        
                    }
                case .Not:
                    DaikuFormEditor(
                        text: processCreateVM.title,
                        maxSize: processCreateVM.textCount()) { text in
                            processCreateVM.changeText(text: text)
                        
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {goalDetailVM.changeSheetFlg()}, label: {
                        Text("閉じる")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        processCreateVM.saveProcess(goalId: goalDetailVM.goalDetail.id, goalCreateDate: goalDetailVM.goalDetail.createDate) {
                            
                            goalDetailVM.changeSheetFlg()
                            
                            process()
                        }
                        
                    }, label: {
                        Text("保存")
                    })
                }
            }
        }
    }
}

struct ProcessCreate_Previews: PreviewProvider {
    static var previews: some View {
        ProcessCreateView(process: {
            
        })
    }
}
