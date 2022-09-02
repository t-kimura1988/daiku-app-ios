//
//  ImagePicker.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/02.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .camera
    @Environment(\.dismiss) private var dismiss
    @Binding var imageUrl: String?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            print("AAAAAA")
            guard let url = info[UIImagePickerController.InfoKey.imageURL] as? URL else {
                print("A3")
                return
            }
            
            print(url.absoluteString)
            print(url.path)
            
            parent.imageUrl = url.absoluteString
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("AAAAAA2")
            parent.dismiss()
        }
    }
}
