//
//  StoreManager.swift
//  BisonC
//
//  Created by Maksim Kosharny on 14.01.2026.
//

import Foundation
import StoreKit
import Combine

@MainActor
class StoreManager: ObservableObject {
    private let productIDs = ["premium_export_data", "premium_reset_history"]
    
    @Published var products: [Product] = []
    @Published var purchasedIDs = Set<String>()
    
    private var transactionTask: Task<Void, Never>?
    
    init() {
        transactionTask = Task {
            await listenForTransactions()
        }
        
        Task {
            await fetchProducts()
            await updatePurchasedProducts()
        }
    }
    
    deinit {
        transactionTask?.cancel()
    }
    
    func listenForTransactions() async {
            for await result in Transaction.updates {
                do {
                    let transaction = try checkVerified(result)
                    
                    purchasedIDs.insert(transaction.productID)
                    
                    await transaction.finish()
                    
                    print("Transaction updated & finished: \(transaction.productID)")
                } catch {
                    print("Transaction failed verification")
                }
            }
        }
    
    func fetchProducts() async {
        do {
            self.products = try await Product.products(for: productIDs)
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
    
    func purchase(_ product: Product) async -> Bool {
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                purchasedIDs.insert(transaction.productID)
                await transaction.finish()
                return true
            default:
                return false
            }
        } catch {
            return false
        }
    }
    
    func restorePurchases() async {
        try? await AppStore.sync()
        await updatePurchasedProducts()
    }
    
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            if let transaction = try? checkVerified(result) {
                purchasedIDs.insert(transaction.productID)
            }
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified: throw StoreError.failedVerification
        case .verified(let safe): return safe
        }
    }
}

enum StoreError: Error { case failedVerification }
