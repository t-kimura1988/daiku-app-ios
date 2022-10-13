//
//  IdeaRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/02.
//

import Foundation
import Combine

struct IdeaRepository {
    
    func saveIdea(request: IdeaCreateRequest) async throws -> IdeaSearchResponse{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<IdeaSearchResponse, ApiError> = try await ApiProvider.provider(service: IdeaService.createIdea(request))
        
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
                }, receiveValue: {accountRes in
                    
                    continuation.resume(returning: accountRes)
                })
        }
    }
    
    func myIdeaList(param: MyIdeaListParameter) async throws -> [IdeaSearchResponse]{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<[IdeaSearchResponse], ApiError> = try await ApiProvider.provider(service: IdeaService.myIdeaList(param))
        
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
                }, receiveValue: {accountRes in
                    
                    continuation.resume(returning: accountRes)
                })
        }
    }
    
    func ideaDetail(param: IdeaDetailParameter) async throws -> IdeaSearchResponse{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<IdeaSearchResponse, ApiError> = try await ApiProvider.provider(service: IdeaService.ideaDetail(param))
        
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
                }, receiveValue: {accountRes in
                    
                    continuation.resume(returning: accountRes)
                })
        }
    }
    
    func updateIdea(request: IdeaUpdateRequest) async throws -> IdeaSearchResponse{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<IdeaSearchResponse, ApiError> = try await ApiProvider.provider(service: IdeaService.updateIdea(request))
        
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
                }, receiveValue: {accountRes in
                    
                    continuation.resume(returning: accountRes)
                })
        }
    }
}
