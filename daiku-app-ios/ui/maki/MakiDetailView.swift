//
//  MakiDetailView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/15.
//

import SwiftUI

struct MakiDetailView: View {
    private var makiId: Int = 0
    @EnvironmentObject private var makiDetailVM: MakiDetailViewModel
    @Environment(\.colorScheme) var colorScheme
    
    init(makiId: Int) {
        self.makiId = makiId
    }
    
    var body: some View {
        let detail = makiDetailVM.makiDetail
        ScrollView(.vertical, showsIndicators: false) {
            
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        UserImageView(userImage: detail.getAccountImageURL(), placeholderType: .samurai)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .background(colorScheme == .dark ? Color.black : Color.white)
                            .clipShape(Circle())
                        Text("\(detail.createdAccountFamilyName) \(detail.createdAccountGivenName)")
                            .foregroundColor(.primary)
                        Spacer()
                        
                    }
                    Text(detail.makiTitle)
                        .font(.title)
                    Text(detail.makiKey)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(detail.makiDesc)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                        .padding(.top, 8)
                }
                Spacer()
            }.padding(4)
            
            MakiDetailTabView()
                .zIndex(1)
            
            switch makiDetailVM.currentTab {
            case MakiDetailTabButtonTitle.Goal.rawValue:
                
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(makiDetailVM.makiGoalList, id: \.self) { item in
                        HStack {
                            Text(item.makiSort())
                                .fontWeight(.bold)
                                .padding(4)
                            Spacer()
                            
                        }
                        .contentShape(Rectangle())
                        Divider()
                            .padding(.leading, 4)
                        GoalListParts(item: item)
                    }
                }
                .onAppear{
                    makiDetailVM.getInitMakiGoalList()
                }
            default:
                Text("ERROR")
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    makiDetailVM.openAddGoalSheet()
                }, label: {
                    Text("目標追加")
                })
            }
        }
        .onAppear{
            makiDetailVM.initItem(makiId: makiId)
            makiDetailVM.detail()
        }
        .sheet(isPresented: $makiDetailVM.isGoalAddSheet) {
            MakiAddGoalView(makiId: makiId)
                .environmentObject(MakiAddGoalViewModel())
        }
        .fullScreenCover(isPresented: $makiDetailVM.isMakiGoalCreateSheet) {
            GoalCreateView(
                makiId: makiId,
                closeSheet: {
                    makiDetailVM.closeGoalCreateSheet()
                    makiDetailVM.getMakiGoalList()
                }
            )
            .environmentObject(GoalCreateViewModel())
        }
    }
}

struct MakiDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MakiDetailView(makiId: 0)
    }
}
