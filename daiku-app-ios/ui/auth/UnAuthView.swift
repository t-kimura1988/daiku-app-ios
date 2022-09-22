//
//  UnAuthView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

import SwiftUI

struct UnAuthView: View {
    @EnvironmentObject var vm: AccountExistViewModel
    var route: AuthRouter = AuthRouter()
    
    var daikuHomePageUrl: String = Env["HOME_PAGE_URL"]!
    
    var body: some View {
        NavigationView {
            DaikuWebView(url: "\(daikuHomePageUrl)/unauth")
                .navigationTitle("D-Aic")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    trailing: route.toSignInViewLink())
            
            Rectangle()
            .foregroundColor(Color.black)
            .opacity(1.0)
        }
        .navigationViewStyle(.stack)
    }
}

struct UnAuthView_Previews: PreviewProvider {
    static var previews: some View {
        UnAuthView()
    }
}
