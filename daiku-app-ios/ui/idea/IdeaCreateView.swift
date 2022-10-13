//
//  IdeaCreateView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/02.
//

import SwiftUI

struct IdeaCreateView: View {
    @EnvironmentObject private var ideaCreateVM: IdeaCreateViewModel
    @EnvironmentObject private var accountMainVm: AccountMainViewModel
    @Environment(\.dismiss) var dismiss
    
    private var comp: () -> Void = {}
    
    init(comp: @escaping () -> Void) {
        self.comp = comp
    }
    
    var body: some View {
        DaikuFormEditor(
            text: ideaCreateVM.body,
            maxSize: 1000
        ) { text in
            ideaCreateVM.save(text: text) {
                comp()
            }
            
        }
    }
}

struct IdeaCreateView_Previews: PreviewProvider {
    static var previews: some View {
        IdeaCreateView(comp: {})
    }
}
