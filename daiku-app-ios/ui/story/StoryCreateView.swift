//
//  StoryCreateView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/06.
//

import SwiftUI
import Combine

struct StoryCreateView: View {
    @EnvironmentObject private var storyCreateVM: StoryCreateViewModel
    @EnvironmentObject var ideaDetailVM: IdeaDetailViewModel
    @Environment(\.dismiss) var dismiss
    private var ideaId: Int = 0
    
    init(ideaId: Int) {
        self.ideaId = ideaId
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("物語タイトル", text: $storyCreateVM.title)
                        .onChange(of: storyCreateVM.title) { newText in
                            storyCreateVM.chkTitle(newText: newText)
                        }
                    
                    Button(action: {
                        storyCreateVM.save(ideaId: ideaId) { id in
                            ideaDetailVM.getDetail(ideaId: id)
                            ideaDetailVM.closeStoryCreateSheet()
                        }
                    }, label: {
                        Text("save")
                    })
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.left")
                    })
                }
            }
        }
    }
}

struct StoryCreateView_Previews: PreviewProvider {
    static var previews: some View {
        StoryCreateView(ideaId: 0)
    }
}
