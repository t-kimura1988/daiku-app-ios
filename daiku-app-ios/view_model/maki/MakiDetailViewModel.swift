//
//  MakiDetailViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/15.
//

import Foundation

class MakiDetailViewModel: ObservableObject {
    private var makiRepository: MakiRepository = MakiRepository()
    private var goalRepository: GoalRepository = GoalRepository()
    private var makiId: Int = 0
    
    @Published var makiDetail: MakiSearchResponse = MakiSearchResponse()
    @Published var currentTab: String = MakiDetailTabButtonTitle.Goal.rawValue
    @Published var makiGoalList: [GoalResponse] = [GoalResponse]()
    
    @Published var isGoalAddSheet: Bool = false
    
    @Published var makiGoalListPage: Int = 10
    @Published var makiGoalListLoadFlg: Bool = false
    @Published var isMakiGoalListLoading: Bool = false
    @Published var isMakiGoalCreateSheet: Bool = false
    
    func initItem(makiId: Int) {
        self.makiId = makiId
        makiGoalList = [GoalResponse]()
    }
    
    func detail() {
        Task {
            let res = try await makiRepository.detailMyMaki(parameter: .init(makiId: String(self.makiId)))
            DispatchQueue.main.async {
                self.makiDetail = res
            }
        }
    }
    
    func getInitMakiGoalList() {
        isMakiGoalListLoading = true
        loadMakiList()
    }
    
    func getMakiGoalList() {
        isMakiGoalListLoading = true
        self.makiGoalListPage += 10
        loadMakiList()
    }
    
    func loadMakiList() {
        Task {
            let res = try await makiRepository.makiGoal(parameter: .init(makiId: String(makiId), page: String(makiGoalListPage)))
            
            DispatchQueue.main.async {
                self.makiGoalList = res
                
                if res.count == self.makiGoalListPage {
                    self.makiGoalListLoadFlg = true
                } else {
                    self.makiGoalListLoadFlg = false
                }
                
                self.isMakiGoalListLoading = false
            }
            
        }
    }
    
    func openAddGoalSheet() {
        DispatchQueue.main.async {
            self.isGoalAddSheet = true
        }
    }
    
    func closeAddGoalSheet() {
        DispatchQueue.main.async {
            self.isGoalAddSheet = false
        }
    }
    
    func closeAddGoalSheetNextStep(next: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.isGoalAddSheet = false
            next()
        }
    }
    
    func openGoalCreateSheet() {
        DispatchQueue.main.async {
            self.isMakiGoalCreateSheet = true
        }
    }
    
    func closeGoalCreateSheet() {
        DispatchQueue.main.async {
            self.isMakiGoalCreateSheet = false
        }
    }
}

enum MakiDetailTabButtonTitle: String, CaseIterable, Identifiable {
    case Goal = "目標"
//    case Member = "メンバー"
    var id: String { rawValue }
}
