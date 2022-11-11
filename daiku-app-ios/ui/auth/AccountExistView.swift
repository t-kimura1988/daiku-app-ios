//
//  AccountExistView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

import SwiftUI

/**
 認証確認View
 
 
 認証がない場合：　サインイン画面
 
 ローディング中：　ローディング画面
 
 認証中の場合    :     ホーム画面
 
 アカウント未登録:  アカウント登録画面
 */
struct AccountExistView: View {
    @EnvironmentObject var vm: AccountExistViewModel
    var body: some View {
        switch vm.state {
        case .Loading: LoadingView()
        case .SignOut: UnAuthView()
        case .SignIn: HomeTabBarView()
        case .SignIn_NoExist: AccountCreateView().environmentObject(AccountCreateViewModel())
        }
    }
    
    func createAccount(familyName: String, givenName: String, nickName: String) {
        
    }
}
