//
//  StoreView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/11/02.
//

import SwiftUI
import StoreKit

struct StoreView: View {
    @EnvironmentObject var storeVM: StoreViewModel
    @Environment(\.colorScheme) var colorScheme
    private var productId: String = ""
    private var onPurchased: () -> Void
    
    init(productId: String = "", onPurchased: @escaping () -> Void = {}) {
        self.productId = productId
        self.onPurchased = onPurchased
    }
    
    var body: some View {
        ScrollView {
            Button(action: {
                storeVM.restore()
            },label: {
                Text("購入情報を復元する(Restore)")
            })
            ForEach(storeVM.products.filter{ $0.id == productId}) { item in
                HStack {
                    VStack(alignment: .leading) {
                        VStack (alignment: .leading){
                            Text(item.displayName)
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("購入額:\(item.displayPrice)")
                                .fontWeight(.bold)
                        }
                        Text(item.description)
                            .font(.subheadline)
                            .padding(.top, 5)
                    }
                    .padding(3)
                    
                    Spacer()
                    Button(action: {
                        onPurchase(product: item)
                    }, label: {
                        Text(storeVM.isShceduleFeaturePending ? "承認待ち" : "購入する(\(item.displayPrice))")
                    })
                    .padding(3)
                    .disabled(storeVM.isShceduleFeatureParchase || storeVM.isShceduleFeaturePending)
                }
                .background(colorScheme == .dark ? .black : .white)
                .cornerRadius(8)
                .clipped()
                .shadow(color: .gray.opacity(0.7), radius: 5)
                .padding(8)
            }
            
            Divider()
        }
        .onAppear{
        }
        .alert(isPresented: $storeVM.isVerifyError) {
            Alert(title: Text("この購入情報は認証されていません。App Storeにお問い合わせください。"), message: nil, dismissButton: .default(Text("OK")))
        }
    }
    
    private func onPurchase(product: Product) {
        Task {
            if try await storeVM.purchase(product: product) != nil {
                self.onPurchased()
            }
        }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
