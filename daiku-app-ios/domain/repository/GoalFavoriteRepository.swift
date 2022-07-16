//
//  GoalFavoriteRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/04.
//

import Foundation
import Combine

struct GoalFavoriteRepository {
    func changeGoalFavorite(request: GoalFavoriteCreateRequest) async throws -> NoBody{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<NoBody, ApiError> = try await ApiProvider.provider(service:GoalFavoriteService.changeGoalFavorite(request))
        
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
                        continuation.resume(returning: NoBody())
                        
                    }
                }, receiveValue: {res in
                    
                    continuation.resume(returning: res)
                })
        }
    }
    
    func search(parameter: GoalFavoriteSearchParameter) async throws -> [GoalFavoriteResponse]{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<[GoalFavoriteResponse], ApiError> = try await ApiProvider.provider(service:GoalFavoriteService.favoriteGoalSearch(parameter))
        
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
                    continuation.resume(returning: res)
                })
        }
    }
}
