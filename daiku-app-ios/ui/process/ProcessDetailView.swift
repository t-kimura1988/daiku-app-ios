//
//  ProcessDetailView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/07.
//

import SwiftUI

struct ProcessDetailView: View {
    @EnvironmentObject var processDetailVM: ProcessDetailViewModel
    @EnvironmentObject var goalDetailVM: GoalDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    private var processId: Int = 0
    private var goalCreateDate: String = ""
    private var goalId: Int = 0
    
    init(processId: Int, goalCreateDate: String, goalId: Int) {
        self.processId = processId
        self.goalCreateDate = goalCreateDate
        self.goalId = goalId
    }
    
    var body: some View {
        ScrollView {
            // Goal Detail
            
            VStack(alignment: .leading, spacing: 8) {
                Text(processDetailVM.process.title)
                    .fontWeight(.bold)
                    .font(.title2)
                    .padding(.leading, 8)
                MoreText(text: processDetailVM.process.body)
            }
            
            // Term
            HStack(alignment: .center, spacing: 8) {
                if processDetailVM.process.processStartDate == nil {
                    Text("期間設定なし（タップして編集）")
                        .foregroundColor(.gray)
                } else {
                    Text("期間: \(processDetailVM.process.startDisp()) 〜 \(processDetailVM.process.endDisp())" )
                        .padding(8)
                    
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                if goalDetailVM.goalDetail.editable() {
                    processDetailVM.changeTermUpdateSheet()
                }
            }
            
            // Status
            LazyHStack(alignment: .center, spacing: 8) {
                Text(processDetailVM.process.statusToEnum().title)
                    .fontWeight(.bold)
                    .padding(8)
                    .frame(width: 80)
                    .background(processDetailVM.process.statusToEnum().backColor())
                    .cornerRadius(15)
                    .compositingGroup()
                    .shadow(color: .gray, radius: 3, x: 1, y: 1)
                Text(processDetailVM.process.priorityToEnum().title)
                    .fontWeight(.bold)
                    .frame(width: 80)
                    .padding(8)
                    .background(processDetailVM.process.priorityToEnum().backColor())
                    .cornerRadius(15)
                    .compositingGroup()
                    .shadow(color: .gray, radius: 3, x: 1, y: 1)
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                if goalDetailVM.goalDetail.editable() {
                    processDetailVM.changeStatusUpdateSheet()
                }
            }
            
            Divider()
            
            // Process history List
            ForEach(processDetailVM.processHistoryList) { item in
                
                HStack {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        if !item.getComment().isEmpty {
                            HStack {
                                Text(item.getComment())
                                Spacer()
                                Button(action: {
                                    processDetailVM.changeCommentUpdateSheet(processHistoryId: item.id)
                                }, label: {
                                    Text("編集")
                                })
                            }
                        }
                        
                        if !item.processStatusComment().isEmpty {
                            Text(item.processStatusComment())
                                .foregroundColor(.gray)
                                .font(.body)
                        }
                        
                        if !item.priorityComment().isEmpty {
                            Text(item.priorityComment())
                                .foregroundColor(.gray)
                                .font(.body)
                        }
                        
                        if !item.titleComment().isEmpty {
                            Text(item.titleComment())
                            
                        }
                        
                    }
                    Spacer()
                }
                Divider()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    goalDetailVM.changeSheetFlg()
                }, label: {
                    Image(systemName: "pencil")
                })
                .disabled(!goalDetailVM.goalDetail.editable())
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    processDetailVM.changeCommentSheet()
                }, label: {
                    Text("コメント")
                })
                .disabled(!goalDetailVM.goalDetail.editable())
            }
        }
        .onAppear() {
            processDetailVM.initItem()
            processDetailVM.getProcessDetail(
                processId: self.processId,
                goalCreateDate: self.goalCreateDate,
                goalId: self.goalId
            )
        }
        // プロセス履歴作成シート表示
        .fullScreenCover(isPresented: $processDetailVM.isCommentCreateSheet){
            ProcessHistoryCommentView()
                .environmentObject(ProcessHistoryCommentCreateViewModel())
        }
        // コメント編集シート表示
        .fullScreenCover(isPresented: $processDetailVM.isCommentUpdateSheet){
            CommentUpdateFormView(
                processHistoryId: processDetailVM.processHistoryId,
                goalCreateDate: goalCreateDate
            )
                .environmentObject(CommentUpdateViewModel())
        }
        // ステータス修正シート表示
        .fullScreenCover(isPresented: $processDetailVM.isStatusUpdateSheet) {
            StatusUpdateView(
                status: processDetailVM.process.statusToEnum(),
                priority: processDetailVM.process.priorityToEnum()
            )
            .environmentObject(StatusUpdteViewModel())
        }
        .fullScreenCover(isPresented: $goalDetailVM.isSheet){
            ProcessCreateView(
                process: {
                    processDetailVM.getProcessDetail(processId: processId, goalCreateDate: goalCreateDate, goalId: goalId)
                },
                processId: processId,
                title: processDetailVM.process.title,
                body: processDetailVM.process.body,
                processStatus: processDetailVM.process.processStatus,
                priority: processDetailVM.process.priority
                
            )
                .environmentObject(ProcessCreateViewModel())
        }
        .fullScreenCover(isPresented: $processDetailVM.isTermUpdateSheet) {
            ProcessTermUpdateView(
                start: processDetailVM.process.start(),
                end: processDetailVM.process.end(),
                processId: processDetailVM.process.id,
                goalCreateDate: processDetailVM.process.goalCreateDate,
                goalId: processDetailVM.process.goalId
            )
            .environmentObject(ProcessTermUpdateViewModel())
        }
        
    }
}

struct ProcessDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessDetailView(processId: 10, goalCreateDate: "2022-07-20", goalId: 10)
    }
}
