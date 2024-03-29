//
//  GoalDetailView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/05.
//

import SwiftUI

struct GoalDetailView: View {
    var goalId: Int = 0
    var createDate: String = ""
    var archiveId: Int = 0
    var archiveCreateDate: String = ""
    var duringProcessId: Int = 0
    
    @EnvironmentObject var goalDetailVM: GoalDetailViewModel
    @EnvironmentObject var homeVM: HomeMainViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State var buttonOffset: CGFloat = 0
    
    init(goalId: Int, createDate: String, archiveId: Int, archiveCreateDate: String, duringProcessId: Int = 0) {
        self.goalId = goalId
        self.createDate = createDate
        self.archiveId = archiveId
        self.archiveCreateDate = archiveCreateDate
        self.duringProcessId = duringProcessId
    }
    
    var body: some View {
        NavigationView {
            ScrollView (.vertical, showsIndicators: false) {
                // goal Deital Area
                HStack {
                    // Goal Detail
                    VStack(alignment: .leading, spacing: 18) {
                        Text("目標")
                            .font(.title2)
                            .fontWeight(.bold)
                        MoreText(text: goalDetailVM.goalDetail.title)
                            .foregroundColor(.gray)
                        Text("なぜ.")
                            .font(.title2)
                            .fontWeight(.bold)
                        MoreText(text: goalDetailVM.goalDetail.purpose)
                            .foregroundColor(.gray)
                        Text("どのように.")
                            .font(.title2)
                            .fontWeight(.bold)
                        MoreText(text: goalDetailVM.goalDetail.aim)
                            .foregroundColor(.gray)
                        Text("達成予定日")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(goalDetailVM.goalDetail.dueDateFormat())
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    
                }.padding(8)
                
            
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 8) {
                        // ボタン表示条件
                        if goalDetailVM.goalDetail.editable() {
                            
                            Button(action: {
                                goalDetailVM.changeArchiveSheetFlg()
                            }, label: {
                                Text("目標達成！")
                            })
                            .frame(width:80)
                            .foregroundColor(.yellow)
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.yellow, lineWidth: 1))
                            
                            Button(action: {
                                goalDetailVM.changeSheetFlg()
                            }, label: {
                                Text("工程追加")
                            })
                            .frame(width:80)
                            .foregroundColor(.blue)
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1))
                            .padding(.leading, 50)
                        } else {
                            Button(action: {
                                goalDetailVM.editUpdatingFlg(completing: {goal in
                                    goalDetailVM.getGoalDetail(goalId: goal.id, createDate: goal.createDate)
                                })
                            }, label: {
                                Text("達成取消")
                            })
                            .frame(width:80)
                            .foregroundColor(.red)
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1))
                            .padding(.leading, 50)
                        }
                    }
                    .padding()
                    
                    Divider()
                }
                .padding(.top, 20)
                .background(colorScheme == .dark ? Color.black : Color.white)
                .offset(y: buttonOffset < 80 ? -buttonOffset + 80 : 0)
                .overlay(
                    GeometryReader{reader -> Color in
                        let minY = reader.frame(in: .global).minY
                        DispatchQueue.main.async {
                            buttonOffset = minY
                        }
                        
                        
                        return Color.clear
                    }
                )
                .zIndex(1)
                
                
                // ProcessList
                ForEach(goalDetailVM.processList) {process in
                    ProcessListItemView(process: process, duringProcessId: duringProcessId)
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
                        homeVM.openGoalSheet()
                    }, label: {
                        Image(systemName: "pencil")
                    }).disabled(!goalDetailVM.goalDetail.editable())
                }
            }
            .onAppear() {
                goalDetailVM.getGoalDetail(goalId: goalId, createDate: createDate)
            }
            .fullScreenCover(isPresented: $goalDetailVM.isSheet){
                ProcessCreateView(process: {
                    goalDetailVM.getGoalDetail(goalId: goalId, createDate: createDate)
                })
                    .environmentObject(ProcessCreateViewModel())
            }
            .fullScreenCover(isPresented: $homeVM.isSheet) {
                GoalCreateView(
                    goalId: self.goalId,
                    createDate: self.createDate,
                    title: goalDetailVM.goalDetail.title,
                    purpose: goalDetailVM.goalDetail.purpose,
                    aim: goalDetailVM.goalDetail.aim,
                    dueDate: goalDetailVM.goalDetail.dueDate,
                    closeSheet: {homeVM.closeGoalSheet()}
                )
                .environmentObject(GoalCreateViewModel())
            }
            .fullScreenCover(isPresented: $goalDetailVM.isArchiveSheet) {
                GoalArchiveEditView(
                    closeSheet: {
                        goalDetailVM.changeArchiveSheetFlg()
                    },
                    goalId: self.goalId,
                    createDate: self.createDate,
                    archiveId: self.archiveId,
                    archiveCreateDate: self.archiveCreateDate
                )
                .environmentObject(GoalArchiveEditViewModel())
            }
            
        }
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailView(goalId: 1, createDate: "2022-07-30", archiveId: 1, archiveCreateDate: "2022-07-30")
    }
}
