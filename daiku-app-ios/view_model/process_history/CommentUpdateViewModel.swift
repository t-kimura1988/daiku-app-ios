//
//  CommentUpdateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/13.
//

import Foundation

class CommentUpdateViewModel: ObservableObject {
    @Published var comment: String = ""
    @Published var processHistoryDetail: ProcessHistoryResponse = ProcessHistoryResponse()
    @Published var isFormSheet: Bool = false
    @Published var formType: ProcessHisotryFormType = .Not
    @Published var isSaveButton: Bool = false
    @Published var isSending: Bool = false
    
    private var processHistoryRepository: ProcessHistoryRepository = ProcessHistoryRepository()
    
    private var processHistoryId: Int = 0
    private var goalCreateDate: String = ""
    
    func detail() {
        Task {
            let res = try await processHistoryRepository.processHistoryDetail(parameter: .init(processHistoryId: processHistoryId, goalCreateDate: goalCreateDate))
            
            DispatchQueue.main.async {
                self.comment = res.getComment()
            }
        }
    }
    
    func updateComment(completion: @escaping (ProcessHistoryResponse) -> Void) {
        isSending = true
        Task {
            let res = try await processHistoryRepository.commentUpdate(request: .init(processHistoryId: processHistoryId, comment: comment))
            
            DispatchQueue.main.async {
                self.isSending = false
            }
            completion(res)
        }
    }
    
    func openCreateForm() {
        formType = .Comment
        isFormSheet = true
    }
    
    func initItem(processHistoryId: Int, goalCreateDate: String) {
        self.processHistoryId = processHistoryId
        self.goalCreateDate = goalCreateDate
    }
    
    func textCount() -> Int {
        switch formType {
        case .Not:
            return 0
        case .Comment:
            return 3000
        }
    }
    
    func changeText(text: String) {
        switch formType {
        case .Not:
            break
        case .Comment:
            comment = String(text.prefix(textCount()))
        }
        isFormSheet = false
    }
    
    
    func initVali() {
        let commentVali = $comment.map({ !$0.isEmpty && !$0.moreGreater(size: 3000) }).eraseToAnyPublisher()
        
        commentVali
            .map{return $0}
            .assign(to: &$isSaveButton)
        
    }
}
