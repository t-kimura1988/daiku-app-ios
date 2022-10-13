//
//  IdeaCreatViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/02.
//

import Foundation

class IdeaCreateViewModel: ObservableObject {
    @Published var isIdeaCreateSheet: Bool = false
    @Published var isIdeaUpdateSheet: Bool = false
    @Published var body: String = ""
    
    private var ideaRepository: IdeaRepository = IdeaRepository()
    private var ideaId: Int = 0
    
    init(body: String = "", ideaId: Int = 0) {
        self.body = body
        self.ideaId = ideaId
    }
    
    func openIdeaCreateSheet() {
        isIdeaCreateSheet = true
    }
    
    func closeIdeaCreateSheet() {
        isIdeaCreateSheet = false
    }
    func openIdeaUpdateSheet() {
        isIdeaUpdateSheet = true
    }
    
    func closeIdeaUpdateSheet() {
        isIdeaUpdateSheet = false
    }
    
    func save(text: String, compilate:  @escaping () -> Void) {
        if ideaId == 0 {
            Task {
                do {
                    let _ = try await ideaRepository.saveIdea(request: .init(body: text))
                    compilate()
                } catch ApiError.responseError(_) {
                }
            }
            
        } else {
            Task {
                do {
                    let _ = try await ideaRepository.updateIdea(request: .init(ideaId: self.ideaId, body: text))
                    compilate()
                } catch ApiError.responseError(_) {
                }
            }
            
        }
    }
}
