//
//  ProcessCreateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/06.
//

import Foundation
import Combine

class ProcessCreateViewModel: ObservableObject {
    @Published var processId: Int = 0
    @Published var goalId: Int = 0
    @Published var goalCreateDate: String = ""
    @Published var title: String = ""
    @Published var body: String = ""
    @Published var selectedProcessStatus: ProcessStatus = .New
    @Published var selectedProcessPriority: ProcessPriority = .Low
    @Published var formType: ProcessCreateFormType = .Not
    @Published var isFormSheet: Bool = false
    @Published var isSaveButton: Bool = false
    @Published var isSending: Bool = false
    
    private var processRepository: ProcessRepository = ProcessRepository()
    
    func openTitleForm() {
        isFormSheet = true
        formType = .Title
    }
    func openBodyForm() {
        isFormSheet = true
        formType = .Body
    }
    
    func initItem(processId: Int = 0, goalId: Int = 0, goalCreateDate: String = "", title: String, body: String, process: String, priority: String) {
        self.processId = processId
        self.goalId = goalId
        self.goalCreateDate = goalCreateDate
        self.title = title
        self.body = body
        self.selectedProcessStatus = ProcessStatus.init(rawValue: process)
        self.selectedProcessPriority = ProcessPriority.init(rawValue: priority)
    }
    
    func changeText(text: String) {
        switch formType {
        case .Not:
            break
        case .Title:
            title = String(text.prefix(textCount()))
        case .Body:
            body = String(text.prefix(textCount()))
        }
        isFormSheet = false
    }
    
    func textCount() -> Int {
        switch formType {
        case .Not:
            return 0
        case .Title:
            return 300
        case .Body:
            return 5000
        }
    }
    
    func saveProcess(completion: @escaping () -> Void) {
        isSending = true
        if processId == 0 {
            Task {
                do {
                    let _ = try await processRepository.saveProcess(request: .init(goalId: goalId, goalCreateDate: goalCreateDate, title: title, body: body, processStatus: selectedProcessStatus.code, priority: selectedProcessPriority.code))
                    DispatchQueue.main.async {
                        self.isSending = false
                    }
                    completion()
                } catch ApiError.responseError {
                }
            }
        } else {
            Task {
                do {
                    let _ = try await processRepository.updateProcess(request: .init(processId: processId, goalId: goalId, goalCreateDate: goalCreateDate, title: title, body: body, processStatus: selectedProcessStatus.code, priority: selectedProcessPriority.code))
                    
                    completion()
                } catch ApiError.responseError {
                }
            }
            
        }
    }
    
    func initVali() {
        let titleVali = $title.map({ !$0.isEmpty && !$0.moreGreater(size: 300) }).eraseToAnyPublisher()
        let bodyVali = $body.map({ !$0.moreGreater(size: 5000)}).eraseToAnyPublisher()
        
        Publishers.CombineLatest(titleVali, bodyVali)
            .map({ [$0.0, $0.1] })
            .map({ $0.allSatisfy{ $0 }})
            .assign(to: &$isSaveButton)
        
    }
}

enum ProcessCreateFormType {
    case Not
    case Title
    case Body
}
