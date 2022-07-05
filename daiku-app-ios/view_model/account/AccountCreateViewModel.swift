//
//  AccountCreateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/27.
//

import Foundation
import Combine
import SwiftUI

class AccountCreateViewModel: ObservableObject {
    @Published var familyName: String = ""
    @Published var givenName: String = ""
    @Published var nickName: String = ""
    
    private var accountRepository: AccountRepository = AccountRepository()
    
    func createAccount(completion: @escaping (AccountResponse) -> Void) {
        Task {
            let account = try await accountRepository.createAccount(body: .init(familyName: familyName, givenName: givenName, nickName: nickName))
            
            completion(account!)
        }
    }
}
