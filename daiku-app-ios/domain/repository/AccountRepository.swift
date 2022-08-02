//
//  AccountRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/21.
//

import Foundation
import Combine

struct AccountRepository {
    
    func getAccount() async throws -> AccountResponse {
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<AccountResponse, ApiError> = try await ApiProvider.provider(service: AccountService.existAccount)
        
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
                            print("unknown")
                        }
                        canceller?.cancel()
                        
                    }
                }, receiveValue: {accountRes in
                    continuation.resume(returning: accountRes)
                })
        }
    }
    
    func createAccount(body: AccountCreateRequest) async throws -> AccountResponse?{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<AccountResponse, ApiError> = try await ApiProvider.provider(service: AccountService.createAccount(body))
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
                            print("response error \(errorCd)")
                        case .invalidURL:
                            print("url error")
                        case .parseError:
                            print("parse error")
                        case .unknown:
                            print("unknown")
                        }
                        continuation.resume(returning: AccountResponse.init())
                        canceller?.cancel()
                        
                    }
                }, receiveValue: {accountRes in
                    
                    continuation.resume(returning: accountRes)
                })
        }
        
    }
    
    func updateAccount(body: AccountCreateRequest) async throws -> AccountResponse?{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<AccountResponse, ApiError> = try await ApiProvider.provider(service: AccountService.updateAccount(body))
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
                            print("response error \(errorCd)")
                        case .invalidURL:
                            print("url error")
                        case .parseError:
                            print("parse error")
                        case .unknown:
                            print("unknown")
                        }
                        continuation.resume(returning: AccountResponse.init())
                        canceller?.cancel()
                        
                    }
                }, receiveValue: {accountRes in
                    
                    continuation.resume(returning: accountRes)
                })
        }
        
    }
    
    func deleteAccount() async throws -> AccountResponse?{
        
        var canceller: AnyCancellable?
        let publisher: AnyPublisher<AccountResponse, ApiError> = try await ApiProvider.provider(service: AccountService.deleteAccount)
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
                            print("response error \(errorCd)")
                        case .invalidURL:
                            print("url error")
                        case .parseError:
                            print("parse error")
                        case .unknown:
                            print("unknown")
                        }
                        continuation.resume(returning: AccountResponse.init())
                        canceller?.cancel()
                        
                    }
                }, receiveValue: {accountRes in
                    
                    continuation.resume(returning: accountRes)
                })
        }
        
    }
}
