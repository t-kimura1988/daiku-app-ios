//
//  FirebaseRepository.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/03.
//

import Foundation
import Firebase
import FirebaseStorage

struct FirebaseRepository {
    private var storage: Storage = Storage.storage()
    
    func uploadStorage(path: String, image: UIImage, completion: @escaping (URL) -> Void) {
        let storageRef = storage.reference().child(path)

        let data = image.jpegData(compressionQuality: 0.2)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        metadata.cacheControl = "public"
        
        if let data = data {
            let putData = storageRef.putData(data, metadata: metadata)
            
            putData.observe(.progress) {_ in
                // 処理中
            }
            
            putData.observe(.failure) { error in
                print(error)
            }
            putData.observe(.success) { snapshot in
                Task {
                    let url = try await storageRef.downloadURL()
                    completion(url)
                }
            }
            
        }
        
    }

    func getDownloadURL(storagePath: String) async throws -> URL {
        let startsRef = storage.reference().child(storagePath)
        let downloadURL = try await startsRef.downloadURL()
        
        return downloadURL
    }
}
