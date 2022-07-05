//
//  ApiProtcol.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/21.
//

import Foundation

protocol ApiService {
    var requestType: RequestType { get }
    var baseURL: String {get}
    var httpMethod: HttpMethod {get}
    var isAuth: Bool {get}
    var path: String { get }
    var responseType: Decodable? {get}
}
