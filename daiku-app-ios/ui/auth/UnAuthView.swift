//
//  UnAuthView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

import SwiftUI

/**
 認証情報がない場合表示されるホーム画面
 
 
 認証セッションがない場合に表示されるホーム画面です。アプリの説明等が表示されます。
 
 またこの画面からログイン画面に遷移できます。
 */
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
