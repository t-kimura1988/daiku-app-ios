//
//  CharacterCreateView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/08.
//

import SwiftUI

struct CharacterCreateView: View {
    @EnvironmentObject var ideaDetailVM: IdeaDetailViewModel
    @EnvironmentObject private var charaCreateVM: CharacterCreateViewModel
    @FocusState var focus: Bool
    
    private var storyCharaId: Int = 0
    private var ideaId: Int = 0
    private var storyId: Int = 0
    private var charaName: String = ""
    private var charaDesc: String = ""
    init(storyCharaId: Int = 0, ideaId: Int = 0, storyId: Int = 0, charaName: String = "", charaDesc: String = "") {
        self.storyCharaId = storyCharaId
        self.ideaId = ideaId
        self.storyId = storyId
        self.charaName = charaName
        self.charaDesc = charaDesc
    }
    var body: some View {
        VStack {
            Form {
                TextField("キャラクター名", text: $charaCreateVM.characterName)
                    .focused($focus)
                    .onChange(of: charaCreateVM.characterName) { newText in
                        charaCreateVM.chkCharaName(newText: newText)
                    }
                VStack {
                    ZStack(alignment: .leading) {
                        if charaCreateVM.characterDesc.isEmpty {
                            Text("説明(100文字まで)")
                                .foregroundColor(.gray)
                                .padding(4)
                        }
                        TextEditor(text: $charaCreateVM.characterDesc)
                            .onChange(of: charaCreateVM.characterDesc) { newText in
                                charaCreateVM.chkCharaDesc(newText: newText)
                            }
                    }
                    HStack {
                        Spacer()
                        Text("\(charaCreateVM.characterDesc.count)/100文字")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                    
                }
                
                HStack(alignment: .center, spacing: 8) {
                    if charaCreateVM.leaderFlg {
                        Image(systemName: "checkmark.square")
                            .foregroundColor(.blue)
                    } else {
                        Image(systemName: "square")
                            .foregroundColor(.blue)
                    }
                    Text("主人公に設定する")
                }
                .onTapGesture {
                    charaCreateVM.changeLeaderFlg()
                }
            }
            Spacer()
            
            HStack {
                Button(action: {
                    ideaDetailVM.closeCreateCharaSheet()
                }, label: {
                    Text("閉じる")
                })
                Spacer()
                Button(action: {
                    charaCreateVM.createChara() { ideaId in
                        ideaDetailVM.getDetail(ideaId: ideaId)
                        ideaDetailVM.closeCreateCharaSheet()
                    }
                }, label: {
                    Text("保存")
                })
                .disabled(!charaCreateVM.isSaveButton)
            }
            .padding(18)
        }
        .onAppear {
            charaCreateVM.initItem(
                storyCharaId: storyCharaId,
                ideaId: ideaId,
                storyId: storyId,
                charaName: charaName,
                charaDesc: charaDesc
            )
            
            charaCreateVM.initValidate()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                focus = true
            }
        }
        
    }
}

struct CharacterCreateView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCreateView()
    }
}
