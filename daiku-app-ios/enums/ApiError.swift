//
//  ApiError.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/27.
//

import Foundation


enum ApiError: Error {
    case invalidURL,
         responseError(String),
         httpError(Int),
         parseError,
         unknown
    
}

extension ApiError {
    
}

