//
//  HomeTabBarView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/18.
//

import SwiftUI

struct HomeTabBarView: View {
    @State private var isSheet: Bool = false
    @EnvironmentObject var accountMainVM: AccountMainViewModel
    var body: some View {
        ZStack {
            TabView {
                HomeView()
                    .tabItem{
                        Image(systemName: "house")
                        Text("達成")
                    }
                    .tag(1)
                
                AccountMainView()
                    .tabItem{
                        Image(systemName: "person")
                        Text("アカウント")
                    }
                    .tag(2)
                
                ScheduleMainView()
                    .tabItem{
                        Image(systemName: "calendar")
                        Text("予定")
                    }
                    .environmentObject(StoreViewModel())
                    .tag(2)
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isSheet = true
                    }, label: {
                        Text("閃")
                            .foregroundColor(.white)
                    })
                    .frame(width: 50, height: 50)
                    .background(.orange)
                    .clipShape(Circle())
                    .offset(x: -40, y: -70)
                }
            }
        }
        .sheet(isPresented: $isSheet) {
            IdeaCreateView(comp: {
                accountMainVM.getInitIdeaList()
                isSheet = false
            })
        }
    }
}

struct HomeTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabBarView()
    }
}
