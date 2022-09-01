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
import CryptoKit
import FirebaseAuth
import AuthenticationServices

class AccountExistViewModel: ObservableObject {
    private var listener: AuthStateDidChangeListenerHandle!
    
    @Published var state: SignInStatus = .Loading
    @Published var account: AccountResponse = AccountResponse()
    
    @Published var currentNonce: String = ""
    @Published var requestNonce: String?
    
    @Published var isDelAccount: Bool = false
    @Published var isFirebaseAccountDel: Bool = false
    
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
                        if code == "E0001" {
                            DispatchQueue.main.async {
                                self.isDelAccount = true
                                self.state = .SignOut
                            }
                        }
                        if code == "E0005" {
                            DispatchQueue.main.async {
                                self.isDelAccount = true
                                self.isFirebaseAccountDel = true
                                self.state = .SignOut
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
            if let _ = error {
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
                    let firebaseErr = err as NSError
                    switch firebaseErr.code {
                    case 17005:
                        self.isDelAccount = true
                        self.isFirebaseAccountDel = true
                    default:
                        self.isDelAccount = false
                    }
                  return
                }
                
                self.isFirebaseAccountDel = false
                
                var googleFamilyName: String = ""
                var googleGiVenName: String = ""
                
                if let familyName = user?.profile?.familyName {
                    googleFamilyName = familyName
                }
                if let givenName = user?.profile?.givenName {
                    googleGiVenName = givenName
                }
                
                self.createDaikuAccount(familyName: googleFamilyName, givenName: googleGiVenName)
            
            }
        }
    }
    
    func closeDelAccount() {
        isDelAccount = false
    }
    
    func openDelAccount() {
        isDelAccount = true
    }
    
    func changeFirebaseDelAlert() {
        isFirebaseAccountDel = !isFirebaseAccountDel
    }
    
    private func createDaikuAccount(familyName: String, givenName: String) {
        Task {
            do {
                
                let account = try await self.accountRepository.getAccount()

                DispatchQueue.main.async {
                    self.account = account
                    self.state = .SignIn
                }
            } catch ApiError.responseError(let code) {
                if code == "E0001" {
                    DispatchQueue.main.async {
                        self.isDelAccount = true
                        self.state = .SignOut
                    }
                    
                }
                if code == "E0003" {
                    // アカウントタイプエラー
                    self.logout()
                    DispatchQueue.main.async {
                        self.state = .SignOut
                    }
                }
                if code == "E0004" {
                    // アカウント存在しない場合Daikuアカウント作成する
                    let res = try await self.accountRepository.createAccount(body: .init(familyName: familyName, givenName: givenName, nickName: ""))
                    DispatchQueue.main.async {
                        self.state = .SignIn
                        self.account = res!
                    }
                }
                
                if code == "E0005" {
                    DispatchQueue.main.async {
                        self.isDelAccount = true
                        self.isFirebaseAccountDel = true
                        self.state = .SignOut
                    }
                }
            }
            
        }
    }
    
    func setNonce() {
        currentNonce = randomNonceString()
        requestNonce = sha256(currentNonce)
    }
    
    func singInWithApple(authResult: ASAuthorization) {
        
        if let appleIDCredential = authResult.credential as? ASAuthorizationAppleIDCredential {
            guard requestNonce != nil else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                  }
            guard let appleIDToken = appleIDCredential.identityToken else {
                    print("Unable to fetch identity token")
                    return
                  }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                    return
                  }
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: currentNonce)
            
            Auth.auth().signIn(with: credential){(authResult, err) in
                if let err = err {
                    let firebaseErr = err as NSError
                    switch firebaseErr.code {
                    case 17005:
                        self.isDelAccount = true
                    default:
                        self.isDelAccount = false
                    }
                    return
                }
                guard let _ = authResult else {
                    return
                }
                var appleFamilyName: String = ""
                var appleGivenName: String = ""
                
                if let familyName = appleIDCredential.fullName?.familyName {
                    appleFamilyName = familyName
                }
                if let givenName = appleIDCredential.fullName?.givenName {
                    appleGivenName = givenName
                }
                self.createDaikuAccount(familyName: appleFamilyName, givenName: appleGivenName)
            }
        }
    }
    
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
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
    
    func reUpdateAccount() {
        Task {
            let accountRes = try await accountRepository.reUpdateAccount()
            
            DispatchQueue.main.async {
                self.account = accountRes!
                self.state = .SignIn
            }
        }
    }
}
