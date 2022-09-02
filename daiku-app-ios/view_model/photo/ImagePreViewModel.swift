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
    @Published var accountId: Int = 0
    @Published var isPhotoSelectSheet: Bool = false
    @Published var image: UIImage?
    @Published var isImagePicker: Bool = false
    @Published var sourceType: UIImagePickerController.SourceType = .camera
    
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
}


enum ImagePreType {
    case accountMain
    case accountTop
}
