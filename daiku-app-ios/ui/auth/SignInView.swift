//
//  SignInView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var vm: AccountExistViewModel
    var route: AuthRouter = AuthRouter()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
                Button{
                    handleLogin()
                } label: {
                    HStack {
                        Image("google-sign-in")
                        Text("Google Sign In")
                            .font(.title3)
                            .frame(alignment: .leading)
                            .padding(.leading, 5)
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                    .frame(width: 250, height: 50)
                    .background(
                        Capsule()
                            .strokeBorder(.blue)
                    )
                    .background(.white)
                }
                .cornerRadius(30)
                
                SignInWithAppleButtonView()
                    .padding(.bottom, 30)
                
                route.toPrivacyPolicyView()
                .padding(.bottom, 10)
                
                
                route.toTermsOfUseView()
            }
            .alert(isPresented: $vm.isDelAccount) {
                if (vm.isFirebaseAccountDel) {
                    return Alert(
                        title: Text("アカウント削除"),
                        message: Text("アカウントが完全に削除されています。復旧が必要な場合は管理者にお問合せください。"),
                        dismissButton: .cancel(Text("キャンセル"), action: {
                            vm.closeDelAccount()
                            
                        })
                    )
                } else {
                    return Alert(
                        title: Text("削除済みアカウント"),
                        message: Text("アカウントを復活できます。復活しますか？"),
                        primaryButton: .cancel(Text("キャンセル"), action: {
                            vm.closeDelAccount()
                            
                        }),
                        secondaryButton: .destructive(Text("復活"), action: {
                            vm.reUpdateAccount()
                        })
                    )
                }
            }
            .navigationTitle(Text("ログイン"))
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                vm.closeDelAccount()
            }
    }
    
    func handleLogin() {
        vm.googleSignIn(vc: getRootViewController())
    }
}

extension View {
    func getRootViewController()->UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
