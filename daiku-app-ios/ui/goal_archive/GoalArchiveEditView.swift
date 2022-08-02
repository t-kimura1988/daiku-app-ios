//
//  GoalArchiveEditView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/20.
//

import SwiftUI

struct GoalArchiveEditView: View {
    @EnvironmentObject var goalArchiveEditVM: GoalArchiveEditViewModel
    private var closeSheet: () -> Void
    private var goalId: Int = 0
    private var createDate: String = ""
    private var archiveId: Int = 0
    private var archiveCreateDate: String = ""
    private var thoughts: String = ""
    private var published: PublishLevel = .Own
    
    init(closeSheet: @escaping () -> Void = {}, goalId: Int, createDate: String, archiveId: Int = 0, archiveCreateDate: String = "", thoughts: String = "", published: PublishLevel = .Own) {
        self.closeSheet = closeSheet
        self.goalId = goalId
        self.createDate = createDate
        self.archiveId = archiveId
        self.archiveCreateDate = archiveCreateDate
        self.thoughts = thoughts
        self.published = published
    }
    
    var body: some View {
        NavigationView {
            ScrollView (.vertical, showsIndicators: false) {
                VStack {
                    ZStack(alignment: .leading) {
                        if goalArchiveEditVM.thoughts.isEmpty {
                            Text("目標達成の感想を入力しましょう")
                                .foregroundColor(.gray)
                        }else {
                            Text(goalArchiveEditVM.thoughts)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        goalArchiveEditVM.openThoughtsForm()
                    }
                    
                    ZStack(alignment: .leading) {
                        
                        HStack {
                            Text("公開レベルの選択: ")
                                .foregroundColor(.gray)
                                
                            Picker("公開レベル", selection: $goalArchiveEditVM.publish) {
                                ForEach(PublishLevel.allCases, id: \.self) { item in
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
            .fullScreenCover(isPresented: $goalArchiveEditVM.isFormSheet) {
                switch goalArchiveEditVM.formType {
                case .Not:
                    DaikuFormEditor(
                        text: goalArchiveEditVM.thoughts,
                        maxSize: goalArchiveEditVM.textCount()) { text in
                            goalArchiveEditVM.changeText(text: text)
                        
                    }
                case .Thoughts:
                    DaikuFormEditor(
                        text: goalArchiveEditVM.thoughts,
                        maxSize: goalArchiveEditVM.textCount()) { text in
                            goalArchiveEditVM.changeText(text: text)
                        
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: closeSheet, label: {
                        Text("閉じる")
                    })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        goalArchiveEditVM.createArchive {
                            closeSheet()
                        }
                    }, label: {
                        Text("保存")
                    })
                    .disabled(!goalArchiveEditVM.isSaveButton)
                }
            }
        }
        .onAppear {
            goalArchiveEditVM.initItem(archiveId: archiveId, archiveCreateDate: archiveCreateDate, goalId: goalId, createDate: createDate, thoughts: thoughts, publish: published)
            goalArchiveEditVM.initVali()
        }
    }
}

struct GoalArchiveEditView_Previews: PreviewProvider {
    static var previews: some View {
        GoalArchiveEditView(goalId: 0, createDate: "")
    }
}
