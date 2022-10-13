//
//  IdeaDetailView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/03.
//

import SwiftUI

struct IdeaDetailView: View {
    @EnvironmentObject var ideaDetailVM: IdeaDetailViewModel
    @EnvironmentObject var ideaCreateVM: IdeaCreateViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    private var idea: IdeaSearchResponse = IdeaSearchResponse()
    
    init(idea: IdeaSearchResponse) {
        self.idea = idea
    }
    
    var body: some View {
        let item: IdeaSearchResponse = ideaDetailVM.idea
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        HStack {
                            UserImageView(userImage: item.getAccountImageURL(), placeholderType: .samurai)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .background(colorScheme == .dark ? Color.black : Color.white)
                                .clipShape(Circle())
                            Text("\(item.createdAccountFamilyName) \(item.createdAccountGivenName)")
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding(.bottom, 8)
                        Text(item.body)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .frame(minHeight: 50)
                            .onTapGesture {
                                ideaCreateVM.openIdeaUpdateSheet()
                            }
                        Divider()
                        if ideaDetailVM.idea.isStory() {
                            StoryDetailParts()
                        } else {
                            Button(action: {
                                ideaDetailVM.openStoryCreateSheet()
                            }, label: {
                                Text("物語を作成する")
                                    .foregroundColor(.white)
                            })
                            .padding(8)
                            .background(.blue)
                            .cornerRadius(15)
                            .compositingGroup()
                            .shadow(color: .gray, radius: 3, x: 1, y: 1)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $ideaDetailVM.isStoryCreateSheet) {
                StoryCreateView(ideaId: idea.id)
                    .environmentObject(StoryCreateViewModel())
            }
            .fullScreenCover(isPresented: $ideaDetailVM.isCharaCreate) {
                CharacterCreateView(
                    storyCharaId: ideaDetailVM.chara.id,
                    ideaId: ideaDetailVM.idea.id,
                    storyId: ideaDetailVM.idea.getStoryId(),
                    charaName: ideaDetailVM.chara.charaName,
                    charaDesc: ideaDetailVM.chara.charaDesc
                )
                    .environmentObject(CharacterCreateViewModel())
            }
            .sheet(isPresented: $ideaCreateVM.isIdeaUpdateSheet) {
                IdeaCreateView(comp: {
                    ideaDetailVM.getDetail(ideaId: idea.id)
                    ideaCreateVM.closeIdeaUpdateSheet()
                })
                .environmentObject(IdeaCreateViewModel(body: ideaDetailVM.idea.body, ideaId: ideaDetailVM.idea.id))
            }
            .sheet(isPresented: $ideaDetailVM.isStoryBodySheet) {
                StoryBodyUpdateView()
                    .environmentObject(
                        StoryBodyUpdateViewModel(
                            text: ideaDetailVM.idea.getStoryBody(),
                            ideaId: ideaDetailVM.idea.id,
                            storyId: ideaDetailVM.idea.getStoryId()
                        )
                    )
            }
            .alert(isPresented: $ideaDetailVM.isCharaDetail) {
                Alert(
                    title: Text(ideaDetailVM.chara.charaName),
                    message: Text(ideaDetailVM.chara.charaDesc)
                        .fontWeight(.bold),
                    primaryButton: .cancel(Text("キャンセル"), action: {
                        ideaDetailVM.closeCharaDetail()
                    }),
                    secondaryButton: .destructive(Text("編集"), action: {
                        ideaDetailVM.openUpdateCharaSheet()
                    })
                )
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.left")
                    })
                }
            }
            .onAppear {
                ideaDetailVM.getDetail(ideaId: idea.id)
            }
        }
    }
}

struct IdeaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IdeaDetailView(idea: IdeaSearchResponse())
    }
}
