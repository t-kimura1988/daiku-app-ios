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
    private var uid: String = ""
    
    init(type: ImagePreType, userImage: String?, uid: String) {
        self.type = type
        self.userImage = userImage
        self.uid = uid
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch type {
                case .accountMain:
                    
                    AccountMainImageView()
                case .profileBackImage:
                    ProfileBackImageView()
                }
                Button(action: {
                    imagePreViewModel.openPhotoSelectSheet()
                }, label: {
                    Text("写真を選択する")
                })
                .confirmationDialog(imagePreViewModel.getPhotoSelectDialogTitle(), isPresented: $imagePreViewModel.isPhotoSelectSheet, actions: {
                    Button(action: {
                        imagePreViewModel.openImagePicker(type: .camera)
                        
                    }, label: {
                        Text("写真を撮る")
                    })
                    Button(action: {
                        imagePreViewModel.openImagePicker(type: .photoLibrary)
                        
                    }, label: {
                        Text("フォトライブラリから選択")
                    })
                })
                Spacer()
                Button(action: {
                    imagePreViewModel.saveImage(completion: {
                        accountMainVM.closeImagePreView()
                    })
                }, label: {
                    Text("保存")
                        .foregroundColor(imagePreViewModel.getChangeImageFlg() ? .white : .gray)
                })
                .disabled(!imagePreViewModel.getChangeImageFlg())
                .frame(maxWidth: .infinity, minHeight: 44.0)
                .background(Color.orange.ignoresSafeArea(edges: .bottom))
                
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
                ImagePicker(sourceType: imagePreViewModel.sourceType, imageUrl: $imagePreViewModel.userImage, image: $imagePreViewModel.image, changeImageFlg: $imagePreViewModel.changeImageFlg)
            }
            
        }
        .navigationViewStyle(.stack)
        .onAppear {
            imagePreViewModel.initItem(userImage: userImage, uid: uid, type: type)
        }
    }
}

struct AccountMainImageView: View {
    
    @EnvironmentObject var imagePreViewModel: ImagePreViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Image(uiImage: imagePreViewModel.image == nil ? UIImage(named: "samurai")! : imagePreViewModel.image!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .clipShape(Circle())
    }
}

fileprivate struct ProfileBackImageView: View {
    
    @EnvironmentObject var imagePreViewModel: ImagePreViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if let image = imagePreViewModel.image {
            Image(uiImage: image)
                .resizable()
                .background(colorScheme == .dark ? Color.black : Color.white)
                .frame(
                    width: getRect().width,
                    height: 250,
                    alignment: .center)
                .aspectRatio(contentMode: .fill)
                .padding(10)
        } else {
            
                Color(.green)
                .aspectRatio(contentMode: .fill)
                .frame(
                    width: getRect().width,
                    height: 250,
                    alignment: .center)
                .cornerRadius(0)
        }
    }
}


extension ProfileBackImageView {
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
}

struct ImagePreView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePreView(type: .accountMain, userImage: nil, uid: "test")
    }
}
