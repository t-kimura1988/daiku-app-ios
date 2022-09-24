//
//  MakiCreateView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/13.
//

import SwiftUI
import Combine

struct MakiCreateView: View {
    @EnvironmentObject var vm: HomeMainViewModel
    @EnvironmentObject var makiCreateVM: MakiCreateViewModel
    var body: some View {
        NavigationView() {
            
            VStack(alignment: .leading, spacing: 50) {
                
                TextField("書のタイトル", text: $makiCreateVM.makiTitle)
                    .padding()
                    .onReceive(Just($makiCreateVM.makiKey)) {_ in
                        makiCreateVM.chkMakiTitleText(text: makiCreateVM.makiTitle)
                    }
                
                TextField("巻のキー", text: $makiCreateVM.makiKey)
                    .padding()
                    .onReceive(Just($makiCreateVM.makiKey)) {_ in
                        makiCreateVM.chkMakiKeyText(text: makiCreateVM.makiKey)
                    }
                Text("※巻のキーは巻の別名です。半角英数字でわかりやすい名称で入力すると良いです。")
                    .padding(.leading)
                    .font(.caption)
                    .foregroundColor(.orange)
                
                ZStack(alignment: .leading) {
                    if makiCreateVM.makiDesc.isEmpty {
                        Text("巻の説明を入力しましょう")
                            .foregroundColor(.gray)
                    }else {
                        Text(makiCreateVM.makiDesc)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .contentShape(Rectangle())
                .onTapGesture {
                    makiCreateVM.openFormSheet()
                }
            }
            .onAppear{
                makiCreateVM.initValidate()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {vm.closeProjectSheet()}, label: {Text("閉じる")})
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        makiCreateVM.createMaki(completion: {
                            vm.closeProjectSheet()
                        })
                    }, label: {Text("保存")})
                    .disabled(!makiCreateVM.isSaveButton)
                }
            }
            .fullScreenCover(isPresented: $makiCreateVM.isFormSheet) {
                
                DaikuFormEditor(
                    text: makiCreateVM.makiDesc,
                    maxSize: 3000
                ) { text in
                    makiCreateVM.changeMakiDescText(text: text)
                    makiCreateVM.closeFormSheet()
                }
            }
        }
    }
}

struct MakiCreateView_Previews: PreviewProvider {
    static var previews: some View {
        MakiCreateView()
    }
}
