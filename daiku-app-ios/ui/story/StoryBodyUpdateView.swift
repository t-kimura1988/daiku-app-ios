//
//  StoryBodyUpdateView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/10.
//

import SwiftUI

struct StoryBodyUpdateView: View {
    @EnvironmentObject private var storyBodyUpdateVM: StoryBodyUpdateViewModel
    @EnvironmentObject private var ideaDetailVM: IdeaDetailViewModel
    var body: some View {
        DaikuFormEditor(text: storyBodyUpdateVM.storyBody, maxSize: 2000, changeText: { text in
            storyBodyUpdateVM.save(text: text) { idea in
                ideaDetailVM.getDetail(ideaId: idea.id)
                ideaDetailVM.closeStoryBodySheet()
            }
        })
    }
}

struct StoryBodyUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        StoryBodyUpdateView()
    }
}
