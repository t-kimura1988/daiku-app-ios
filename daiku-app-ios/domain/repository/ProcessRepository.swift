//
//  ProcessRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/05.
//

import Foundation
import Combine

struct ProcessRepository {
    
    
    func processList(parameter: ProcessListParameter) async throws -> [ProcessResponse] {
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<[ProcessResponse], ApiError> = try await ApiProvider.provider(service: ProcessService.processList(parameter))
        
        return try await withCheckedThrowingContinuation{ continuation in
            if Task.isCancelled {
                continuation.resume(throwing: Error.self as! Error)
            }
            
            canceller = publisher
                .sink(receiveCompletion: {completion in
                    switch completion {
                        
                    case .finished:
                        canceller?.cancel()
                        break
                    case .failure(let error):
                        let err: ApiError = error
                        
                        switch(err) {
                        case .responseError(let errorCd):
                            print("response error \(errorCd)")
                        case .invalidURL:
                            print("url error")
                        case .parseError:
                            print("parse error")
                        case .unknown:
                            print("unknown")
                        }
                        canceller?.cancel()
                        continuation.resume(returning: [])
                        
                    }
                }, receiveValue: {res in
                    print(res)
                    continuation.resume(returning: res)
                })
        }
        
        
    }
}
