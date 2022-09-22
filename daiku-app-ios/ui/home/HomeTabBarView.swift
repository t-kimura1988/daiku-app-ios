//
//  HomeTabBarView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/18.
//

import SwiftUI

struct HomeTabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("達成")
                }
                .tag(1)
            
            AccountMainView()
                .tabItem{
                    Image(systemName: "person")
                    Text("アカウント")
                }
                .tag(2)
        }
        .environmentObject(HomeMainViewModel())
        .environmentObject(AccountMainViewModel())
        .environmentObject(GoalDetailViewModel())
        .environmentObject(ProcessDetailViewModel())
        .environmentObject(FavoriteMainViewModel())
        .environmentObject(GoalArchiveDetailViewModel())
        .environmentObject(MakiDetailViewModel())
    }
}

struct HomeTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabBarView()
    }
}
