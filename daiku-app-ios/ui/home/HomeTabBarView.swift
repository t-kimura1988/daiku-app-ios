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
                    Text("Home")
                }
                .tag(1)
            
            FavoriteMainView()
                .tabItem{
                    Text("Favorite")
                }
                .tag(2)
            
            AccountMainView()
                .tabItem{
                    Text("Account")
                }
                .tag(3)
        }
        .environmentObject(HomeMainViewModel())
        .environmentObject(AccountMainViewModel())
        .environmentObject(GoalDetailViewModel())
        .environmentObject(ProcessDetailViewModel())
        .environmentObject(FavoriteMainViewModel())
    }
}

struct HomeTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabBarView()
    }
}
