//
//  ScheduleMainViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/26.
//

import Foundation
import Combine

class ScheduleMainViewModel: ObservableObject {
    @Published var date: Date = Date()
    @Published var isCalendarShow: Bool = false
    
    @Published var duringProcessList: [DuringProcess] = [DuringProcess]()
    @Published var duringProcess: DuringProcess = DuringProcess()
    
    private var processHistoryRepository: ProcessHistoryRepository = ProcessHistoryRepository()
    private var storeProductRepository: StoreProductRepository = StoreProductRepository()
    
    @Published var pageAnimation: Int = 0
    @Published var isGoalDetail: Bool = false
    
    @Published var isStoreSheet: Bool = false
    
    var cancellable: AnyCancellable?
    
    func changeCalendar() {
        isCalendarShow = !isCalendarShow
    }
    
    func isSelectedDate(listDate: Date) -> Bool {
        return self.date.toString(format: "yyyyMMdd") == listDate.toString(format: "yyyyMMdd")
    }
    
    func getProcessDate() {
        Task {
            let res = try await processHistoryRepository.duringProcessList(parameter: .init(processHitoryDate: date))
            DispatchQueue.main.async {
                self.duringProcessList = res
            }
        }
    }
    
    func getScheduleData() {
        cancellable = $date.sink { date in
            Task {
                let res = try await self.processHistoryRepository.duringProcessList(parameter: .init(processHitoryDate: date))
                
                let isPurchase = try await self.isPurchasedScheduleFeature()
                DispatchQueue.main.async {
                    self.duringProcessList = res
//                    self.isShceduleFeatureParchase = isPurchase
                }
                
                
            }
        }
    }
    
    private func isPurchasedScheduleFeature() async throws -> Bool{
        return try await self.storeProductRepository.isPurchased(productId: "ScheduleFeature")
    }
    
    func openGoalDetail(item: DuringProcess) {
        isGoalDetail = true
        duringProcess = item
    }
    
    func closeGoalDetail() {
        isGoalDetail = false
    }
    
    func openStoreSheet() {
        isStoreSheet = true
    }
    
    func closeStoreSheet() {
        isStoreSheet = true
    }
}
