//
//  AccountExistView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

import SwiftUI

struct AccountExistView: View {
    @EnvironmentObject var vm: AccountExistViewModel
    var body: some View {
        switch vm.state {
        case .Loading: LoadingView()
        case .SignOut: UnAuthView()
        case .SignIn: HomeTabBarView()
                .environmentObject(IdeaCreateViewModel())
                .environmentObject(HomeMainViewModel())
                .environmentObject(AccountMainViewModel())
                .environmentObject(GoalDetailViewModel())
                .environmentObject(ProcessDetailViewModel())
                .environmentObject(FavoriteMainViewModel())
                .environmentObject(GoalArchiveDetailViewModel())
                .environmentObject(MakiDetailViewModel())
        case .SignIn_NoExist: AccountCreateView().environmentObject(AccountCreateViewModel())
        }
    }
    
    func createAccount(familyName: String, givenName: String, nickName: String) {
        
    }
}
