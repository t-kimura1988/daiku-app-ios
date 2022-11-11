//
//  StoreViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/11/02.
//

import Foundation
import StoreKit

class StoreViewModel: ObservableObject {

    @Published var products: [Product] = [Product]()
    @Published var purchasedProducts: [Product] = [Product]()
    
    @Published var isShceduleFeatureParchase: Bool = false
    @Published var isShceduleFeaturePending: Bool = false
    @Published var isVerifyError: Bool = false
    
    var updateListenerTask: Task<Void, Error>? = nil
    
    private let productIds: [String: String]
    
    init () {
        if let path = Bundle.main.path(forResource: "Products", ofType: "plist"),
        let plist = FileManager.default.contents(atPath: path) {
            productIds = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String: String]) ?? [:]
        } else {
            productIds = [:]
        }
        
        updateListenerTask = listenForTransactions()

        Task {
            await requestProducts()

            await updateCustomerProductStatus()
        }
        
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    

    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)

                    await self.updateCustomerProductStatus()

                    await transaction.finish()
                } catch {
                    self.isVerifyError = true
                }
            }
        }
    }
    
    @MainActor
    func requestProducts() async {
        do {
            let storeProducts: [Product] = try await Product.products(for: productIds.keys)
            DispatchQueue.main.async {
                self.products = storeProducts
            }
            
        } catch {
            print("Failed product request from the App Store server: \(error)")
        }
    }
    
    func purchase(product: Product) async throws -> Transaction? {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                let tran = try checkVerified(verification)
                await updateCustomerProductStatus()
                await tran.finish()
                
                return tran
            case .userCancelled:
                return nil
            case .pending:
                DispatchQueue.main.async {
                    self.isShceduleFeaturePending = true
                }
                return nil
            default:
                return nil
            }
            
        } catch StoreError.failedVerification {
            isVerifyError = true
            return nil
        }
    }
    
    @MainActor
    func updateCustomerProductStatus() async {
        var purchasedProducts: [Product] = []
        
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                if transaction.productID == "ScheduleFeature" {
                    isShceduleFeatureParchase = try await self.isPurchased(productId: transaction.productID)
                    if isShceduleFeatureParchase {
                        isShceduleFeaturePending = false
                    }
                }

                switch transaction.productType {
                case .nonConsumable:
                    if let products = products.first(where: { $0.id == transaction.productID }) {
                        purchasedProducts.append(products)
                    }
                case .nonRenewable:
                    break
                case .autoRenewable:
                    break
                default:
                    break
                }
            } catch  {
                print()
            }
        }

        //Update the store information with the purchased products.
        self.purchasedProducts = purchasedProducts

    }
    
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
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
        
        print(tran)
        
        return tran.revocationDate == nil && !tran.isUpgraded
        
    }
    
    func restore() {
        Task {
            try? await AppStore.sync()
        }
    }
}
