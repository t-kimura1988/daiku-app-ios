//
//  URLRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/22.
//

import Foundation

internal extension URLRequest {
    func encoded(parameters: [URLQueryItem]) -> URLRequest {
        var urlComponents = URLComponents(url: self.url!, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = parameters
        return URLRequest(url: (urlComponents?.url)!)
    }
    
    mutating func encoded(body: Encodable, encoder: JSONEncoder = JSONEncoder()) throws -> URLRequest{
        do {
            let encodable = AnyEncodable(body)
            httpBody = try encoder.encode(encodable)
            
            let contentTypeHeader = "Content-Type"
            if value(forHTTPHeaderField: contentTypeHeader) == nil {
                setValue("application/json", forHTTPHeaderField: contentTypeHeader)
            }
            
            return self
        } catch {
            return self
        }
        
    }
}
