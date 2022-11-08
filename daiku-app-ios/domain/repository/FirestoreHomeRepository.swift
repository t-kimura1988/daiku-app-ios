//
//  FirestoreHomeRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/30.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FirestoreHomeRepository {
    private var db: Firestore = Firestore.firestore()
    
    func getHomeData() async throws -> HomeData{
        do {
            let res = try await db.collection("home")
                .document("home_1")
                .getDocument(as: HomeData.self)
            
            return res
        } catch {
            let error = error
            throw ApiError.responseError("Firestore Get Ducument Error")
        }
    }
}
