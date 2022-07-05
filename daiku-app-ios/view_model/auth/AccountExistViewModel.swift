//
//  AccountExistViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

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
                let account = try await self.accountRepository.getAccount()
                
                if account == nil {
                    DispatchQueue.main.async {
                        self.state = .SignIn_NoExist
                    }
                } else {
                    if let _ = user {
                        DispatchQueue.main.async {
                            self.state = .SignIn
                        }
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
                print(error.localizedDescription)
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
                
                if let err = err {
                    print(err.localizedDescription)
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
}
