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
    @Published var accountId: Int = 0
    
    @Published var isSaveButton: Bool = false
    @Published var isSending: Bool = false
    
    private var accountRepository: AccountRepository = AccountRepository()
    
    func initItem(accountId: Int = 0, familyName: String = "", givenName: String = "", nickName: String = "") {
        self.accountId = accountId
        self.familyName = familyName
        self.givenName = givenName
        self.nickName = nickName
    }
    
    func isSave() -> Bool {
        return isSaveButton
    }
    
    func createAccount(completion: @escaping (AccountResponse) -> Void) {
        isSending = true
        if accountId == 0 {
            Task {
                let account = try await accountRepository.createAccount(body: .init(familyName: familyName, givenName: givenName, nickName: nickName))
                DispatchQueue.main.async {
                    self.isSending = false
                }
                completion(account!)
            }
        } else {
            Task {
                let account = try await accountRepository.updateAccount(body: .init(familyName: familyName, givenName: givenName, nickName: nickName))
                DispatchQueue.main.async {
                    self.isSending = false
                }
                completion(account!)
            }
        }
    }
    
    func initVali() {
        let familyNameVali = $familyName.map({ !$0.isEmpty && !$0.moreGreater(size: 100) }).eraseToAnyPublisher()
        let givenNameVali = $givenName.map({ !$0.isEmpty && !$0.moreGreater(size: 100)}).eraseToAnyPublisher()
        let nickNameVali = $nickName.map({ !$0.isEmpty && !$0.moreGreater(size: 100) }).eraseToAnyPublisher()
        
        Publishers.CombineLatest3(familyNameVali, givenNameVali, nickNameVali)
            .map({ [$0.0, $0.1, $0.2] })
            .map({ $0.allSatisfy{ $0 }})
            .assign(to: &$isSaveButton)
    }
    
    func chkFamilyNameText(text: String) {
        if text.count > 5 {
            familyName = String(text.prefix(5))
        }
    }
    
    func chkGivenNameText(text: String) {
        if text.count > 100 {
            givenName = String(text.prefix(100))
        }
    }
    
    func chkNickNameText(text: String) {
        if text.count > 100 {
            nickName = String(text.prefix(100))
        }
    }
}
