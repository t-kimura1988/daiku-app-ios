//
//  UserImageView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/15.
//

import SwiftUI

struct UserImageView: View {
    private var userImage: String = ""
    private var placeholderType: ImagePlaceholderType = .samurai
    init(userImage: String, placeholderType: ImagePlaceholderType ) {
        self.userImage = userImage
        self.placeholderType = placeholderType
    }
    
    var body: some View {
        AsyncImage(url: URL(string: userImage)) { image in
            image
                .resizable()
        } placeholder: {
            switch self.placeholderType {
            case .samurai:
                Image("samurai")
                    .resizable()
            case .color:
                Color(.green)
            }
        }
    }
}

struct UserImageView_Previews: PreviewProvider {
    static var previews: some View {
        UserImageView(userImage: "", placeholderType: .samurai)
    }
}
