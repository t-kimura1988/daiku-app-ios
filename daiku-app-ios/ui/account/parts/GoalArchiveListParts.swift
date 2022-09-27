//
//  GoalArchiveListParts.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/27.
//

import SwiftUI

struct GoalArchiveListParts: View {
    
    private var item: GoalArchiveInfoResponse = GoalArchiveInfoResponse()
    init(item: GoalArchiveInfoResponse) {
        self.item = item
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                Text(item.thoughts)
                    .font(.body)
                    .lineLimit(3)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                HStack {
                    Text(item.getPublish().title)
                        .fontWeight(.bold)
                        .padding(8)
                        .background(.green)
                        .foregroundColor(.primary)
                        .cornerRadius(15)
                        .compositingGroup()
                        .shadow(color: .gray, radius: 3, x: 1, y: 1)
                    if item.isUpdating() {
                        Text("更新中")
                            .fontWeight(.bold)
                            .padding(8)
                            .background(.red)
                            .foregroundColor(.primary)
                            .cornerRadius(15)
                            .compositingGroup()
                            .shadow(color: .gray, radius: 3, x: 1, y: 1)
                    }
                }
            }
            .padding(8)
            Spacer()
        }
    }
}

struct GoalArchiveListParts_Previews: PreviewProvider {
    static var previews: some View {
        GoalArchiveListParts(item: GoalArchiveInfoResponse())
    }
}
