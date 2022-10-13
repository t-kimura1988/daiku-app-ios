//
//  HomeData.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/30.
//

import Foundation
import FirebaseFirestoreSwift

struct HomeData: Codable {
    var goal_count: Int
    var account_count: Int
    var goal_archive_count: Int
    
    func getGoalCount () -> String {
        return "\(String(goal_count))件"
    }
    
    func getGoalArchiveCount () -> String {
        return "\(String(goal_archive_count))件"
    }
    
    func getAccountCount () -> String {
        return "\(String(account_count))人"
    }
}
