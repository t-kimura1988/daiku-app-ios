//
//  AccountExistViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//
import Foundation
import Combine
import Firebase
import GoogleSignIn

class AccountExistViewModel: ObservableObject {
    private var listener: AuthStateDidChangeListenerHandle!
    
    @Published var state: SignInStatus = .Loading
    @Published var account: AccountResponse = AccountResponse()
    
    var accountRepository: AccountRepository = AccountRepository()
    
    init() {
        
        listener = Auth.auth().addStateDidChangeListener{auth, user in
            Task {
                
                if let _ = user {
                    do {
                        
                        let account = try await self.accountRepository.getAccount()

                        DispatchQueue.main.async {
                            self.account = account
                            self.state = .SignIn
                        }
                    } catch ApiError.responseError(let code) {
                        if code == "E0003" {
                            // アカウントタイプエラー
                            self.logout()
                            DispatchQueue.main.async {
                                self.state = .SignOut
                            }
                        }
                        if code == "E0004" {
                            // アカウント存在しないエラー
                            DispatchQueue.main.async {
                                self.state = .SignIn_NoExist
                            }
                        }
                    }
                    
                } else {
                    
                    DispatchQueue.main.async {
                        self.state = .SignOut
                    }
                    
                }
            }
        }
    }
    
    func googleSignIn(vc: UIViewController) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: vc) { user, error in
            
            if let error = error {
              return
            }

            guard
              let authentication = user?.authentication,
              let idToken = authentication.idToken
            else {
              return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) {res, err in
                
                if let _ = err {
                  return
                }
                
                self.state = .SignIn
            
            }
        }
    }
    
    func loginStateToSignIn() {
        DispatchQueue.main.async {
            self.state = .SignIn
        }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Sign out error!!! \(signOutError.userInfo)")
        }
    }
}
