//
//  IdeaCreatViewModel.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/02.
//

import Foundation

class IdeaCreateViewModel: ObservableObject {
    @Published var isIdeaCreateSheet: Bool = false
    @Published var body: String = ""
    
    private var ideaRepository: IdeaRepository = IdeaRepository()
    
    func openIdeaCreateSheet() {
        isIdeaCreateSheet = true
    }
    
    func closeIdeaCreateSheet() {
        isIdeaCreateSheet = false
    }
    
    func save(text: String, compilate:  @escaping () -> Void) {
        Task {
            do {
                let res = try await ideaRepository.saveIdea(request: .init(body: text))
                DispatchQueue.main.async {
                    self.closeIdeaCreateSheet()
                }
                compilate()
            } catch ApiError.responseError(let err) {
                print("api error")
                print(err)
            }
        }
    }
}
