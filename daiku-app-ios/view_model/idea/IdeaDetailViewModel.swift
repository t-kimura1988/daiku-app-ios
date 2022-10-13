//
//  IdeaDetailViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/03.
//

import Foundation

class IdeaDetailViewModel: ObservableObject {
    @Published var idea: IdeaSearchResponse = IdeaSearchResponse()
    @Published var charas: [StoryCharacterResponse] = [StoryCharacterResponse]()
    @Published var chara: StoryCharacterResponse = StoryCharacterResponse()
    @Published var isStoryCreateSheet: Bool = false
    @Published var isCharaCreate: Bool = false
    @Published var isCharaDetail: Bool = false
    @Published var isStoryBodySheet: Bool = false
    
    private var ideaRepository: IdeaRepository = IdeaRepository()
    private var storyCharacterRepository: StoryCharacterRepository = StoryCharacterRepository()
    
    func getDetail(ideaId: Int) {
        Task {
            let res = try await ideaRepository.ideaDetail(param: .init(ideaId: ideaId))
            DispatchQueue.main.async {
                self.idea = res
            }
            
            if res.getStoryId() > 0 {
                let res = try await storyCharacterRepository.storyCharacters(param: .init(ideaId: res.id, storyId: res.getStoryId()))
                
                DispatchQueue.main.async {
                    self.charas = res
                }
            }
        }
    }
    
    func openStoryCreateSheet() {
        isStoryCreateSheet = true
    }
    
    func closeStoryCreateSheet() {
        isStoryCreateSheet = false
    }
    
    func openCreateCharaSheet() {
        chara = StoryCharacterResponse()
        
        isCharaCreate = true
    }
    
    func openUpdateCharaSheet() {
        isCharaDetail = false
        isCharaCreate = true
    }
    
    func closeCreateCharaSheet() {
        isCharaCreate = false
    }
    
    func openCharaDetail(item: StoryCharacterResponse) {
        isCharaDetail = true
        chara = item
    }
    
    func closeCharaDetail() {
        isCharaDetail = false
        chara = StoryCharacterResponse()
    }
    
    func openStoryBodySheet() {
        isStoryBodySheet = true
    }
    
    func closeStoryBodySheet() {
        DispatchQueue.main.async {
            self.isStoryBodySheet = false
        }
    }
}
