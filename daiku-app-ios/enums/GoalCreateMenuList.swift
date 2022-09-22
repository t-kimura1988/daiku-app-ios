//
//  GoalCreateMenuList.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/17.
//

import Foundation
import SwiftUI

enum GoalCreateMenuList: String, RawRepresentable, CaseIterable, PickerBase {
    case ProjectCreate
    case GoalCreate
    
    init(rowValue: String) {
        switch rowValue {
        case "0":
            self = .ProjectCreate
        case  "1":
            self = .GoalCreate
        default:
            self = .ProjectCreate
        }
    }
}

extension GoalCreateMenuList {
    
    var title: String {
        switch self {
        case .ProjectCreate:
            return "巻の作成"
        case .GoalCreate:
            return "目標の作成"
        }
    }
    var code: String {
        switch self {
        case .ProjectCreate:
            return "0"
        case .GoalCreate:
            return "1"
        }
    }
}
