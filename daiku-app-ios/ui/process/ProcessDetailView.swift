//
//  ProcessDetailView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/07.
//

import SwiftUI

struct ProcessDetailView: View {
    @EnvironmentObject var processDetailVM: ProcessDetailViewModel
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
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(processDetailVM.process.title)
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(.leading, 8)
                    Text(processDetailVM.process.body)
                        .font(.body)
                        .padding(.leading, 8)
                }
                Spacer()
            }
            
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
                processDetailVM.changeStatusUpdateSheet()
            }
            Divider()
            
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
                        }
                        
                        if !item.priorityComment().isEmpty {
                            Text(item.priorityComment())
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
                    processDetailVM.changeCommentSheet()
                }, label: {
                    Text("コメント")
                })
            }
        }
        .onAppear() {
            print("aaaaa")
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
        
    }
}

struct ProcessDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessDetailView(processId: 10, goalCreateDate: "2022-07-20", goalId: 10)
    }
}
