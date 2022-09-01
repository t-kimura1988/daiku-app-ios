//
//  DateExtention.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/27.
//

import Foundation

extension Date {
    
    func toString(format: String) -> String{
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
