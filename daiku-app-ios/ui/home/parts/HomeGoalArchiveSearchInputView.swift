//
//  HomeGoalArchiveSearchInputView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/27.
//

import SwiftUI

struct HomeGoalArchiveSearchInputView: View {
    @EnvironmentObject private var homeMainVM: HomeMainViewModel
    var body: some View {
        ZStack(alignment: .leading) {
            
            HStack {
                Text("達成年月: ")
                    .foregroundColor(.gray)
                
                Picker("日付", selection: $homeMainVM.selectedGoalArchiveYear) {
                    let year: Int = Calendar.current.dateComponents([.year], from: Date()).year!
                    ForEach((2022..<year+1).reversed(), id: \.self) { item in
                        Text("\(String(item))年")
                    }
                }.onChange(of: homeMainVM.selectedGoalArchiveYear) { year in
                    homeMainVM.getInitHomeList()
                }
                    
                Picker("日付", selection: $homeMainVM.selectedGoalArchiveMonth) {
                    ForEach(DatePickerMonth.allCases, id: \.self) { item in
                        Text(item.title)
                    }
                }.onChange(of: homeMainVM.selectedGoalArchiveMonth) { month in
                    homeMainVM.getInitHomeList()
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

struct HomeGoalArchiveSearchInputView_Previews: PreviewProvider {
    static var previews: some View {
        HomeGoalArchiveSearchInputView()
    }
}
