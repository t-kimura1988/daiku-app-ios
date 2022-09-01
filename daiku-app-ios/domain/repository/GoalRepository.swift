//
//  GoalRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/02.
//

import Foundation
import Combine

struct GoalRepository {
    func saveGoal(request: GoalCreateRequest) async throws -> GoalResponse{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<GoalResponse, ApiError> = try await ApiProvider.provider(service: GoalService.createGoal(request))
        
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
                        continuation.resume(returning: GoalResponse())
                        
                    }
                }, receiveValue: {accountRes in
                    
                    continuation.resume(returning: accountRes)
                })
        }
    }
    
    func updateGoal(request: GoalUpdateRequest) async throws -> GoalResponse{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<GoalResponse, ApiError> = try await ApiProvider.provider(service: GoalService.updateGoal(request))
        
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
                        continuation.resume(returning: GoalResponse())
                    }
                }, receiveValue: {goalRes in
                    
                    continuation.resume(returning: goalRes)
                })
        }
    }
    
    func myGoalList(parameter: MyGoalListParameter) async throws -> [GoalResponse] {
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<[GoalResponse], ApiError> = try await ApiProvider.provider(service: GoalService.myGoalList(parameter))
        
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
                }, receiveValue: {res in
                    continuation.resume(returning: res)
                })
        }
        
        
    }
    
    func myGoalDetail(parameter: GoalDetailParameter) async throws -> GoalResponse {
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<GoalResponse, ApiError> = try await ApiProvider.provider(service: GoalService.goalDetail(parameter))
        
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
                }, receiveValue: {res in
                    continuation.resume(returning: res)
                })
        }
        
    }
    
}
