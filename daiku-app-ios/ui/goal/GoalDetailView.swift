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
    
    @EnvironmentObject var goalDetailVM: GoalDetailViewModel
    @EnvironmentObject var homeVM: HomeMainViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State var buttonOffset: CGFloat = 0
    
    init(goalId: Int, createDate: String, archiveId: Int, archiveCreateDate: String) {
        self.goalId = goalId
        self.createDate = createDate
        self.archiveId = archiveId
        self.archiveCreateDate = archiveCreateDate
    }
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            // goal Deital Area
            HStack {
                // Goal Detail
                VStack(alignment: .leading, spacing: 18) {
                    Text("目標")
                        .font(.title2)
                    MoreText(text: goalDetailVM.goalDetail.title)
                    Text("なぜ.")
                        .font(.title2)
                    MoreText(text: goalDetailVM.goalDetail.purpose)
                    Text("どのように.")
                        .font(.title2)
                    MoreText(text: goalDetailVM.goalDetail.aim)
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
                
                NavigationLink{
                    ProcessDetailView(
                        processId: process.id,
                        goalCreateDate: process.goalCreateDate,
                        goalId: process.goalId
                    )
                } label: {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        
                            
                        Text(process.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                        
                        Text("\(process.startDisp()) 〜 \(process.endDisp()) ")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        HStack(spacing: 8) {
                            Text(process.statusToEnum().title)
                                .fontWeight(.bold)
                                .padding(8)
                                .background(process.statusToEnum().backColor())
                                .cornerRadius(15)
                                .compositingGroup()
                                .shadow(color: .gray, radius: 3, x: 1, y: 1)
                            Text(process.priorityToEnum().title)
                                .fontWeight(.bold)
                                .padding(8)
                                .background(process.priorityToEnum().backColor())
                                .cornerRadius(15)
                                .compositingGroup()
                                .shadow(color: .gray, radius: 3, x: 1, y: 1)
                            Spacer()
                        }
                        .padding(.leading, 8)
                        HStack {
                            
                            Text(process.body)
                                .font(.body)
                                .padding(.leading, 16)
                                .lineLimit(3)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        Divider()
                    }
                    .contentShape(Rectangle())
                    .foregroundColor(.primary)
                    
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
                    homeVM.createGoalSheet()
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
                dueDate: goalDetailVM.goalDetail.dueDate
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

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailView(goalId: 1, createDate: "2022-07-30", archiveId: 1, archiveCreateDate: "2022-07-30")
    }
}
