//
//  CharacterCreateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/08.
//

import Foundation
import Combine

class CharacterCreateViewModel: ObservableObject {
    @Published var characterName: String = ""
    @Published var characterDesc: String = ""
    @Published var storyCharaId: Int = 0
    @Published var ideaId: Int = 0
    @Published var storyId: Int = 0
    @Published var leaderFlg: Bool = false
    
    @Published var isSaveButton: Bool = false
    
    private var storyCharacterRepository: StoryCharacterRepository = StoryCharacterRepository()
    
    func initItem(storyCharaId: Int = 0, ideaId: Int = 0, storyId: Int = 0, charaName: String = "", charaDesc: String = "") {
        
        self.storyCharaId = storyCharaId
        self.ideaId = ideaId
        self.storyId = storyId
        self.characterName = charaName
        self.characterDesc = charaDesc
    }
    
    func createChara(compilate: @escaping (Int) -> Void) {
        if storyCharaId == 0 {
            
            Task {
                let res = try await storyCharacterRepository.saveStroyCharacter(request: .init(ideaId: self.ideaId, storyId: self.storyId, charaName: characterName, charaDesc: characterDesc, leaderFlg: leaderFlg ? "1" : "0"))
                
                compilate(res.ideaId)
            }
        } else {
            Task {
            }
        }
    }
    
    func changeLeaderFlg() {
        leaderFlg = !leaderFlg
    }
    
    func chkCharaDesc(newText: String) {
        if newText.count > 100 {
            characterDesc = String(newText.prefix(100))
        }
    }
    
    func chkCharaName(newText: String) {
        if newText.count > 50 {
            characterDesc = String(newText.prefix(50))
        }
    }
    
    func initValidate() {
        
        let charanameVali = $characterName.map({ !$0.isEmpty }).eraseToAnyPublisher()
        let charaDescVali = $characterDesc.map({ !$0.isEmpty }).eraseToAnyPublisher()
        Publishers.CombineLatest(charanameVali, charaDescVali)
            .map({ [$0.0, $0.1] })
            .map({ $0.allSatisfy{ $0 }})
            .assign(to: &$isSaveButton)
    }
}
