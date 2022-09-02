//
//  ImagePreView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/01.
//

import SwiftUI

struct ImagePreView: View {
    @EnvironmentObject var imagePreViewModel: ImagePreViewModel
    @EnvironmentObject var accountMainVM: AccountMainViewModel
    private var type: ImagePreType = .accountMain
    private var userImage: String? = ""
    private var accountId: Int = 0
    
    init(type: ImagePreType, userImage: String?, accountId: Int) {
        self.type = type
        self.userImage = userImage
        self.accountId = accountId
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch type {
                case .accountMain:
                    if let image = imagePreViewModel.image {
                        Image(uiImage: image)
                    } else {
                        AccountMainImageView()
                    }
                case .accountTop:
                    AccountTopImageView()
                }
                Button(action: {
                    imagePreViewModel.openPhotoSelectSheet()
                }, label: {
                    Text("写真を選択する")
                })
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        accountMainVM.closeImagePreView()
                    }, label: {
                        Text("閉じる")
                    })
                }
            }
            .sheet(isPresented: $imagePreViewModel.isImagePicker) {
                ImagePicker(sourceType: imagePreViewModel.sourceType, imageUrl: $imagePreViewModel.userImage)
            }
            
        }
        .navigationViewStyle(.stack)
        .onAppear {
        }
        .actionSheet(isPresented: $imagePreViewModel.isPhotoSelectSheet) {
            var message: String = ""
            switch imagePreViewModel.screenType {
            case .accountMain:
                message = "アカウントのアイコンに設定する写真を選択しましょう"
            case .accountTop:
                message = "アカウントトップの写真を選択しましょう"
            }
            return ActionSheet(title: Text("写真選択"), message: Text(message), buttons: [
                .default(Text("写真を撮る")) {
                    imagePreViewModel.openImagePicker(type: .camera)
                },
                .default(Text("フォトライブラリから選択")) {
                    imagePreViewModel.openImagePicker(type: .photoLibrary)
                },
                .cancel()
            ])
        }
    }
}

struct AccountMainImageView: View {
    
    @EnvironmentObject var imagePreViewModel: ImagePreViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        let imageURL = URL(string: imagePreViewModel.getUserImage())
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
        } placeholder: {
            Image("samurai")
                .resizable()
        }
        .aspectRatio(contentMode: .fill)
        .frame(width: 200, height: 200)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .clipShape(Circle())
    }
}

fileprivate struct AccountTopImageView: View {
    
    @EnvironmentObject var imagePreViewModel: ImagePreViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text("Account TOP !!!!")
    }
}

struct ImagePreView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePreView(type: .accountMain, userImage: nil, accountId: 0)
    }
}
