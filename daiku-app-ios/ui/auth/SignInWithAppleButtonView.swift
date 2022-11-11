//
//  SignInWithAppleButtonView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/08/26.
//
import SwiftUI
import AuthenticationServices

/**
 Apple SignIn Button View
 
 
 アップルログインボタンの部品  SignInWithAppleButtonを使用
 */
struct SignInWithAppleButtonView: View {
    @EnvironmentObject var vm: AccountExistViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        SignInWithAppleButton(
            onRequest: {request in
                vm.setNonce()
                request.requestedScopes = [.email, .fullName]
                request.nonce = vm.requestNonce
            },
            onCompletion: {result in
                switch result {
                case .success(let authResult):
                    vm.singInWithApple(authResult: authResult)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        )
        .frame(width: 250, height: 50)
        .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
        .cornerRadius(30)
        
        
    }
}

fileprivate struct SignInWithAppleBUtton: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
}

struct SignInWithAppleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleButtonView()
    }
}
