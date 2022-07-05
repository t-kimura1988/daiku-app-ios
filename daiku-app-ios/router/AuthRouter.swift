//
//  AuthRouter.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/18.
//

import SwiftUI

struct AuthRouter {
    func toSignInViewLink() -> some View {
        return NavigationLink{
            SignInView()
        } label: {
            Text("ログイン")
        }
    }
    func toPrivacyPolicyView() -> some View {
        return NavigationLink{
            PrivacyPolicyView()
        } label: {
            Text("プライバシーポリシー")
        }
    }
    func toTermsOfUseView() -> some View {
        return NavigationLink{
            PrivacyPolicyView()
        } label: {
            Text("利用規約")
        }
    }
}
