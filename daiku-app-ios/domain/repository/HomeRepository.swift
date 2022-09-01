//
//  HomeRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/29.
//

import Foundation
import Combine

struct HomeRepository {
    
    func getGoalArchiveList(body: GoalArchiveRequest) async throws -> [HomeResponse] {
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<[HomeResponse], ApiError> = try await ApiProvider.provider(service: HomeService.getArchiveGoal(body))
            
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
                            continuation.resume(throwing: ApiError.responseError(errorCd))
                        case .invalidURL:
                            continuation.resume(throwing: ApiError.invalidURL)
                        case .parseError:
                            continuation.resume(throwing: ApiError.parseError)
                        case .unknown:
                            continuation.resume(throwing: ApiError.unknown)
                        case .httpError(let code):
                            continuation.resume(throwing: ApiError.httpError(code))
                            
                        }
                        canceller?.cancel()
                    }
                }, receiveValue: {homeRes in
                    continuation.resume(returning: homeRes)
                })
        }
    }
}
