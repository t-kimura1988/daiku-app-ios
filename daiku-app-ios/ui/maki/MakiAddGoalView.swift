//
//  MakiAddGoalView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/17.
//

import SwiftUI

struct MakiAddGoalView: View {
    @EnvironmentObject var makiAddGoalVM: MakiAddGoalViewModel
    @EnvironmentObject private var homeVM: HomeMainViewModel
    private var makiId: Int = 0
    
    init(makiId: Int) {
        self.makiId = makiId
    }
    
    var body: some View {
        
        AddGoalListParts()
        .onAppear{
            makiAddGoalVM.initItem(makiId: makiId)
            makiAddGoalVM.getGoalList()
        }
        
    }
}

struct MakiAddGoalView_Previews: PreviewProvider {
    static var previews: some View {
        MakiAddGoalView(makiId: 0)
    }
}
