//
//  UnAuthView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

import SwiftUI

struct UnAuthView: View {
    var route: AuthRouter = AuthRouter()
    var body: some View {
        NavigationView {
            DaikuWebView(url: "http://localhost:3000/unauth")
                .navigationTitle("D-Aic")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    trailing: route.toSignInViewLink())
        }
    }
}

struct UnAuthView_Previews: PreviewProvider {
    static var previews: some View {
        UnAuthView()
    }
}
