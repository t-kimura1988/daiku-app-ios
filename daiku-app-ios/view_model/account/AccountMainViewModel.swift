//
//  AccountMainViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/02.
//

import Foundation

class AccountMainViewModel: ObservableObject {
    private var accountRepository: AccountRepository = AccountRepository()
    private var goalRepository: GoalRepository = GoalRepository()
    private var goalFavoriteRepository: GoalFavoriteRepository = GoalFavoriteRepository()
    
    @Published var account: AccountResponse = AccountResponse()
    @Published var myGoal: [GoalResponse] = [GoalResponse]()
    
    @Published var currentTab: String = TabButtonTitle.MyGoal.rawValue
    @Published var isBookmark: Bool = false
    
    init() {
    }
    
    func onApperLoadData() {
        Task {
            let accountRes = try await accountRepository.getAccount()
            DispatchQueue.main.sync {
                account = accountRes!
            }
        }
        
        Task {
            let myGoalListRes = try await goalRepository.myGoalList(parameter: .init(year: "2022"))
            DispatchQueue.main.async {
                self.myGoal = myGoalListRes
            }
        }
        
    }
    
    func changeTab(item: String) {
        DispatchQueue.main.sync {
            currentTab = item
        }
    }
    
    func changeGoalFavorite(request: GoalFavoriteCreateRequest, completion: @escaping () -> Void) {
        Task {
            _ = try await goalFavoriteRepository.changeGoalFavorite(request: request)
            
            completion()
        }
    }
}

enum TabButtonTitle: String, CaseIterable, Identifiable {
    case MyGoal = "目標"
    var id: String { rawValue }
}
