//
//  GoalDetailViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/05.
//

import Foundation

class GoalDetailViewModel: ObservableObject {
    @Published var goalDetail: GoalResponse = GoalResponse()
    
    private var goalRepository: GoalRepository = GoalRepository()
    func getGoalDetail(goalId: Int, createDate: String) {
        Task {
            let goal = try await goalRepository.myGoalDetail(parameter: .init(goalId: goalId, createDate: createDate))
            DispatchQueue.main.async {
                self.goalDetail = goal
            }
        }
    }
}
