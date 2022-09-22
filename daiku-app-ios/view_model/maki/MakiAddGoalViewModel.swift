//
//  MakiAddGoalViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/17.
//

import Foundation

class MakiAddGoalViewModel: ObservableObject {
    @Published var goalList: [MakiAddGoalItem] = [MakiAddGoalItem]()
    @Published var selectionItem: Set<MakiAddGoalRequest> = Set()
    @Published var isCheck: [Bool] = [false]
    @Published var isSaveButton: Bool = false
    
    private var makiId: Int = 0
    
    private var makiRepository: MakiRepository = MakiRepository()
    
    func initItem(makiId: Int) {
        self.makiId = makiId
    }
    
    func getGoalList() {
        Task {
            do {
                let res = try await makiRepository.makiAddGoalList(parameter: .init(makiId: String(makiId)))
                DispatchQueue.main.async {
                    self.goalList = res
                    self.isCheck = [Bool](repeating: false, count: res.count)
                }
            } catch ApiError.responseError(let err) {
                print(err)
            } catch ApiError.parseError {
                print("Maki Add Goal List Parse Error")
            }
        }
    }
    
    func addGoal(completion: @escaping () -> Void) {
        Task {
            let res = try await makiRepository.makiAddGoal(parameter: Array(selectionItem))
            completion()
        }
    }
    
    func setGoalItem(index: Int) {
        let item = goalList[index]
        isCheck[index] = !isCheck[index]
        if isCheck[index] {
            selectionItem.insert(.init(makiId: String(makiId), goalId: String(item.id), goalCreateDate: item.createDate))
        } else {
            selectionItem.remove(.init(makiId: String(makiId), goalId: String(item.id), goalCreateDate: item.createDate))
        }
        if selectionItem.isEmpty {
            isSaveButton = false
        } else {
            isSaveButton = true
        }
    }
}
