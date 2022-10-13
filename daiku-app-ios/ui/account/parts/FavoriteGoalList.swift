//
//  FavoriteGoalList.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/25.
//

import SwiftUI

struct FavoriteGoalList: View {
    
    private var item: GoalFavoriteResponse = GoalFavoriteResponse()
    
    private var tapItem: () -> Void
    
    init(item: GoalFavoriteResponse, tapItem: @escaping () -> Void) {
        self.item = item
        self.tapItem = tapItem
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .fontWeight(.bold)
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
                    .multilineTextAlignment(.leading)
                
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
        .onTapGesture {
            tapItem()
        }
    }
}

struct FavoriteGoalList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteGoalList(item: GoalFavoriteResponse(), tapItem: {})
    }
}
