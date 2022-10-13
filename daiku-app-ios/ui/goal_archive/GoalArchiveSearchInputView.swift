//
//  GoalArchiveSearchInputView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/27.
//

import SwiftUI

struct GoalArchiveSearchInputView: View {
    @EnvironmentObject private var accountMainVM: AccountMainViewModel
    var body: some View {
        ZStack(alignment: .leading) {
            
            HStack {
                Text("達成年月: ")
                    .foregroundColor(.gray)
                
                Picker("日付", selection: $accountMainVM.selectedGoalArchiveYear) {
                    let year: Int = Calendar.current.dateComponents([.year], from: Date()).year!
                    ForEach((2022..<year+1).reversed(), id: \.self) { item in
                        Text("\(String(item))年")
                    }
                }.onChange(of: accountMainVM.selectedGoalArchiveYear) { year in
                    accountMainVM.getInitMyGoalArchive()
                }
                    
                Picker("日付", selection: $accountMainVM.selectedGoalArchiveMonth) {
                    ForEach(DatePickerMonth.allCases, id: \.self) { item in
                        Text(item.title)
                    }
                }.onChange(of: accountMainVM.selectedGoalArchiveMonth) { month in
                    accountMainVM.getInitMyGoalArchive()
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

struct GoalArchiveSearchInputView_Previews: PreviewProvider {
    static var previews: some View {
        GoalArchiveSearchInputView()
    }
}
