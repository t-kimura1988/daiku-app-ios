//
//  CommentUpdateForm.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/13.
//

import SwiftUI

struct CommentUpdateFormView: View {
    @EnvironmentObject var commentUpdateVM: CommentUpdateViewModel
    @EnvironmentObject var processDetailVM: ProcessDetailViewModel
    
    private var processHistoryId: Int = 0
    private var goalCreateDate: String = ""
    
    init(processHistoryId: Int, goalCreateDate: String) {
        self.processHistoryId = processHistoryId
        self.goalCreateDate = goalCreateDate
    }
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                ZStack(alignment: .leading) {
                    if commentUpdateVM.comment.isEmpty {
                        
                        Text("コメントを入力してください")
                            .foregroundColor(.gray)
                    } else {
                        Text(commentUpdateVM.comment)
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .contentShape(Rectangle())
                .onTapGesture {
                    commentUpdateVM.openCreateForm()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $commentUpdateVM.isFormSheet) {
                switch commentUpdateVM.formType {
                case .Comment:
                    DaikuFormEditor(
                        text: commentUpdateVM.comment,
                        maxSize: commentUpdateVM.textCount()) { text in
                            commentUpdateVM.changeText(text: text)
                        
                    }
                case .Not:
                    DaikuFormEditor(
                        text: commentUpdateVM.comment,
                        maxSize: commentUpdateVM.textCount()) { text in
                            commentUpdateVM.changeText(text: text)
                        
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        processDetailVM.changeCommentUpdateSheet(
                            processHistoryId: processHistoryId)
                        
                    }, label: {
                        Text("閉じる")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        commentUpdateVM.updateComment(){ res in
                            processDetailVM.changeCommentUpdateSheet(processHistoryId: processHistoryId)
                            processDetailVM.getProcessDetail(processId: res.processId, goalCreateDate: res.goalCreateDate, goalId:res.goalId )
                        }
                        
                    }, label: {
                        Text("保存")
                    })
                }
            }
            .onAppear {
                commentUpdateVM.initItem(processHistoryId: processHistoryId, goalCreateDate: goalCreateDate)
                commentUpdateVM.detail()
            }
        }
    }
}

struct CommentUpdateFormView_Previews: PreviewProvider {
    static var previews: some View {
        CommentUpdateFormView(processHistoryId: 0, goalCreateDate: "2022/08/01")
    }
}
