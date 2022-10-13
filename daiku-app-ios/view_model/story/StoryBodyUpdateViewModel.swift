//
//  StoryBodyUpdateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/10.
//

import Foundation

class StoryBodyUpdateViewModel: ObservableObject {
    @Published var storyBody: String = ""
    private var storyRepository: StoryRepository = StoryRepository()
    private var storyId: Int = 0
    private var ideaId: Int = 0
    
    init(text: String, ideaId: Int, storyId: Int) {
        self.storyBody = text
        self.storyId = storyId
        self.ideaId = ideaId
    }
    
    func chkBody(newText: String) {
        if newText.count > 2000 {
            storyBody = newText
        }
    }
    
    func save(text: String, completion: @escaping (IdeaSearchResponse) -> Void) {
        Task {
            let res = try await storyRepository.updateStoryBody(request: .init(storyId: String(self.storyId), ideaId: String(self.ideaId), storyBody: text))
            completion(res)
        }
    }
}
