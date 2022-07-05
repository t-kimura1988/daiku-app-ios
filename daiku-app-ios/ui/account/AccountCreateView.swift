//
//  AccountCreateView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

import SwiftUI

struct AccountCreateView: View {
    
    @EnvironmentObject var vm: AccountExistViewModel
    @EnvironmentObject var createViewModel: AccountCreateViewModel
    
    var body: some View {
        Form{
            TextField("氏名(姓)", text: $createViewModel.familyName)
            TextField("氏名(名)", text: $createViewModel.givenName)
            TextField("ニックネーム", text: $createViewModel.nickName)
        }
        Button("Button", action: {createAccount()})
            .frame(maxWidth: .infinity, minHeight: 44.0)
            .background(Color.orange.ignoresSafeArea(edges: .bottom))
    }
    
    private func createAccount() {
        createViewModel.createAccount {_ in
            
            vm.loginStateToSignIn()
        }
    }
}

struct AccountCreateView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreateView()
    }
}
