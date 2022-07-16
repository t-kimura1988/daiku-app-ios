//
//  ProcessHistoryCreateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/10.
//

import Foundation

class ProcessHistoryCommentCreateViewModel: ObservableObject {
    
    @Published var comment: String  = ""
    @Published var selectedProcessStatus: ProcessStatus = .New
    @Published var selectedProcessPriority: ProcessPriority = .Low
    @Published var isFormSheet: Bool = false
    
    @Published var formType: ProcessHisotryFormType = .Not
    
    private var processId: Int = 0
    
    private var processHisotryRepository: ProcessHistoryRepository = ProcessHistoryRepository()
    func saveComment( completion: @escaping (ProcessHistoryResponse) -> Void) {
        Task {
            
            let res = try await processHisotryRepository.commentSave(request: .init(processId: processId, comment: comment, processStatus: selectedProcessStatus.code, priority: selectedProcessPriority.code))
            
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
}



enum ProcessHisotryFormType {
    case Not
    case Comment
}
