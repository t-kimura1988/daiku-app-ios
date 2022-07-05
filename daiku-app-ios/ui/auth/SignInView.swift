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
    
    var body: some View {
            VStack {
                Button{
                    handleLogin()
                } label: {
                    HStack(spacing: 15) {
                        Text("Google Sign In")
                    }
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .strokeBorder(.blue)
                    )
                }
                .navigationTitle(Text("ログイン"))
                .navigationBarTitleDisplayMode(.inline)
                
                route.toPrivacyPolicyView()
                
                
                route.toTermsOfUseView()
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
