//
//  StoryDetailParts.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/08.
//

import SwiftUI

struct StoryDetailParts: View {
    @EnvironmentObject var ideaDetailVM: IdeaDetailViewModel
    
    var body: some View {
        let idea: IdeaSearchResponse = ideaDetailVM.idea
        let charas: [StoryCharacterResponse] = ideaDetailVM.charas
        
        Text(idea.getTitle())
            .font(.title3)
            .fontWeight(.bold)
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 8.0) {
                ForEach(charas) { chara in
                    Text(chara.charaName)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1))
                        .onTapGesture {
                            ideaDetailVM.openCharaDetail(item: chara)
                        }
                }
                if charas.count < 5 {
                    Button(action: {
                        ideaDetailVM.openCreateCharaSheet()
                    }, label: {
                        Image(systemName: "person.badge.plus")
                            .resizable()
                            .frame(width: 50, height: 50)
                    })
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 1))
                    
                }
            }
            .frame(width: .infinity, height: 100)
        }
        HStack(alignment: .top) {
            if idea.getStoryBody().isEmpty {
                Text("ここをタップして物語を書いてみましょう")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            } else {
                Text(idea.getStoryBody())
                    .multilineTextAlignment(.leading)
            }
        }
        .onTapGesture {
            ideaDetailVM.openStoryBodySheet()
        }
    }
}

struct StoryDetailParts_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailParts()
    }
}
