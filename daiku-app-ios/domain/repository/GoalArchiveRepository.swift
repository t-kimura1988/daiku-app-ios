//
//  GoalArchiveRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/17.
//

import Foundation
import Combine

struct GoalArchiveRepository {
    func detail(parameter: GoalArchiveDetailParameter) async throws -> GoalArchiveResponse {
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<GoalArchiveResponse, ApiError> = try await ApiProvider.provider(service: GoalArchiveService.detail(parameter))
        
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
                        continuation.resume(returning: GoalArchiveResponse())
                        
                    }
                }, receiveValue: {res in
                    continuation.resume(returning: res)
                })
        }
        
    }
    
    
    func create(request: GoalArchiveCreateRequest) async throws -> TGoalsArchiveResponse {
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<TGoalsArchiveResponse, ApiError> = try await ApiProvider.provider(service: GoalArchiveService.create(request))
        print(request)
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
                        continuation.resume(returning: TGoalsArchiveResponse())
                        
                    }
                }, receiveValue: {res in
                    continuation.resume(returning: res)
                })
        }
        
    }
    
    func update(request: GoalArchiveUpdateRequest) async throws -> TGoalsArchiveResponse {
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<TGoalsArchiveResponse, ApiError> = try await ApiProvider.provider(service: GoalArchiveService.update(request))
        
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
                        continuation.resume(returning: TGoalsArchiveResponse())
                        
                    }
                }, receiveValue: {res in
                    continuation.resume(returning: res)
                })
        }
        
    }
    
    
    
    func updatingFlgEdit(request: GoalArchiveUpdatingFlgEditRequest) async throws -> GoalResponse {
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<GoalResponse, ApiError> = try await ApiProvider.provider(service: GoalArchiveService.updatingFlg(request))
        print(request)
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
                        continuation.resume(returning: GoalResponse())
                        
                    }
                }, receiveValue: {res in
                    continuation.resume(returning: res)
                })
        }
        
    }
}
