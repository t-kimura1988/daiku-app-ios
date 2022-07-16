//
//  ProcessHistoryComment.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/10.
//

import SwiftUI

struct ProcessHistoryCommentView: View {
    @EnvironmentObject var pHCommentCreateVM: ProcessHistoryCommentCreateViewModel
    
    @EnvironmentObject var processDetailVM: ProcessDetailViewModel
    
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                ZStack(alignment: .leading) {
                    if pHCommentCreateVM.comment.isEmpty {
                        
                        Text("コメントを入力してください")
                            .foregroundColor(.gray)
                    } else {
                        Text(pHCommentCreateVM.comment)
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .contentShape(Rectangle())
                .onTapGesture {
                    pHCommentCreateVM.openCreateForm()
                }
                
                ZStack(alignment: .leading) {
                    
                    HStack {
                        Text("ステータスの選択: ")
                            .foregroundColor(.gray)
                            
                        Picker("ステータス", selection: $pHCommentCreateVM.selectedProcessStatus) {
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
                            
                        Picker("優先順位", selection: $pHCommentCreateVM.selectedProcessPriority) {
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
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $pHCommentCreateVM.isFormSheet) {
                switch pHCommentCreateVM.formType {
                case .Comment:
                    DaikuFormEditor(
                        text: pHCommentCreateVM.comment,
                        maxSize: pHCommentCreateVM.textCount()) { text in
                            pHCommentCreateVM.changeText(text: text)
                        
                    }
                case .Not:
                    DaikuFormEditor(
                        text: pHCommentCreateVM.comment,
                        maxSize: pHCommentCreateVM.textCount()) { text in
                            pHCommentCreateVM.changeText(text: text)
                        
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {processDetailVM.changeCommentSheet()}, label: {
                        Text("閉じる")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        pHCommentCreateVM.saveComment(){ res in
                            processDetailVM.changeCommentSheet()
                            
                            processDetailVM.getProcessDetail(processId: res.processId, goalCreateDate: res.goalCreateDate, goalId:res.goalId )
                        }
                        
                    }, label: {
                        Text("保存")
                    })
                }
            }
            .onAppear {
                pHCommentCreateVM.initItem(
                    status: processDetailVM.process.statusToEnum(),
                    priority: processDetailVM.process.priorityToEnum(),
                    processId: processDetailVM.process.id)
            }
        }
    }
}

struct ProcessHistoryCommentView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessHistoryCommentView(
        )
    }
}
