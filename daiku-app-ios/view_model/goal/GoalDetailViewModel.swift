//
//  GoalDetailViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/05.
//

import Foundation

class GoalDetailViewModel: ObservableObject {
    @Published var goalDetail: GoalResponse = GoalResponse()
    @Published var processList: [ProcessResponse] = [ProcessResponse]()
    @Published var isSheet: Bool = false
    
    private var goalRepository: GoalRepository = GoalRepository()
    private var processRepository: ProcessRepository = ProcessRepository()
    
    func getGoalDetail(goalId: Int, createDate: String) {
        Task {
            let goal = try await goalRepository.myGoalDetail(parameter: .init(goalId: goalId, createDate: createDate))
            DispatchQueue.main.async {
                self.goalDetail = goal
            }
        }
        Task {
            let processListRes = try await processRepository.processList(parameter: .init(goalId: goalId, createDate: createDate))
            
            DispatchQueue.main.async {
                self.processList = processListRes
            }
        }
    }
    
    func changeSheetFlg() {
        self.isSheet = !self.isSheet
    }
}
