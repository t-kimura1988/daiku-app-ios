//
//  MoreText.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/27.
//

import SwiftUI

struct MoreText: View {
    private var text: String
    @State private var isFirst = true
    @State private var isFold = false
    @State private var needFoldButton = true
    @State private var textHeight: CGFloat? = nil
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text(text)
                    .frame(height: textHeight)
                    .background(GeometryReader { geo in
                        Color.clear.preference(key: SizePreference.self, value: geo.size)
                    })
                    .padding()
                    .onPreferenceChange(SizePreference.self) { textSize in
                        if self.isFirst == true {
                            if textSize.height > 80 {
                                self.textHeight = 80
                                self.isFold = true
                                self.isFirst = false
                                self.needFoldButton = true
                            } else {
                                self.needFoldButton = false
                            }
                        }
                        
                    }
                Spacer()
            }
            
            if needFoldButton {
                Button(action: {
                    self.isFold.toggle()
                    if self.isFold == true {
                        self.textHeight = 80
                    } else {
                        self.textHeight = nil
                    }
                }, label: {
                    Text(isFold ? "もっと見る" : "折る")
                }).padding(.trailing, 8)
            }
        }
    }
}

struct MoreText_Previews: PreviewProvider {
    static var previews: some View {
        MoreText(text: "test")
    }
}


fileprivate struct SizePreference: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
