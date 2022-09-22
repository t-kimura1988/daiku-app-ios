//
//  MakiRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/14.
//

import Foundation
import Combine

struct MakiRepository {
    
    
    func createMaki(body: MakiCreateRequest) async throws -> TMakiResponse?{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<TMakiResponse, ApiError> = try await ApiProvider.provider(service: MakiService.create(body))
        return try await withCheckedThrowingContinuation{ continuation in
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
    
    
    func searchMyMaki(parameter: MyMakiListParameter) async throws -> [MakiSearchResponse]{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<[MakiSearchResponse], ApiError> = try await ApiProvider.provider(service: MakiService.search(parameter))
        return try await withCheckedThrowingContinuation{ continuation in
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
    
    func detailMyMaki(parameter: MyMakiDetailParameter) async throws -> MakiSearchResponse{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<MakiSearchResponse, ApiError> = try await ApiProvider.provider(service: MakiService.myDetail(parameter))
        return try await withCheckedThrowingContinuation{ continuation in
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
    
    func makiGoal(parameter: MakiGoalListParameter) async throws -> [GoalResponse]{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<[GoalResponse], ApiError> = try await ApiProvider.provider(service: MakiService.makiGoalList(parameter))
        return try await withCheckedThrowingContinuation{ continuation in
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
    
    func makiAddGoalList(parameter: MakiAddGoalListParameter) async throws -> [MakiAddGoalItem]{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<[MakiAddGoalItem], ApiError> = try await ApiProvider.provider(service: MakiService.makiAddGoalList(parameter))
        return try await withCheckedThrowingContinuation{ continuation in
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
    
    func makiAddGoal(parameter: Array<MakiAddGoalRequest>) async throws -> [MakiAddGoalResponse]{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<[MakiAddGoalResponse], ApiError> = try await ApiProvider.provider(service: MakiService.makiAddGoal(parameter))
        return try await withCheckedThrowingContinuation{ continuation in
            canceller = publisher
                .sink(receiveCompletion: {completion in
                    switch completion {
                        
                    case .finished:
                        canceller?.cancel()
                        break
                    case .failure(let error):
                        let err: ApiError = error
                        print(err)
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
