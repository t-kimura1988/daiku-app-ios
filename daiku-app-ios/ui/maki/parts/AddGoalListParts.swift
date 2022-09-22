//
//  AddGoalListParts.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/18.
//

import SwiftUI

struct AddGoalListParts: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var makiAddGoalVM: MakiAddGoalViewModel
    @EnvironmentObject private var makiDetailVM: MakiDetailViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    makiDetailVM.closeAddGoalSheetNextStep {
                        makiDetailVM.openGoalCreateSheet()
                        makiDetailVM.loadMakiList()
                    }
                }, label: {
                    Text("新規目標作成")
                })
                .padding(.leading, 8)
                Spacer()
                Button(action: {
                    makiAddGoalVM.addGoal(completion: {
                        makiDetailVM.closeAddGoalSheet()
                        makiDetailVM.getInitMakiGoalList()
                    })
                }, label: {
                    Text("追加")
                })
                .disabled(!makiAddGoalVM.isSaveButton)
            }
            .padding(8)
            Divider()
            GroupBox("goalList") {
                ForEach(0..<makiAddGoalVM.goalList.count, id: \.self) { index in
                    let item = makiAddGoalVM.goalList[index]
                    let isCheck = makiAddGoalVM.isCheck[index]
                    HStack {
                        if item.makiRelationId == nil {
                            if isCheck {
                                Image(systemName: "checkmark.square")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "square")
                                    .foregroundColor(.green)
                            }
                        } else {
                            Image(systemName: "checkmark.square")
                                .foregroundColor(.gray)
                        }
                        VStack {
                            Text(item.title)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .disabled(true)
                        }
                        Spacer()
                    }
                    .padding(8)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if item.makiRelationId != nil {
                            return
                        }
                        makiAddGoalVM.setGoalItem(index: index)
                    }
                    Divider()
                }
                
            }
            Spacer()
        }
    }
}

struct AddGoalListParts_Previews: PreviewProvider {
    static var previews: some View {
        AddGoalListParts()
    }
}
