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
    @Published var isGoalEditSheet: Bool = false
    @Published var isArchiveSheet: Bool = false
    
    private var goalRepository: GoalRepository = GoalRepository()
    private var processRepository: ProcessRepository = ProcessRepository()
    private var goalArchiveRepository: GoalArchiveRepository = GoalArchiveRepository()
    
    
    func initItem() {
        processList = [ProcessResponse]()
    }
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
    func editUpdatingFlg(completing: @escaping (GoalResponse) -> Void) {
        Task {
            let goalArchive = try await goalArchiveRepository.updatingFlgEdit(request: .init(goalId: goalDetail.id, goalCreateDate: goalDetail.createDate))
            
            completing(goalArchive)
        }
    }
    
    func changeArchiveSheetFlg() {
        self.isArchiveSheet = !self.isArchiveSheet
    }
    func changeSheetFlg() {
        self.isSheet = !self.isSheet
    }
    func changeGoalEditFlg() {
        self.isGoalEditSheet = !self.isGoalEditSheet
    }
}
