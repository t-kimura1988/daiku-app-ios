//
//  TermsOfUseView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/18.
//

import SwiftUI

struct TermsOfUseView: View {
    var daikuHomePageUrl: String = Env["HOME_PAGE_URL"]!
    
    var body: some View {
        DaikuWebView(url: "\(daikuHomePageUrl)/terms-of-use")
            .navigationTitle("D-Aic")
    }
}

struct TermsOfUseView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfUseView()
    }
}
