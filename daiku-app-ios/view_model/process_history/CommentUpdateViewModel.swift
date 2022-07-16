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
        Task {
            let res = try await processHistoryRepository.commentUpdate(request: .init(processHistoryId: processHistoryId, comment: comment))
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
    
}
