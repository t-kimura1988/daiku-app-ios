//
//  ProcessDetailViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/07.
//

import Foundation
import Combine

class ProcessDetailViewModel: ObservableObject {
    @Published var process: ProcessResponse = ProcessResponse()
    @Published var processHistoryList: [ProcessHistoryResponse] = [ProcessHistoryResponse]()
    @Published var isCommentCreateSheet: Bool = false
    @Published var isCommentUpdateSheet: Bool = false
    @Published var isStatusUpdateSheet: Bool = false
    @Published var processHistoryId: Int = 0
    
    private var processRepository: ProcessRepository = ProcessRepository()
    private var processHistoryRepository: ProcessHistoryRepository = ProcessHistoryRepository()
    
    func getProcessDetail(processId: Int, goalCreateDate: String, goalId: Int) {
        Task {
            let processRes = try await processRepository.processDetail(parameter: .init(processId: processId, goalCreateDate: goalCreateDate))
            
            DispatchQueue.main.async {
                self.process = processRes
            }
        }
        
        Task {
            let historyList = try await processHistoryRepository.processHistoryList(parameter: .init(processId: processId))

            DispatchQueue.main.async {
                self.processHistoryList = historyList
            }
        }
        
    }
    
    func changeCommentSheet() {
        self.isCommentCreateSheet = !self.isCommentCreateSheet
    }
    
    func changeCommentUpdateSheet(processHistoryId: Int) {
        self.processHistoryId = processHistoryId
        self.isCommentUpdateSheet = !self.isCommentUpdateSheet
    }
    
    func changeStatusUpdateSheet() {
        self.isStatusUpdateSheet = !self.isStatusUpdateSheet
    }
}
