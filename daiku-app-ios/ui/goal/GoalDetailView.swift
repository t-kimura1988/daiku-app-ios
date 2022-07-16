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
    
    @EnvironmentObject var goalDetailVM: GoalDetailViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var offset: CGFloat = 0
    
    init(goalId: Int, createDate: String) {
        self.goalId = goalId
        self.createDate = createDate
    }
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            HStack {
                // Goal Detail
                VStack(alignment: .leading, spacing: 18) {
                    Text("目標")
                        .font(.title2)
                    Text(goalDetailVM.goalDetail.title)
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(.leading, 8)
                    Text("なぜ.")
                        .font(.title2)
                    Text(goalDetailVM.goalDetail.purpose)
                        .fontWeight(.bold)
                        .font(.body)
                        .padding(.leading, 8)
                    Text("どのように.")
                        .font(.title2)
                    Text(goalDetailVM.goalDetail.aim)
                        .fontWeight(.bold)
                        .font(.body)
                        .padding(.leading, 8)
                }
                Spacer()
                
                
            }.padding(8)
            Divider()
            VStack {
                // ProcessList
                VStack(alignment: .leading, spacing: 18) {
                    ForEach(goalDetailVM.processList) {process in
                        NavigationLink{
                            ProcessDetailView(
                                processId: process.id,
                                goalCreateDate: process.goalCreateDate,
                                goalId: process.goalId
                            )
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(alignment: .center, spacing: 8) {
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
                                    
                                    Text(process.title)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                .padding(.leading, 8)
                                Text(process.body)
                                    .font(.body)
                                    .padding(.leading, 16)
                                    .lineLimit(3)
                                Divider()
                            }
                            .contentShape(Rectangle())
                            .foregroundColor(.primary)
                        }
                    }
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
                    Text("工程追加")
                })
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
    }
    
    func blurViewOpacity() -> Double {
        let progress =  -(offset + 80) / 150
        
        return Double(-offset > 80 ? progress : 0)
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailView(goalId: 1, createDate: "2022-07-30")
    }
}
