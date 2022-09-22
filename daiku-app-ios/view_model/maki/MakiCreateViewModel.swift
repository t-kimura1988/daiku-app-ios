//
//  MakiCreateViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/14.
//

import Foundation
import Combine

class MakiCreateViewModel: ObservableObject {
    @Published var makiTitle: String = ""
    @Published var makiKey: String = ""
    @Published var makiDesc: String = ""
    
    @Published var isFormSheet: Bool = false
    @Published var makiKeyErrMsg: String = ""
    @Published var isSaveButton: Bool = false
    
    private var makiRepository: MakiRepository = MakiRepository()
    
    func initItem(makiKey: String, makiDesc: String) {
        self.makiKey = makiKey
        self.makiDesc = makiDesc
    }
    
    func createMaki(completion: @escaping () -> Void) {
        isSaveButton = false
        if !makiKey.isAlpaNumSym() {
            makiKeyErrMsg = "巻キーは半角英数字記号で記載してください。"
            isSaveButton = true
            return
        }
        Task {
            do {
                let _ = try await self.makiRepository.createMaki(body: .init(makiTitle: self.makiTitle, makiKey: self.makiKey, makiDesc: self.makiDesc))
                DispatchQueue.main.async {
                    self.isSaveButton = true
                }
                completion()
                
            } catch ApiError.responseError(let errorCode) {
                DispatchQueue.main.async {
                    self.isSaveButton = true
                }
                print(errorCode)
            }
        }
    }
    
    func openFormSheet() {
        isFormSheet = true
    }
    
    func closeFormSheet() {
        isFormSheet = false
    }
    
    func chkMakiTitleText(text: String) {
        if text.count > 100 {
            makiKey = String(text.prefix(100))
        }
    }
    
    func chkMakiKeyText(text: String) {
        if text.count > 20 {
            makiKey = String(text.prefix(20))
        }
        print(text)
        if text.isAlpaNumSym() {
//            makiKeyErrMsg = "巻キーは半角英数字記号で記載してください。"
        }
    }
    
    func changeMakiDescText(text: String) {
        makiDesc = text
    }
    func initValidate() {
        
        let makiTitleVali = $makiTitle.map({ !$0.isEmpty }).eraseToAnyPublisher()
        let makiKeyVali = $makiKey.map({ !$0.isEmpty }).eraseToAnyPublisher()
        let makiDescVali = $makiDesc.map({ !$0.isEmpty }).eraseToAnyPublisher()
        
        Publishers.CombineLatest3(makiTitleVali, makiKeyVali,makiDescVali)
            .map({ [$0.0, $0.1, $0.2] })
            .map({ $0.allSatisfy{ $0 }})
            .assign(to: &$isSaveButton)
    }
    
    
}
