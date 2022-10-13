//
//  GoalListItemParts.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/16.
//

import SwiftUI

struct GoalListParts: View {
    private var item: GoalResponse = GoalResponse()
    @EnvironmentObject var accountMainVM: AccountMainViewModel
    @Environment(\.colorScheme) var colorScheme
    
    private var tapItem: () -> Void
    
    init(item: GoalResponse, tapItem: @escaping () -> Void) {
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
                if item.isArchive() {
                    Text("達成済")
                        .fontWeight(.bold)
                        .padding(8)
                        .background(.green)
                        .foregroundColor(.primary)
                        .cornerRadius(15)
                        .compositingGroup()
                        .shadow(color: .gray, radius: 3, x: 1, y: 1)
                }
                Text("完了予定日:\(item.dueDateFormat())")
                    .foregroundColor(Color.gray)
                
                Text("作成日:\(item.createDateDisp())")
                    .foregroundColor(Color.gray)
                
                Text("\(item.getMakiKey()) \(item.makiSort())")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(item.purpose)
                    .font(.body)
                    .lineLimit(5)
                    .padding(.top, 8)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
            }
            .padding(8)
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            tapItem()
        }
        
        
        VStack(alignment: .center, spacing: 0) {
            FavoriteButton(goal: item, changeFavorite: { goalId, createDate in
                
                accountMainVM.changeGoalFavorite(request: .init(goalId: goalId, goalCreateDate: createDate)) {
                    
                }
            })
        }.padding(.top, 10)
        
        Divider()
            .frame(maxWidth: .infinity)
            .background(colorScheme == .dark ? Color.white : Color.black)
        
    }
}

struct GoalListParts_Previews: PreviewProvider {
    static var previews: some View {
        GoalListParts(item: GoalResponse(), tapItem: {})
    }
}
