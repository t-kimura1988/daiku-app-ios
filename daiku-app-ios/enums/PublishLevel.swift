//
//  PublishLevel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/17.
//

import Foundation
import SwiftUI

enum PublishLevel: String, RawRepresentable, CaseIterable, PickerBase {
    case Own
    case OnlyGoal
    case All
    
    init(rowValue: String) {
        switch rowValue {
        case "0":
            self = .Own
        case  "1":
            self = .OnlyGoal
        case "2":
            self = .All
        default:
            self = .Own
        }
    }
}

extension PublishLevel {
    
    var title: String {
        switch self {
        case .Own:
            return "自分のみ"
        case .OnlyGoal:
            return "目標のみ"
        case .All:
            return "全体公開"
        }
    }
    var code: String {
        switch self {
        case .Own:
            return "0"
        case .OnlyGoal:
            return "1"
        case .All:
            return "2"
        }
    }
}
