//
//  GoalArchiveEditViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/20.
//

import Foundation

class GoalArchiveEditViewModel: ObservableObject {
    @Published var thoughts: String = ""
    @Published var publish: PublishLevel = .Own
    @Published var isFormSheet: Bool = false
    @Published var goalId: Int = 0
    @Published var createDate: String = ""
    @Published var formType: GoalArchiveFormType = .Not
    @Published var archiveId: Int = 0
    @Published var archiveCreateDate: String = ""
    @Published var isSaveButton: Bool = false
    @Published var isSending: Bool = false
    
    private var goalArchiveRepository: GoalArchiveRepository = GoalArchiveRepository()
    
    func openThoughtsForm() {
        formType = .Thoughts
        isFormSheet = !isFormSheet
    }
    
    func changeText(text: String) {
        switch formType {
        case .Not:
            break
        case .Thoughts:
            thoughts = String(text.prefix(textCount()))
        }
        isFormSheet = false
    }
    
    func textCount() -> Int {
        switch formType {
        case .Thoughts:
            return 5000
        case .Not:
            return 0
        }
    }
    
    func createArchive(completion: @escaping () -> Void) {
        isSending = true
        if archiveId == 0 && archiveCreateDate == "" {
            Task {
                let _ = try await goalArchiveRepository.create(request: .init(goalId: goalId, createDate: createDate, thoughts: thoughts, publish: publish.code))
                DispatchQueue.main.async {
                    self.isSending = false
                }
                completion()
            }
            
        } else {
            Task {
                let _ = try await goalArchiveRepository.update(request: .init(archiveId: archiveId, archiveCreateDate: archiveCreateDate, thoughts: thoughts, publish: publish.code))
                DispatchQueue.main.async {
                    self.isSending = false
                }
                completion()
            }
            
        }
    }
    
    func initItem(archiveId: Int, archiveCreateDate: String, goalId: Int, createDate: String, thoughts: String, publish: PublishLevel) {
        self.goalId = goalId
        self.createDate = createDate
        self.thoughts = thoughts
        self.publish = publish
        self.archiveId = archiveId
        self.archiveCreateDate = archiveCreateDate
    }
    
    func initVali() {
        let thoughtsVali = $thoughts.map({ !$0.isEmpty && !$0.moreGreater(size: 5000) }).eraseToAnyPublisher()
        
        thoughtsVali
            .map{return $0}
            .assign(to: &$isSaveButton)
        
    }
}



enum GoalArchiveFormType {
    case Not
    case Thoughts
}
