//
//  TermsOfUseView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/18.
//

import SwiftUI

struct TermsOfUseView: View {
    var body: some View {
        DaikuWebView(url: "http://localhost:3000/terms-of-use")
            .navigationTitle("D-Aic")
    }
}

struct TermsOfUseView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfUseView()
    }
}
