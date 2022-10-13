//
//  AccountCreateView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

import SwiftUI
import Combine

struct AccountCreateView: View {
    
    @EnvironmentObject var vm: AccountExistViewModel
    @EnvironmentObject var createViewModel: AccountCreateViewModel
    @EnvironmentObject var accountMainVM: AccountMainViewModel
    
    private var familyName: String = ""
    private var givenName: String = ""
    private var nickName: String  = ""
    private var isClose: Bool = false
    private var accountId: Int = 0
    
    private var closeSheet: () -> Void
    
    init(accountId: Int = 0, familyName: String = "", givenName: String = "", nickName: String = "", closeSheet: @escaping () -> Void = {}, isClose: Bool = false) {
        self.familyName = familyName
        self.givenName = givenName
        self.nickName = nickName
        self.closeSheet = closeSheet
        self.isClose = isClose
        self.accountId = accountId
    }
    
    var body: some View {
        VStack {
            if isClose {
                HStack {
                    Button(action: {
                        createViewModel.openDeleteAlert()
                    }, label: {
                        Text("削除")
                            .foregroundColor(.red)
                    })
                    .padding(.leading, 8)
                    Spacer()
                    Button(action: {closeSheet()}, label: {
                        Text("閉じる")
                    })
                    .padding(.trailing, 8)
                }
            }
            Form{
                if createViewModel.isError {
                    Text(createViewModel.errorMsm)
                        .foregroundColor(.red)
                }
                TextField("氏名(姓)", text: $createViewModel.familyName)
                    .onReceive(Just($createViewModel.familyName)) {_ in
                        createViewModel.chkFamilyNameText(text: createViewModel.familyName)
                    }
                TextField("氏名(名)", text: $createViewModel.givenName)
                    .onReceive(Just($createViewModel.givenName)) {_ in
                        createViewModel.chkGivenNameText(text: createViewModel.givenName)
                    }
                TextField("ニックネーム", text: $createViewModel.nickName)
                    .onReceive(Just($createViewModel.nickName)) {_ in
                        createViewModel.chkNickNameText(text: createViewModel.nickName)
                    }
                Text("※ニックネームは半角英数字で入力してください。")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Button(action: {
                createAccount()
                
            }, label: {
                Text(isClose ? "更新" : "登録")
                    .foregroundColor(createViewModel.isSaveButton ? .white : .gray)
            })
            .disabled(!createViewModel.isSaveButton)
                .frame(maxWidth: .infinity, minHeight: 44.0)
                .background(Color.orange.ignoresSafeArea(edges: .bottom))
        }.onAppear {
            createViewModel.initItem(accountId: accountId, familyName: familyName, givenName: givenName, nickName: nickName)
            createViewModel.initVali()
        }
        .alert(isPresented: $createViewModel.isAlert) {
            Alert(
                title: Text("アカウント削除"),
                message: Text("アカウントを削除します。本当によろしいでしょうか？\n・削除してから１ヶ月以内に再ログインいただけましたら、データは復旧します。\n・削除してから1ヶ月を過ぎますと、今まで作成したデータを参照できなくなりますのでご注意ください。")
                    .fontWeight(.bold),
                primaryButton: .cancel(Text("キャンセル"), action: {createViewModel.closeDeleteAlert()}),
                secondaryButton: .destructive(Text("削除"), action: {
                    createViewModel.deleteAccount(completion: { account in
                        vm.logout()
                    })})
            )
        }
    }
    
    private func createAccount() {
        if createViewModel.isSaveButton {
            createViewModel.createAccount {_ in
                vm.loginStateToSignIn()
                closeSheet()
            }
        }
    }
}

struct AccountCreateView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreateView()
    }
}
