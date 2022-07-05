//
//  PrivacyPolicyView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/18.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        DaikuWebView(url: "http://localhost:3000/privacy-policy")
            .navigationTitle("D-Aic")
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
