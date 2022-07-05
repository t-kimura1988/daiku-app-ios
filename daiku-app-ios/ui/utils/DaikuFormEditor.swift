//
//  DaikuFormEditor.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/01.
//

import SwiftUI
import Combine

struct DaikuFormEditor: View {
    @State var text: String
    @FocusState var focus: Bool
    var changeText: (String) -> Void
    private var maxTextSize: Int = 0
    
    init(text: String, maxSize: Int , changeText: @escaping (String) -> Void) {
        self.text = text
        self.changeText = changeText
        self.maxTextSize = maxSize
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(text.count)文字 / \(maxTextSize)文字まで")
                    .foregroundColor(.gray)
                TextEditor(text: $text)
                    .focused($focus)
                    .onReceive(Just(text)) {_ in
                        if text.count > maxTextSize {
                            text = String(text.prefix(maxTextSize))
                        }
                    }
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {changeText(text)}, label: {Text("反映")})
                        }
                    }
            }
            .navigationTitle(Text("編集"))
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                focus = true
            }
        }
    }
}
