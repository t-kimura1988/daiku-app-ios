//
//  ProcessTermUpdateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/27.
//

import Foundation
import Combine

class ProcessTermUpdateViewModel: ObservableObject {
    @Published var start: Date = Date()
    @Published var end: Date = Date()
    @Published var processId: Int = 0
    @Published var goalId: Int = 0
    @Published var goalCreateDate: String = ""
    @Published var isSaveButton: Bool = false
    
    private var processRepository: ProcessRepository = ProcessRepository()
    
    func initItem(start: Date = Date(), end: Date = Date(), processId: Int = 0, goalCreateDate: String = "", goalId: Int = 0) {
        self.start = start
        self.end = end
        self.processId = processId
        self.goalId = goalId
        self.goalCreateDate = goalCreateDate
        initVali()
    }
    
    func update(completion: @escaping (ProcessResponse) -> Void) {
        isSaveButton = false
        Task {
            let processRes = try await processRepository.updateTerm(request: .init(processId: processId, goalId: goalId, goalCreateDate: goalCreateDate, processStartDate: start.toString(format: "yyyy-MM-dd"), processEndDate: end.toString(format: "yyyy-MM-dd")))
            
            completion(processRes)
        }
    }
    
    func initVali() {
        $start.combineLatest($end).map({ $0.compare($1) == .orderedAscending || $0 == $1}).eraseToAnyPublisher()
            .map({[$0]})
            .map({ $0.allSatisfy{ $0 }})
            .assign(to: &$isSaveButton)
        
    }
    
}
