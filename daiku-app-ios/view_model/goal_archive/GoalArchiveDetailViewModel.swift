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
    
    @Published var currentTab: String = ProcessTabTitle.Process.rawValue
    
    
    private var archiveId: Int = 0
    private var archiveCreateDate: String = ""
    
    private var goalArchiveRepository: GoalArchiveRepository = GoalArchiveRepository()
    
    // get page display data
    func detail() {
        Task {
            let res = try await goalArchiveRepository.detail(parameter:.init(archiveId: self.archiveId, archiveCreateDate: self.archiveCreateDate))
            
            DispatchQueue.main.async {
                self.archive = res.goalArchiveInfo
                self.goal = res.goalInfo
                self.processList = res.processInfo
                
            }
        }
    }
    
    func initItem(archiveId: Int, archiveCreateDate: String) {
        self.archiveId = archiveId
        self.archiveCreateDate = archiveCreateDate
    }
    
    func tab() -> ProcessTabTitle {
        return ProcessTabTitle.init(rawValue: currentTab)!
    }
    
    func changeArchiveEditSheet() {
        isEditSheet = !isEditSheet
    }
}


enum ProcessTabTitle: String, CaseIterable, Identifiable {
    case Process = "工程"
    var id: String { rawValue }
}
