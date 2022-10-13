//
//  StoryRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/05.
//

import Foundation
import Combine

struct StoryRepository {
    func saveStroy(request: StoryCreateRequest) async throws -> StoryResponse{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<StoryResponse, ApiError> = try await ApiProvider.provider(service: StoryService.createStory(request))
        
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
    
    func updateStoryBody(request: StoryBodyUpdateRequest) async throws -> IdeaSearchResponse{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<IdeaSearchResponse, ApiError> = try await ApiProvider.provider(service: StoryService.updateBody(request))
        
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
