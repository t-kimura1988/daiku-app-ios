//
//  HomeView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: HomeMainViewModel
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(vm.homeList) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(item.thoughts)
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(3)
                                .padding(.top, 1)
                        }
                        Spacer()
                    }.padding()
                    
                    
                    VStack(alignment: .trailing) {
                        HStack {
                            Text(item.accountName())
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                    Divider()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {vm.createGoalSheet()}, label: {Text("目標作成")})
                }
            }
            .fullScreenCover(isPresented: $vm.isSheet) {
                GoalCreateView()
                    .environmentObject(GoalCreateViewModel())
            }
            .navigationTitle("ホーム")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
