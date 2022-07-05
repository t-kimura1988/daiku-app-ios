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
    @Published var dueDate: String = ""
    
    @Published var isFormSheet: Bool = false
    @Published var formType: FormType = .Not
    private var goalRepository: GoalRepository = GoalRepository()
    
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
    
    func saveGoal(completion: @escaping () -> Void) {
        Task {
            _ = try await goalRepository.saveGoal(request: .init(title: title, purpose: purpose, aim: aim, dueDate: "2022-07-20"))
            
            
            completion()
        }
    }
}

enum FormType {
    case Not
    case Title
    case Purpose
    case Aim
}
