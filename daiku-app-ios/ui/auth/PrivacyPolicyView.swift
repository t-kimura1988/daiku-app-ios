//
//  PrivacyPolicyView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/18.
//

import SwiftUI

/**
 プライバシーポリシー画面
 
 
 プライバシーポリシー画面　WebView
 */
struct PrivacyPolicyView: View {
    var daikuHomePageUrl: String = Env["HOME_PAGE_URL"]!
    
    var body: some View {
        DaikuWebView(url: "\(daikuHomePageUrl)/privacy-policy")
            .navigationTitle("D-Aic")
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
