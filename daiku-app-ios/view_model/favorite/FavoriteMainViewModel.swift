//
//  FavoriteMainViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/15.
//

import Foundation

class FavoriteMainViewModel: ObservableObject {
    @Published var goalFavoriteList: [GoalFavoriteResponse] = [GoalFavoriteResponse]()
    private var goalFavoriteRepository: GoalFavoriteRepository = GoalFavoriteRepository()
    func search() {
        Task {
            let list = try await goalFavoriteRepository.search(parameter: .init(year: "2022"))
            
            DispatchQueue.main.async {
                self.goalFavoriteList = list
            }
        }
    }
}
