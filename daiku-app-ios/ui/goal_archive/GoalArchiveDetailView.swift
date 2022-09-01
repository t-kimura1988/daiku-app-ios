//
//  GoalArchiveDetailView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/16.
//

import SwiftUI

struct GoalArchiveDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var goalArchiveDetailVM: GoalArchiveDetailViewModel
    @EnvironmentObject var accountVM: AccountExistViewModel
    @State var tabBarOffset: CGFloat = 0
    @Namespace var animation
    
    private var archiveId: Int = 0
    private var archiveCreateDate: String = ""
    private var goalCreateAccountId: Int = 0
    
    init(archiveId: Int, archiveCreateDate: String, goalCreateAccountId: Int = 0) {
        self.archiveId = archiveId
        self.archiveCreateDate = archiveCreateDate
        self.goalCreateAccountId = goalCreateAccountId
    }
    
    var body: some View {
        let archive = goalArchiveDetailVM.archive
        let goal = goalArchiveDetailVM.goal
        let processList = goalArchiveDetailVM.processList
        ScrollView {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    MoreText(text: archive.thoughts)
                    HStack {
                        Spacer()
                        Text(archive.accountName())
                            .foregroundColor(.gray)
                    }
                    
                    if goalArchiveDetailVM.isEditButton {
                        
                        Button(action: {
                            goalArchiveDetailVM.changeArchiveEditSheet()
                        }, label: {
                            Text("編集")
                        })
                        .frame(width:80)
                        .foregroundColor(.yellow)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.yellow, lineWidth: 1))
                    }
                }
                Spacer()
            }
            Divider()
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(goal.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("なぜ.")
                        .font(.title2)
                    Text(goal.purpose)
                        .font(.body)
                        .padding(8)
                    Text("どのように実現するか.")
                        .font(.title2)
                    Text(goal.aim)
                        .font(.body)
                        .padding(8)
                    HStack {
                        Spacer()
                        Text(goal.accountName())
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
            }
            Divider()
            // tab button
            VStack(spacing: 0) {
                HStack (spacing: 0) {
                    ForEach(ProcessTabTitle.allCases) { title in
                        ProcessTabButton(title: title.rawValue, currentTab: $goalArchiveDetailVM.currentTab, animation: animation)
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
            .zIndex(1)
            
            // tab content
            switch goalArchiveDetailVM.tab() {
            case .Process:
                if processList.count > 0 {
                    ForEach(processList) { process in
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(process.title)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                MoreText(text: process.body)
                            }
                            Spacer()
                        }
                        Divider()
                    }
                } else {
                    HStack {
                        Text("こちらの工程は公開されていません。")
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(Text("詳細"))
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                })
            }
        }
        .onAppear{
            goalArchiveDetailVM.initItem(archiveId: archiveId, archiveCreateDate: archiveCreateDate, goalCreateAccountId: goalCreateAccountId)
            
            goalArchiveDetailVM.detail(accountId: accountVM.account.id)
        }
        .fullScreenCover(isPresented: $goalArchiveDetailVM.isEditSheet) {
            GoalArchiveEditView(
                closeSheet: {
                    goalArchiveDetailVM.detail()
                    goalArchiveDetailVM.changeArchiveEditSheet()
                },
                goalId: archive.goalId,
                createDate: archive.goalCreateDate,
                archiveId: archiveId,
                archiveCreateDate: archiveCreateDate,
                thoughts: archive.thoughts,
                published: archive.getPublish())
            .environmentObject(GoalArchiveEditViewModel())
        }
    }
}

struct GoalArchiveDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalArchiveDetailView(archiveId: 0, archiveCreateDate: "2022/1/1")
    }
}


private struct ProcessTabButton: View {
    
    var title: String
    @Binding var currentTab: String
    var animation: Namespace.ID
    
    var body: some View {
        
        Button(action: {
            withAnimation{
                currentTab = title
            }
        }, label: {
            LazyVStack(spacing: 12) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(currentTab == title ? .blue : .gray)
                    .padding(.horizontal)
                
                if currentTab == title {
                    Capsule()
                        .fill(Color.blue)
                        .frame(height: 1.2)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                }else {
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 1.2)
                    
                }
            }
        })
    }
}
