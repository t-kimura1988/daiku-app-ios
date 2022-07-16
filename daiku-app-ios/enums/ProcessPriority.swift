//
//  ProcessPriority.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/06.
//

import Foundation
import SwiftUI

enum ProcessPriority: String, RawRepresentable, CaseIterable, PickerBase {
    case Low
    case Normal
    case Height
    case Top
    
    init(rawValue: String) {
        switch rawValue {
        case "0":
            self = .Low
        case "1":
            self = .Normal
        case "2":
            self = .Height
        case "3":
            self = .Top
        default:
            self = .Low
        }
    }
    
    func backColor() -> Color {
        switch self {
        case .Low:
            return .blue
        case .Normal:
            return .green
        case .Height:
            return .yellow
        case .Top:
            return .red
        }
    }
}

extension ProcessPriority {
    var title: String {
        switch self {
        case .Low:
            return "低"
        case .Normal:
            return "中"
        case .Height:
            return "高"
        case .Top:
            return "最優先"
        }
    }
    
    var code: String {
        switch self {
        case .Low:
            return "0"
        case .Normal:
            return "1"
        case .Height:
            return "2"
        case .Top:
            return "3"
        }
    }
}
