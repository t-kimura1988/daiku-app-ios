//
//  RefreshView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/05.
//

import SwiftUI

struct RefreshView: View {
    @State private var isRefreshing = false
    var coodinateSpaceName: String
    var onRefresh: () -> Void
    
    var body: some View {
        GeometryReader{geometory -> Color in
            let midY = geometory.frame(in: .named(coodinateSpaceName)).midY
            let maxY = geometory.frame(in: .named(coodinateSpaceName)).maxY
            if midY > 50 {
                DispatchQueue.main.async {
                    isRefreshing = true
                }
            }else if maxY < 20 {
                DispatchQueue.main.async {
                    if isRefreshing {
                        isRefreshing = false
                        onRefresh()
                    }
                }
            }
            
            return Color.clear
        }
    }
}
