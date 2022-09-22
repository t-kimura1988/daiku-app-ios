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
    private var isNewLine: Bool = true
    
    init(text: String, maxSize: Int, isNewLine: Bool = true, changeText: @escaping (String) -> Void) {
        self.text = text
        self.changeText = changeText
        self.maxTextSize = maxSize
        self.isNewLine = isNewLine
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(text.count)文字 / \(maxTextSize)文字まで")
                    .foregroundColor(.gray)
                TextEditor(text: $text)
                    .focused($focus)
                    .onReceive(Just(text)) {_ in
                        if !isNewLine {
                            text = text.trimmingCharacters(in: .newlines)
                        }
                        if text.count > maxTextSize {
                            text = String(text.prefix(maxTextSize))
                        }
                    }
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {changeText(text)}, label: {Text("反映")})
                        }
                    }
                    .onSubmit {
                        print(text)
                    }
                    .submitLabel(.return)
            }
            .navigationTitle(Text("編集"))
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                focus = true
            }
        }
    }
}
