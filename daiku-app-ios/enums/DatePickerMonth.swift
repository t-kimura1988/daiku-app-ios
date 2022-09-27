//
//  DatePickerMonth.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/26.
//

import Foundation
import SwiftUI

enum DatePickerMonth: String, RawRepresentable, CaseIterable, PickerBase {
    
    case ALL
    case JAN
    case FEB
    case MAR
    case APR
    case MAY
    case JUN
    case JUL
    case AUG
    case SEP
    case OCT
    case NOV
    case DEC
    
    var id: String { rawValue }
    
    init(rawValue: String) {
        switch rawValue {
        case "0":
            self = .ALL
        case "1":
            self = .JAN
        case "2":
            self = .FEB
        case "3":
            self = .MAR
        case "4":
            self = .APR
        case "5":
            self = .MAY
        case "6":
            self = .JUN
        case "7":
            self = .JUL
        case "8":
            self = .AUG
        case "9":
            self = .SEP
        case "10":
            self = .OCT
        case "11":
            self = .NOV
        case "12":
            self = .DEC
        default:
            self = .ALL
            
        }
    }
}

extension DatePickerMonth {
    var title: String {
        switch self {
        case .ALL:
            return "全て"
        case .JAN:
            return "1月"
        case .FEB:
            return "2月"
        case .MAR:
            return "3月"
        case .APR:
            return "4月"
        case .MAY:
            return "5月"
        case .JUN:
            return "6月"
        case .JUL:
            return "7月"
        case .AUG:
            return "8月"
        case .SEP:
            return "9月"
        case .OCT:
            return "10月"
        case .NOV:
            return "11月"
        case .DEC:
            return "12月"
        }
    }
    
    var code: String {
        switch self {
        case .ALL:
            return "0"
        case .JAN:
            return "1"
        case .FEB:
            return "2"
        case .MAR:
            return "3"
        case .APR:
            return "4"
        case .MAY:
            return "5"
        case .JUN:
            return "6"
        case .JUL:
            return "7"
        case .AUG:
            return "8"
        case .SEP:
            return "9"
        case .OCT:
            return "10"
        case .NOV:
            return "11"
        case .DEC:
            return "12"
        }
        
    }
}
