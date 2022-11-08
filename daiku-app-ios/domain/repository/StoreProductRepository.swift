//
//  StoreProductRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/11/01.
//

import Foundation
import StoreKit

struct StoreProductRepository {
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    func isPurchased(productId: String) async throws -> Bool {
        guard let result = await Transaction.latest(for: productId) else {
            return false
        }
        
        let tran = try checkVerified(result)
        
        return tran.revocationDate == nil && !tran.isUpgraded
        
    }
}
