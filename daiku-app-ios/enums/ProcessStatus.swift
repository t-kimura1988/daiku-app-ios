//
//  ProcessStatus.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/06.
//

import Foundation
import SwiftUI


enum ProcessStatus: String, RawRepresentable, CaseIterable, PickerBase {
    
    case New
    case Doing
    case Problem
    case Complete
    
    var id: String { rawValue }
    
    init(rawValue: String) {
        switch rawValue {
        case "0":
            self = .New
        case "1":
            self = .Doing
        case "2":
            self = .Problem
        case "3":
            self = .Complete
        default:
            self = .New
        }
    }
    
    func backColor() -> Color {
        switch self {
        case .New:
            return .yellow
        case .Doing:
            return .blue
        case .Problem:
            return .red
        case .Complete:
            return .gray
        }
    }
}

extension ProcessStatus {
    var title: String {
        switch self {
        case .New:
            return "新規作成"
        case .Doing:
            return "対応中"
        case .Problem:
            return "問題"
        case .Complete:
            return "完了"
        }
    }
    
    var code: String {
        switch self {
        case .New:
            return "0"
        case .Doing:
            return "1"
        case .Problem:
            return "2"
        case .Complete:
            return "3"
        }
        
    }
}
