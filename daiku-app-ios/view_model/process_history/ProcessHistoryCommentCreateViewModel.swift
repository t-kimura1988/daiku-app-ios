//
//  ProcessHistoryCreateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/10.
//

import Foundation
import Combine

class ProcessHistoryCommentCreateViewModel: ObservableObject {
    
    @Published var comment: String  = ""
    @Published var selectedProcessStatus: ProcessStatus = .New
    @Published var selectedProcessPriority: ProcessPriority = .Low
    @Published var isFormSheet: Bool = false
    
    @Published var formType: ProcessHisotryFormType = .Not
    
    @Published var isSaveButton: Bool = false
    
    @Published var isSending: Bool = false
    
    private var processId: Int = 0
    
    private var processHisotryRepository: ProcessHistoryRepository = ProcessHistoryRepository()
    func saveComment( completion: @escaping (ProcessHistoryResponse) -> Void) {
        isSending = true
        Task {
            
            let res = try await processHisotryRepository.commentSave(request: .init(processId: processId, comment: comment, processStatus: selectedProcessStatus.code, priority: selectedProcessPriority.code))
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
    
    func initItem(status: ProcessStatus, priority: ProcessPriority, processId: Int) {
        self.processId = processId
        self.selectedProcessStatus = status
        self.selectedProcessPriority = priority
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
            .map {
                return $0
            }
            .assign(to: &$isSaveButton)
        
    }
}



enum ProcessHisotryFormType {
    case Not
    case Comment
}
