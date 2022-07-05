//
//  GoalCreateView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/30.
//

import SwiftUI

struct GoalCreateView: View {
    @EnvironmentObject var vm: HomeMainViewModel
    @EnvironmentObject var goalCreateVm: GoalCreateViewModel
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 50) {
                ZStack(alignment: .leading) {
                    if goalCreateVm.title.isEmpty {
                        Text("題名を入力しましょう")
                            .foregroundColor(.gray)
                    }else {
                        Text(goalCreateVm.title)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .contentShape(Rectangle())
                .onTapGesture {
                    goalCreateVm.openTitleForm()
                }
                
                Divider()
                    .frame(maxWidth: .infinity)
                
                ZStack {
                    if goalCreateVm.purpose.isEmpty {
                        Text("目的を入力しましょう")
                            .foregroundColor(.gray)
                    }else {
                        Text(goalCreateVm.purpose)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .contentShape(Rectangle())
                .onTapGesture {
                    goalCreateVm.openPurposeForm()
                }
                
                Divider()
                    .frame(maxWidth: .infinity)
                
                ZStack {
                    if goalCreateVm.aim.isEmpty {
                        Text("どのように目標を達成するか入力しましょう")
                            .foregroundColor(.gray)
                    }else {
                        Text(goalCreateVm.aim)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .contentShape(Rectangle())
                .onTapGesture {
                    goalCreateVm.openAimForm()
                }
                
            }
            .fullScreenCover(isPresented: $goalCreateVm.isFormSheet) {
                switch goalCreateVm.formType {
                case .Title:
                    DaikuFormEditor(
                        text: goalCreateVm.title,
                        maxSize: goalCreateVm.textCount()) { text in
                        goalCreateVm.changeText(text: text)
                        
                    }
                case .Purpose:
                    DaikuFormEditor(
                        text: goalCreateVm.purpose,
                        maxSize: goalCreateVm.textCount()
                    ) { text in
                        goalCreateVm.changeText(text: text)
                        
                    }
                case .Aim:
                    DaikuFormEditor(
                        text: goalCreateVm.aim,
                        maxSize: goalCreateVm.textCount()
                    ) { text in
                        goalCreateVm.changeText(text: text)
                        
                    }
                case .Not:
                    DaikuFormEditor(
                        text: goalCreateVm.title,
                        maxSize: goalCreateVm.textCount()
                    ) { text in
                        goalCreateVm.changeText(text: text)
                        
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {vm.createGoalSheet()}, label: {Text("閉じる")})
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        goalCreateVm.saveGoal {
                            vm.createGoalSheet()
                        }
                    }, label: {Text("保存")})
                }
            }
            
        }
    }
}

struct GoalCreateView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCreateView()
    }
}
