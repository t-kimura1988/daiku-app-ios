//
//  MakiDetailTabView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/16.
//

import SwiftUI

struct MakiDetailTabView: View {
    @EnvironmentObject private var makiDetailVM: MakiDetailViewModel
    @State var tabBarOffset: CGFloat = 0
    
    @Environment(\.colorScheme) var colorScheme
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0) {
            HStack (spacing: 0) {
                ForEach(MakiDetailTabButtonTitle.allCases) { title in
                    TabButton(title: title.rawValue, currentTab: $makiDetailVM.currentTab, animation: animation)
                }
            }
            Divider()
        }
        .padding(.top, 30)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .offset(y: tabBarOffset < 90 ? -tabBarOffset + 90 : 0)
        .overlay(
            GeometryReader{reader -> Color in
                let minY = reader.frame(in: .global).minY
                DispatchQueue.main.async {
                    tabBarOffset = minY
                }
                
                
                return Color.clear
            }
        )
    }
}

struct MakiDetailTabView_Previews: PreviewProvider {
    static var previews: some View {
        MakiDetailTabView()
    }
}
