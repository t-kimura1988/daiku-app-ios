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
                        continuation.resume(returning: ProcessHistoryResponse())
                        
                    }
                }, receiveValue: {res in
                    continuation.resume(returning: res)
                })
        }
        
    }
}
