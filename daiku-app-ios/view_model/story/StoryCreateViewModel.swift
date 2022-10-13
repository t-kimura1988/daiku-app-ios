//
//  StoryCreateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/06.
//

import Foundation

class StoryCreateViewModel: ObservableObject {
    @Published var title: String = ""
    
    private var storyRepository: StoryRepository = StoryRepository()
    
    func chkTitle(newText: String) {
        if newText.count > 100 {
            title = String(newText.prefix(100))
        }
    }
    
    func save(ideaId: Int, completion: @escaping (Int) -> Void) {
        Task {
            do {
                var res = try await storyRepository.saveStroy(request:.init(ideaId: String(ideaId), title: title))
                completion(res.ideaId)
            } catch ApiError.responseError(let err) {
                print(err)
            }
            
            
        }
    }
}
