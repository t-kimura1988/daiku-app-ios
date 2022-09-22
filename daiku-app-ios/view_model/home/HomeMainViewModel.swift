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
    @Published var homeList: [HomeResponse] = [HomeResponse()]
    @Published var isSheet: Bool = false
    @Published var isProjectSheet: Bool = false
    
    
    @Published var homeListPage: Int = 10
    @Published var homeListLoadFlg: Bool = false
    @Published var isHomeListLoading: Bool = false
    
    @Published var isGoalCreateMenuSheet: Bool = false
    
    func getInitHomeList() {
        self.isHomeListLoading = true
        loadHome()
    }
    
    func getHomeList() {
        self.isHomeListLoading = true
        self.homeListPage += 10
        loadHome()
    }
    
    private func loadHome() {
        Task {
            let list = try await homeReposiroty.getGoalArchiveList(body: .init(year: "2022", pageCount: String(homeListPage)))
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
}
