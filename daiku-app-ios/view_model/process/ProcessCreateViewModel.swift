//
//  ProcessCreateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/06.
//

import Foundation

class ProcessCreateViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var body: String = ""
    @Published var selectedProcessStatus: ProcessStatus = .New
    @Published var selectedProcessPriority: ProcessPriority = .Low
    @Published var formType: ProcessCreateFormType = .Not
    @Published var isFormSheet: Bool = false
    
    private var processRepository: ProcessRepository = ProcessRepository()
    
    func openTitleForm() {
        isFormSheet = true
        formType = .Title
    }
    func openBodyForm() {
        isFormSheet = true
        formType = .Body
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
    
    func saveProcess(goalId: Int, goalCreateDate: String, completion: @escaping () -> Void) {
        print("save process")
        print(goalId)
        print(goalCreateDate)
        Task {
            do {
                let _ = try await processRepository.saveProcess(request: .init(goalId: goalId, goalCreateDate: goalCreateDate, title: title, body: body, processStatus: selectedProcessStatus.code, priority: selectedProcessPriority.code))
                
                completion()
            } catch ApiError.responseError {
                print("ERRORRRRORRRRR")
            }
        }
    }
    
    func validation() -> Bool {
        return false
    }
}

enum ProcessCreateFormType {
    case Not
    case Title
    case Body
}
