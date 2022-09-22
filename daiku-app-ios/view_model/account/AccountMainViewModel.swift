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
    private var goalArchiveRepository: GoalArchiveRepository = GoalArchiveRepository()
    private var firebaseRepository: FirebaseRepository = FirebaseRepository()
    
    @Published var account: AccountResponse = AccountResponse()
    @Published var myGoal: [GoalResponse] = [GoalResponse]()
    @Published var myGoalArchiveList: [GoalArchiveInfoResponse] = [GoalArchiveInfoResponse]()
    @Published var goalFavoriteList: [GoalFavoriteResponse] = [GoalFavoriteResponse]()
    
    @Published var currentTab: String = TabButtonTitle.MyGoal.rawValue
    @Published var isBookmark: Bool = false
    @Published var isUpdateAccount: Bool = false
    
    @Published var goalListPage: Int = 10
    @Published var goalListLoadFlg: Bool = false
    @Published var isGoalListLoading: Bool = false
    
    @Published var goalArchiveListPage: Int = 10
    @Published var goalArvhiveListLoadFlg: Bool = false
    @Published var isGoalArchiveListLoading: Bool = false
    
    @Published var bookMarkListPage: Int = 10
    @Published var bookMarkListLoadFlg: Bool = false
    @Published var isBookMarkListLoading: Bool = false
    
    @Published var isImagePreView: Bool = false
    @Published var userImageURL: URL?
    @Published var profileBackURL: URL?
    @Published var imagePreViewScreenType: ImagePreType = .accountMain
    
    @Published var imagePath: String?
    
    func changeUpdateAccount() {
        DispatchQueue.main.async {
            self.isUpdateAccount = !self.isUpdateAccount
        }
    }
    
    func onApperLoadData() {
        Task {
            let accountRes = try await accountRepository.getAccount()
            DispatchQueue.main.sync {
                account = accountRes
            }
        }
        
    }
    
    func getInitMyGoal() {
        isGoalListLoading = true
        loadMyGoal()
    }
    
    func getMyGoal() {
        isGoalListLoading = true
        self.goalListPage += 10
        loadMyGoal()
        
    }
    
    private func loadMyGoal() {
        Task {
            let myGoalListRes = try await goalRepository.myGoalList(parameter: .init(year: "2022", page: String(goalListPage)))
            DispatchQueue.main.async {
                self.myGoal = myGoalListRes
                if myGoalListRes.count == self.goalListPage {
                    self.goalListLoadFlg = true
                } else {
                    self.goalListLoadFlg = false
                }
                
                self.isGoalListLoading = false
            }
        }
        
    }
    
    func getInitMyGoalArchive() {
        isGoalArchiveListLoading = true
        loadMyGoalArchive()
    }
    
    func getMyGoalArchive() {
        isGoalArchiveListLoading = true
        self.goalArchiveListPage += 10
        loadMyGoalArchive()
    }
    
    private func loadMyGoalArchive() {
        Task {
            let myArchiveGoalListRes = try await goalArchiveRepository.myGoalArchive(parameter: .init(year: "2022", pageCount: String(goalArchiveListPage)))
            DispatchQueue.main.async {
                self.myGoalArchiveList = myArchiveGoalListRes
                
                if myArchiveGoalListRes.count == self.goalArchiveListPage {
                    self.goalArvhiveListLoadFlg = true
                } else {
                    self.goalArvhiveListLoadFlg = false
                }
                
                self.isGoalArchiveListLoading = false
            }
        }
        
    }
    
    func getInitBookMarkList() {
        isBookMarkListLoading = true
        loadBookMark()
    }
    
    func getBookMarkList() {
        isBookMarkListLoading = true
        bookMarkListPage += 10
        loadBookMark()
    }
    
    private func loadBookMark() {
        Task {
            let list = try await goalFavoriteRepository.search(parameter: .init(year: "2022", page: String(bookMarkListPage)))
            
            DispatchQueue.main.async {
                self.goalFavoriteList = list
                
                if list.count == self.bookMarkListPage {
                    self.bookMarkListLoadFlg = true
                } else {
                    self.bookMarkListLoadFlg = false
                }
                
                self.isBookMarkListLoading = false
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
    
    func deleteAccount(completion: @escaping () -> Void) {
        Task {
            _ = try await accountRepository.deleteAccount()
            
            completion()
        }
    }
    
    func openAccountMainImagePreView() {
        isImagePreView = true
        imagePath = account.userImage
        imagePreViewScreenType = .accountMain
    }
    
    func openProfileBackImagePreView() {
        isImagePreView = true
        imagePath = account.profileBackImage
        imagePreViewScreenType = .profileBackImage
    }
    
    func closeImagePreView() {
        isImagePreView = false
    }
}

enum TabButtonTitle: String, CaseIterable, Identifiable {
    case MyGoal = "目標"
    case Archive = "達成"
    case BookMark = "印"
    var id: String { rawValue }
}
