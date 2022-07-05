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
    @Published var homeList: [HomeResponse] = [HomeResponse()]
    @Published var isSheet: Bool = false
    
    init() {
        Task {
            let list = try await homeReposiroty.getGoalArchiveList(body: .init(year: "2022", pageCount: "10"))
            DispatchQueue.main.sync {
                homeList = list
            }
            
            
        }
    }
    
    func createGoalSheet() {
        Task {
            self.isSheet = !self.isSheet
        }
    }
}
