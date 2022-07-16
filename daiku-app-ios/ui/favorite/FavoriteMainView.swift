//
//  FavoriteMainView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/14.
//

import SwiftUI

struct FavoriteMainView: View {
    @EnvironmentObject var favoriteMainVM: FavoriteMainViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(favoriteMainVM.goalFavoriteList) { item in
                    NavigationLink {
                        
                            GoalDetailView(goalId: item.goalId, createDate: item.goalCreateDate)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.title)
                                    .lineLimit(1)
                                    .foregroundColor(.primary)
                                
                            
                                Text("追加日:\(item.favoriteAddDateFormat())")
                                .foregroundColor(Color.gray)
                                Text("期日:\(item.dueDateFormat())")
                                    .foregroundColor(Color.gray)
                                Text(item.purpose)
                                    .font(.body)
                                    .lineLimit(3)
                                    .padding(.top, 8)
                                    .foregroundColor(.primary)
                                
                                HStack {
                                    Spacer()
                                    Text("目標作成:\(item.goalCreateAccount())")
                                        .foregroundColor(Color.gray)
                                }
                            }
                            .padding(8)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                    
                    Divider()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(Text("お気に入り"))
        }
        .onAppear{
            favoriteMainVM.search()
        }
    }
}

struct FavoriteMainView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMainView()
    }
}
