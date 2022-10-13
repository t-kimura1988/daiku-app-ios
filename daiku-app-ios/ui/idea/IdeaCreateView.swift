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
    var body: some View {
        DaikuFormEditor(
            text: ideaCreateVM.body,
            maxSize: 1000
        ) { text in
            ideaCreateVM.save(text: text) {
                accountMainVm.getInitIdeaList()
            }
            
        }
    }
}

struct IdeaCreateView_Previews: PreviewProvider {
    static var previews: some View {
        IdeaCreateView()
    }
}
