//
//  GoalSearchInputView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/26.
//

import SwiftUI

struct GoalSearchInputView: View {
    @EnvironmentObject private var accountMainVM: AccountMainViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack(alignment: .leading) {
            
            HStack {
                Text("作成年月: ")
                    .foregroundColor(.gray)
                
                Picker("日付", selection: $accountMainVM.selectedGoalYear) {
                    let year: Int = Calendar.current.dateComponents([.year], from: Date()).year!
                    ForEach((2022..<year+1).reversed(), id: \.self) { item in
                        Text("\(String(item))年")
                    }
                }.onChange(of: accountMainVM.selectedGoalYear) { year in
                    accountMainVM.getInitMyGoal()
                }
                    
                Picker("日付", selection: $accountMainVM.selectedGoalMonth) {
                    ForEach(DatePickerMonth.allCases, id: \.self) { item in
                        Text(item.title)
                    }
                }.onChange(of: accountMainVM.selectedGoalMonth) { month in
                    accountMainVM.getInitMyGoal()
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

struct GoalSearchInputView_Previews: PreviewProvider {
    static var previews: some View {
        GoalSearchInputView()
    }
}
