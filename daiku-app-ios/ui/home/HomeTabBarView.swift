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
                .environmentObject(HomeMainViewModel())
                .tabItem{
                    Text("Home")
                }
                .tag(1)
            
            AccountMainView()
                .environmentObject(AccountMainViewModel())
                .tabItem{
                    Text("Account")
                }
                .tag(2)
            
            
        }
    }
}

struct HomeTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabBarView()
    }
}
