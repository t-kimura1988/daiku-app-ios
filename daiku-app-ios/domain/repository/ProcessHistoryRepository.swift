//
//  ProcessHistoryRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/07.
//

import Foundation
import Combine

struct ProcessHistoryRepository {
    func processHistoryList(parameter: ProcessHistoryListParameter) async throws -> [ProcessHistoryResponse] {
            var canceller: AnyCancellable?
            let publisher: AnyPublisher<[ProcessHistoryResponse], ApiError> = try await ApiProvider.provider(service: ProcessHistoryService.processHistoryList(parameter))
            
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
    
    func processHistoryDetail(parameter: ProcessHistoryDetailParameter) async throws -> ProcessHistoryResponse {
            var canceller: AnyCancellable?
            let publisher: AnyPublisher<ProcessHistoryResponse, ApiError> = try await ApiProvider.provider(service: ProcessHistoryService.detail(parameter))
            
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
                            continuation.resume(returning: ProcessHistoryResponse())
                            
                        }
                    }, receiveValue: {res in
                        continuation.resume(returning: res)
                    })
            }
    }
    
    func commentSave(request: ProcessHisotryCommentRequest) async throws -> ProcessHistoryResponse {
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<ProcessHistoryResponse, ApiError> = try await ApiProvider.provider(service: ProcessHistoryService.processHisotryComment(request))
        
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
                        continuation.resume(returning: ProcessHistoryResponse())
                        
                    }
                }, receiveValue: {res in
                    continuation.resume(returning: res)
                })
        }
        
    }
    
    func commentUpdate(request: CommentUpdateRequest) async throws -> ProcessHistoryResponse {
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<ProcessHistoryResponse, ApiError> = try await ApiProvider.provider(service: ProcessHistoryService.updateComment(request))
        
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
                        continuation.resume(returning: ProcessHistoryResponse())
                        
                    }
                }, receiveValue: {res in
                    continuation.resume(returning: res)
                })
        }
        
    }
    
    func statusUpdate(request: StatusUpdateRequest) async throws -> ProcessHistoryResponse {
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<ProcessHistoryResponse, ApiError> = try await ApiProvider.provider(service: ProcessHistoryService.updateStatus(request))
        
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
                        continuation.resume(returning: ProcessHistoryResponse())
                        
                    }
                }, receiveValue: {res in
                    print(res)
                    continuation.resume(returning: res)
                })
        }
        
    }
}
