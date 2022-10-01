//
//  HomeMainViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/18.
//

import Combine
import Foundation

class HomeMainViewModel: ObservableObject {
    private var homeReposiroty: HomeRepository = HomeRepository()
    private var firebaseRepository: FirebaseRepository = FirebaseRepository()
    private var firestoreHome: FirestoreHomeRepository = FirestoreHomeRepository()
    @Published var homeList: [HomeResponse] = [HomeResponse()]
    @Published var isSheet: Bool = false
    @Published var isProjectSheet: Bool = false
    
    
    @Published var homeListPage: Int = 10
    @Published var homeListLoadFlg: Bool = false
    @Published var isHomeListLoading: Bool = false
    
    @Published var isGoalCreateMenuSheet: Bool = false
    
    @Published var selectedGoalArchiveMonth: DatePickerMonth = .ALL
    @Published var selectedGoalArchiveYear: Int = 2022
    @Published var isGoalArchiveSearchInputSheet: Bool = false
    
    @Published var homeData: HomeData?
    
    func getInitHomeList() {
        self.isHomeListLoading = true
        loadHome()
    }
    
    func getHomeList() {
        self.isHomeListLoading = true
        self.homeListPage += 10
        loadHome()
    }
    
    func getHomeData() {
        Task {
            do {
                let res = try await firestoreHome.getHomeData()
                DispatchQueue.main.async {
                    self.homeData = res
                }
            } catch ApiError.responseError(let err) {
                print(err)
            }
        }
    }
    
    private func loadHome() {
        Task {
            let list = try await homeReposiroty.getGoalArchiveList(body: .init(year: String(selectedGoalArchiveYear), month: selectedGoalArchiveMonth.code, pageCount: String(homeListPage)))
            DispatchQueue.main.sync {
                homeList = list
                if list.count == self.homeListPage {
                    self.homeListLoadFlg = true
                } else {
                    self.homeListLoadFlg = false
                }
                
                self.isHomeListLoading = false
            }
        }
        
    }
    
    func openGoalSheet() {
        DispatchQueue.main.async {
            self.isSheet = true
        }
    }
    
    func closeGoalSheet() {
        DispatchQueue.main.async {
            self.isSheet = false
        }
    }
    
    func openProjectSheet() {
        DispatchQueue.main.async {
            self.isProjectSheet = true
        }
    }
    
    func closeProjectSheet() {
        DispatchQueue.main.async {
            self.isProjectSheet = false
        }
    }
    
    func openGoalCreateMenuSheet() {
        DispatchQueue.main.async {
            self.isGoalCreateMenuSheet = true
        }
    }
    
    func closeGoalCreateMenuSheet(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.isGoalCreateMenuSheet = false
            completion()
        }
    }
    
    func changeGoalArchiveSearchInputSheet() {
        isGoalArchiveSearchInputSheet = !isGoalArchiveSearchInputSheet
    }
}
