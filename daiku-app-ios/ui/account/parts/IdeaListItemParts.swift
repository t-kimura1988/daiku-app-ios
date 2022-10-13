//
//  IdeaListItemParts.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/03.
//

import SwiftUI

struct IdeaListItemParts: View {
    private var item: IdeaSearchResponse = IdeaSearchResponse()
    @Environment(\.colorScheme) var colorScheme
    private var tapItem: () -> Void
    
    init(item: IdeaSearchResponse, tapItem: @escaping () -> Void) {
        self.item = item
        self.tapItem = tapItem
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    UserImageView(userImage: item.getAccountImageURL(), placeholderType: .samurai)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .background(colorScheme == .dark ? Color.black : Color.white)
                        .clipShape(Circle())
                    Text("\(item.createdAccountFamilyName) \(item.createdAccountGivenName)")
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.bottom, 8)
                Text(item.body)
                    .font(.body)
                    .lineLimit(5)
                    .padding(5)
                
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            tapItem()
        }
        
        Divider()
            .frame(maxWidth: .infinity)
            .background(colorScheme == .dark ? Color.white : Color.black)
    }
}

struct IdeaListItemParts_Previews: PreviewProvider {
    static var previews: some View {
        IdeaListItemParts(item: IdeaSearchResponse(), tapItem: {})
    }
}
