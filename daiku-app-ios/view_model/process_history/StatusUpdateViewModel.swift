//
//  StatusUpdateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/14.
//

import Foundation

class StatusUpdteViewModel: ObservableObject {
    @Published var processStatus: ProcessStatus = .New
    @Published var priority: ProcessPriority = .Low
    @Published var isSending: Bool = false
    private var processId: Int = 0
    private var goalCreateDate: String = ""
    private var processHistoryRepository: ProcessHistoryRepository = ProcessHistoryRepository()
    
    func initItem(currentStatus: ProcessStatus, currentPriority: ProcessPriority, processId: Int) {
        self.processStatus = currentStatus
        self.priority = currentPriority
        self.processId = processId
    }
    
    
    func updateStatus(completion: @escaping (ProcessHistoryResponse) -> Void) {
        isSending = true
        Task {
            let res = try await processHistoryRepository.statusUpdate(request: .init(processId: processId, processStatus: processStatus.code, priority: priority.code))
            DispatchQueue.main.async {
                self.isSending = false
            }
            completion(res)
        }
    }
    
}
