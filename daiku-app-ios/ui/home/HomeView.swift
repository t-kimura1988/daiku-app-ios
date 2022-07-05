//
//  HomeView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: HomeMainViewModel
    var body: some View {
        NavigationView {
            List{
                ForEach(vm.homeList) { item in
                    VStack(alignment: .leading) {
                        Text(item.title)
                        Divider()
                        Text(item.thoughts)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(3)
                    }
                    
                    VStack(alignment: .trailing) {
                        HStack {
                            Text(item.accountName())
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {vm.createGoalSheet()}, label: {Text("目標作成")})
                }
            }
            .fullScreenCover(isPresented: $vm.isSheet) {
                GoalCreateView()
                    .environmentObject(GoalCreateViewModel())
            }
            .navigationTitle("ホーム")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
