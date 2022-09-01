//
//  GoalCreateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/30.
//

import Foundation
import Combine

class GoalCreateViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var purpose: String = ""
    @Published var aim: String = ""
    @Published var goalId: Int = 0
    @Published var createDate: String = ""
    @Published var selectedDueDate: Date = Date()
    
    @Published var isFormSheet: Bool = false
    @Published var formType: FormType = .Not
    @Published var isSaveButton: Bool = false
    @Published var isSending: Bool = false
    
    private var goalRepository: GoalRepository = GoalRepository()
    
    func initUpdate(goalId: Int, createDate: String, title: String, purpose: String, aim: String, dueDate: String) {
        self.goalId = goalId
        self.createDate = createDate
        self.title = title
        self.purpose = purpose
        self.aim = aim
        self.selectedDueDate = dueDate.toDate()
    }
    
    func openTitleForm() {
        isFormSheet = true
        formType = .Title
    }
    func openPurposeForm() {
        isFormSheet = true
        formType = .Purpose
    }
    func openAimForm() {
        isFormSheet = true
        formType = .Aim
    }
    
    func changeText(text: String) {
        switch formType {
        case .Not:
            break
        case .Title:
            title = String(text.prefix(textCount()))
        case .Purpose:
            purpose = text
        case .Aim:
            aim = text
        }
        isFormSheet = false
    }
    
    func textCount() -> Int {
        switch formType {
        case .Not:
            return 0
        case .Title:
            return 300
        case .Purpose:
            return 5000
        case .Aim:
            return 5000
        }
    }
    
    func saveGoal(completion: @escaping (GoalResponse) -> Void) {
        isSending = true
        if goalId == 0 {
            Task {
                let res = try await goalRepository.saveGoal(request: .init(title: title, purpose: purpose, aim: aim, dueDate: selectedDueDate.toString(format: "yyyy-MM-dd")))
                
                DispatchQueue.main.async {
                    self.isSending = false
                }
                
                completion(res)
            }
        } else {
            Task {
                let res = try await goalRepository.updateGoal(request: .init(goalId: goalId, createDate: createDate, title: title, purpose: purpose, aim: aim, dueDate: selectedDueDate.toString(format: "yyyy-MM-dd")))
                
                DispatchQueue.main.async {
                    self.isSending = false
                }
                
                completion(res)
            }
            
        }
    }
    
    func initVali() {
        let titleVali = $title.map({ !$0.isEmpty && !$0.moreGreater(size: 300) }).eraseToAnyPublisher()
        let purposeVali = $purpose.map({ !$0.moreGreater(size: 5000)}).eraseToAnyPublisher()
        let aimVali = $aim.map({ !$0.moreGreater(size: 5000) }).eraseToAnyPublisher()
        
        Publishers.CombineLatest3(titleVali, purposeVali, aimVali)
            .map({ [$0.0, $0.1, $0.2] })
            .map({ $0.allSatisfy{ $0 }})
            .assign(to: &$isSaveButton)
        
    }
    
}

enum FormType {
    case Not
    case Title
    case Purpose
    case Aim
}
