//
//  GoalArchiveDetailViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/16.
//

import Foundation

class GoalArchiveDetailViewModel: ObservableObject {
    @Published var archive: HomeResponse = HomeResponse()
    @Published var goal: GoalResponse = GoalResponse()
    @Published var processList: [ProcessResponse] = [ProcessResponse]()
    @Published var isEditSheet: Bool = false
    @Published var isEditButton: Bool = false
    
    @Published var currentTab: String = ProcessTabTitle.Process.rawValue
    
    
    private var archiveId: Int = 0
    private var archiveCreateDate: String = ""
    private var goalCreateAccountId: Int = 0
    
    private var goalArchiveRepository: GoalArchiveRepository = GoalArchiveRepository()
    
    // get page display data
    func detail(accountId: Int = 0) {
        Task {
            if accountId == goalCreateAccountId {
                let res = try await goalArchiveRepository.myDetail(parameter:.init(archiveId: self.archiveId, archiveCreateDate: self.archiveCreateDate))
                
                DispatchQueue.main.async {
                    self.archive = res.goalArchiveInfo
                    self.goal = res.goalInfo
                    self.processList = res.getProcessList()
                    
                }
                
            } else {
                let res = try await goalArchiveRepository.detail(parameter:.init(archiveId: self.archiveId, archiveCreateDate: self.archiveCreateDate))
                
                DispatchQueue.main.async {
                    self.archive = res.goalArchiveInfo
                    self.goal = res.goalInfo
                    self.processList = res.getProcessList()
                    
                }
                
            }
            
            DispatchQueue.main.async {
                self.isEditButton(accountId: accountId, goalAccountId: self.goal.accountId)
            }
        }
    }
    
    func initItem(archiveId: Int, archiveCreateDate: String, goalCreateAccountId: Int) {
        self.archiveId = archiveId
        self.archiveCreateDate = archiveCreateDate
        self.goalCreateAccountId = goalCreateAccountId
        self.isEditButton = false
    }
    
    func tab() -> ProcessTabTitle {
        return ProcessTabTitle.init(rawValue: currentTab)!
    }
    
    func changeArchiveEditSheet() {
        isEditSheet = !isEditSheet
    }
    
    func isEditButton(accountId: Int, goalAccountId: Int) {
        if goalAccountId == accountId {
            isEditButton = true
        }
    }
    
    
}


enum ProcessTabTitle: String, CaseIterable, Identifiable {
    case Process = "工程"
    var id: String { rawValue }
}
