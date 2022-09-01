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
    @EnvironmentObject var goalDetailVM: GoalDetailViewModel
    
    private var goalId: Int = 0
    private var createDate: String = ""
    private var title: String = ""
    private var purpose: String = ""
    private var aim: String = ""
    private var dueDate: String = ""
    
    
    init(goalId: Int = 0, createDate: String = "", title: String = "", purpose: String = "", aim: String = "", dueDate: String = "") {
        self.goalId = goalId
        self.createDate = createDate
        self.title = title
        self.purpose = purpose
        self.aim = aim
        self.dueDate = dueDate
    }
    
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
                
                Divider()
                    .frame(maxWidth: .infinity)
                
                ZStack(alignment: .leading) {
                    
                    HStack {
                        Text("期間: ")
                            .foregroundColor(.gray)
                        DatePicker("", selection: $goalCreateVm.selectedDueDate, displayedComponents: .date)
                            .environment(\.locale, Locale(identifier: "ja_JP"))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .contentShape(Rectangle())
                
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
                        goalCreateVm.saveGoal { goalResponse in
                            goalDetailVM.getGoalDetail(goalId: goalResponse.id, createDate: goalResponse.createDate)
                            vm.createGoalSheet()
                        }
                    }, label: {Text("保存")})
                    .disabled(!goalCreateVm.isSaveButton || goalCreateVm.isSending)
                }
            }
            
        }
        .onAppear{
            goalCreateVm.initUpdate(goalId: goalId, createDate: createDate, title: title, purpose: purpose, aim: aim, dueDate: dueDate)
            goalCreateVm.initVali()
        }
    }
}

struct GoalCreateView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCreateView()
    }
}
