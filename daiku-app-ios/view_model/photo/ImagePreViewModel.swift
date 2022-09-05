//
//  ImagePreViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/02.
//

import Foundation
import UIKit

class ImagePreViewModel: ObservableObject {
    @Published var screenType: ImagePreType = .accountMain
    @Published var userImage: String?
    @Published var uid: String = ""
    @Published var isPhotoSelectSheet: Bool = false
    @Published var image: UIImage?
    @Published var isImagePicker: Bool = false
    @Published var sourceType: UIImagePickerController.SourceType = .camera
    @Published var changeImageFlg: Bool? = false
    
    private var firebaseRepository: FirebaseRepository = FirebaseRepository()
    private var accountRepository: AccountRepository = AccountRepository()
    
    func initItem(userImage: String?, uid: String, type: ImagePreType) {
        self.uid = uid
        self.screenType = type
        Task {
            if let userImage = userImage {
                let url = try await firebaseRepository.getDownloadURL(storagePath: userImage)
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                } catch _ {
                    image = nil
                }
            }
            
        }
    }
    
    func openPhotoSelectSheet() {
        isPhotoSelectSheet = true
    }
    
    func closePhotoSelectSheet() {
        isPhotoSelectSheet = false
    }
    
    func getUserImage() -> String{
        guard let userImage = userImage else {
            return ""
        }
        
        return userImage

    }
    
    func openImagePicker(type: UIImagePickerController.SourceType) {
        self.sourceType = type
        self.isImagePicker = true
    }
    
    func closeImagePicker() {
        self.isImagePicker = false
    }
    
    func getChangeImageFlg() -> Bool {
        if let changeImageFlg = changeImageFlg {
            return changeImageFlg
        }
        
        return false
    }
    
    func saveImage(completion: @escaping () -> Void) {
        guard let image = image else {
            return
        }

        firebaseRepository.uploadStorage(path: "account/\(uid)/\(screenType.rawValue)_400.jpeg", image: image, completion: { path in
            guard let path = path else {
                return
            }
            Task {
                do {
                    let _ = try await self.accountRepository.uploadImage(body: .init(imagePath: path, imageType: self.screenType.code))
                    
                    completion()
                    
                } catch ApiError.responseError(let code) {
                    print(code)
                }
            }
        })
    }
}


enum ImagePreType: String, RawRepresentable, CaseIterable {
    
    case accountMain
    case profileBackImage
    var id: String { rawValue }
    
    var code: String {
        switch self {
        case .accountMain:
            return "0"
        case .profileBackImage:
            return "1"
        }
        
    }
    
}
