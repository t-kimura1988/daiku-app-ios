//
//  AccountMainView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/18.
//

import SwiftUI
import AVFoundation

struct AccountMainView: View {
    @EnvironmentObject var accountMainVm: AccountMainViewModel
    @EnvironmentObject var accountExistVM: AccountExistViewModel
    @State var offset: CGFloat = 0
    @State var tabBarOffset: CGFloat = 0
    @State var titleOffet: CGFloat = 0
    
    @Environment(\.colorScheme) var colorScheme
    @Namespace var animation
    
    private var goalRouter: GoalRouter = GoalRouter()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                RefreshView(coodinateSpaceName: "RefreshView", onRefresh: {
                    accountMainVm.onApperLoadData()
                })
                VStack(spacing: 15) {
                    // header
                    GeometryReader{ proxy -> AnyView in
                        
                        let minY = proxy.frame(in: .global).minY
                        DispatchQueue.main.async {
                            offset = minY
                        }
                        return AnyView (
                            ZStack {
                                
                                UserImageView(userImage: accountMainVm.account.getProfileBackImage(), placeholderType: .color)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        width: getRect().width,
                                        height: minY > 0 ? 180 + minY: 180,
                                        alignment: .center)
                                    .overlay{
                                        Image(systemName: "camera.viewfinder")
                                        .resizable()
                                        .frame(width: 40, height: 40, alignment: .bottomLeading)
                                        .padding(8)
                                        .clipShape(Circle())
                                        .offset(y: offset < 0 ? getOffset() - 5 : -5)
                                        .scaleEffect(getScale())
                                        .opacity(0.5)
                                        .onTapGesture {
                                            accountMainVm.openProfileBackImagePreView()
                                        }
                                }
                                .cornerRadius(0)
                                
                                BlurView()
                                    .opacity(blurViewOpacity())
                                
                                // Titlte
                                VStack(spacing: 5) {
                                    Text(accountMainVm.account.accountName())
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                }
                                .offset(y: 120)
                                .offset(y: titleOffet > 80 ? 0 : -getTitleOffset())
                                .opacity(titleOffet < 80 ? 1 : 0)
                            }
                            .frame(height: minY > 0 ? 180 + minY: nil)
                            .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                            
                        )
                    }
                    .frame(height: 180)
                    .zIndex(1)
                    
                    // account profile
                    VStack {
                        HStack{
                            UserImageView(userImage: accountMainVm.account.getUserImage(), placeholderType: .samurai)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .background(colorScheme == .dark ? Color.black : Color.white)
                                .clipShape(Circle())
                                .offset(y: offset < 0 ? getOffset() - 20 : -20)
                                .scaleEffect(getScale())
                                .overlay{
                                    Image(systemName: "camera.viewfinder")
                                        .resizable()
                                        .frame(width: 40, height: 40, alignment: .bottom)
                                        .padding(8)
                                        .clipShape(Circle())
                                        .offset(y: offset < 0 ? getOffset() - 5 : -5)
                                        .scaleEffect(getScale())
                                        .opacity(0.5)
                                }
                                .onTapGesture{
                                    accountMainVm.openAccountMainImagePreView()
                                }
                            
                            Spacer()
                            Button(action: {
                                accountMainVm.changeUpdateAccount()
                            }, label: {
                                Text("編集")
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(
                                        Capsule()
                                            .stroke(Color.blue, lineWidth: 1.5)
                                    )
                            })
                        }
                        .padding(.top, -25)
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(accountMainVm.account.accountName())
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text(accountMainVm.account.nickName)
                                    .foregroundColor(.gray)
                                
                                Button(action: {
                                    accountExistVM.logout()
                                }, label: {
                                    Text("ログアウト")
                                        .padding(.vertical, 10)
                                        .padding(.horizontal)
                                        .background(
                                            Capsule()
                                                .stroke(Color.blue, lineWidth: 1.5)
                                        )
                                })
                                
                            }
                            Spacer()
                        }.overlay(
                            GeometryReader {proxy -> Color in
                                let minY = proxy.frame(in: .global).minY
                                DispatchQueue.main.async {
                                    titleOffet = minY
                                }
                                return Color.clear
                            }
                            .frame(width: 0, height: 0)
                            
                            ,alignment: .top
                        )
                    }
                    .padding(.horizontal)
                    .zIndex(-offset > 80 ? 0 : 1)
                    
                    // tab button
                    VStack(spacing: 0) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 0) {
                                ForEach(TabButtonTitle.allCases) { title in
                                    TabButton(title: title.rawValue, currentTab: $accountMainVm.currentTab, animation: animation)
                                }
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
                
                    if accountMainVm.currentTab == TabButtonTitle.MyGoal.rawValue {
                        // Goal List
                        
                        Button(action: {
                            withAnimation{
                                accountMainVm.changeGoalSearchInputSheet()
                            }
                        }, label: {
                            Text("目標の絞り込み")
                        })
                        if accountMainVm.isGoalSearchInputSheet {
                            GoalSearchInputView()
                                .transition(.identity)
                                .environmentObject(GoalSearchInputViewModel())
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(accountMainVm.myGoal) { item in
                                GoalListParts(item: item) {
                                    accountMainVm.tapGoalItem(item: item)
                                }
                            }
                        }
                        .onAppear{
                            if !accountMainVm.isGoalListLoading {
                                accountMainVm.getInitMyGoal()
                            }
                        }
                        
                    }
                    else if accountMainVm.currentTab == TabButtonTitle.Archive.rawValue{
                        Button(action: {
                            withAnimation {
                                accountMainVm.changeGoalArchiveSearchInputSheet()
                            }
                        }, label: {
                            Text("達成の絞り込み")
                        })
                        if accountMainVm.isGoalArchiveSearchInputSheet {
                            GoalArchiveSearchInputView()
                                .transition(.identity)
                        }
                        // goal archive list
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(accountMainVm.myGoalArchiveList) { item in
                                NavigationLink{
                                    GoalArchiveDetailView(archiveId: item.id, archiveCreateDate: item.archivesCreateDate, goalCreateAccountId: item.goalCreateAccountId)
                                } label: {
                                    GoalArchiveListParts(item: item)
                                }
                                
                                Divider()
                                    .frame(maxWidth: .infinity)
                            }
                            if accountMainVm.goalArvhiveListLoadFlg {
                                Button(action: {
                                    accountMainVm.getMyGoalArchive()
                                }, label: {
                                    Text("もっと見る")
                                })
                            }
                        }
                        .zIndex(0)
                        .onAppear{
                            if !accountMainVm.isGoalArchiveListLoading {
                                accountMainVm.getInitMyGoalArchive()
                            }
                        }
                        
                    }
                    else if accountMainVm.currentTab == TabButtonTitle.BookMark.rawValue {
                        //Bookmark list
                        VStack(alignment: .leading, spacing: 8) {
                            
                            ForEach(accountMainVm.goalFavoriteList) { item in
                                
                                FavoriteGoalList(item: item) {
                                    accountMainVm.tapGoalItem(item: item.toGoalResponse())
                                }
                                
                                Divider()
                            }
                            if accountMainVm.bookMarkListLoadFlg {
                                Button(action: {
                                    accountMainVm.getBookMarkList()
                                }, label: {
                                    Text("もっと見る")
                                })
                            }
                        }
                        .zIndex(0)
                        .onAppear {
                            if !accountMainVm.isBookMarkListLoading {
                                accountMainVm.getInitBookMarkList()
                            }
                        }
                    }
                    else if accountMainVm.currentTab == TabButtonTitle.Maki.rawValue {
                        // 書のリスト
                        VStack(alignment: .leading) {
                            ForEach(accountMainVm.makiList) { item in
                                NavigationLink {
                                    MakiDetailView(makiId: item.id)
                                } label: {
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
                                        Text(item.makiTitle)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                        Text(item.makiKey)
                                            .foregroundColor(.gray)
                                        Text(item.makiDesc)
                                            .font(.caption)
                                            .lineLimit(3)
                                            .padding(.top, 4)
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.primary)
                                        
                                    }
                                    .padding(6)
                                }
                                Divider()
                            }
                        }
                        .zIndex(0)
                        .onAppear {
                            if !accountMainVm.isMakiListLoading {
                                accountMainVm.getInitMakiList()
                            }
                        }
                    }
                    else if accountMainVm.currentTab == TabButtonTitle.Idea.rawValue {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(accountMainVm.myIdeaList) { item in
                                IdeaListItemParts(item: item) {
                                    accountMainVm.openIdeaDetailSheet(item: item)
                                }
                            }
                            if accountMainVm.ideaListLoadFlg {
                                Button(action: {
                                    accountMainVm.getIdeaList()
                                }, label: {
                                    Text("もっと見る")
                                })
                            }
                        }
                        .onAppear{
                            if !accountMainVm.isIdeaListLoading {
                                accountMainVm.getInitIdeaList()
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        .onAppear{
            accountMainVm.onApperLoadData()
        }
        .fullScreenCover(isPresented: $accountMainVm.isUpdateAccount) {
            AccountCreateView(
                accountId: accountMainVm.account.id,
                familyName: accountMainVm.account.familyName,
                givenName: accountMainVm.account.givenName,
                nickName: accountMainVm.account.nickName,
                closeSheet: {
                    accountMainVm.onApperLoadData()
                    accountMainVm.changeUpdateAccount()
                },
                isClose: true)
                .environmentObject(AccountCreateViewModel())
        }
        .fullScreenCover(isPresented: $accountMainVm.isImagePreView) {
            ImagePreView(
                type: accountMainVm.imagePreViewScreenType,
                userImage: accountMainVm.imagePath,
                uid: accountMainVm.account.uid
            )
            .environmentObject(ImagePreViewModel())
        }
        .fullScreenCover(isPresented: $accountMainVm.isGoaDetailSheet) {
            let item = accountMainVm.goalItem
            GoalDetailView(goalId: item.id, createDate: item.createDate, archiveId: item.getArchiveId(), archiveCreateDate: item.getArchiveCreateDate())
        }
        .fullScreenCover(isPresented: $accountMainVm.isIdeaDetailSheet) {
            IdeaDetailView(idea: accountMainVm.ideaItem)
                .environmentObject(IdeaDetailViewModel())
        }
    }
    
    func getTitleOffset() -> CGFloat {
        let progress = 20 / titleOffet
        let offset = 70 * (progress > 0 && progress <= 1 ? progress : 1)
        return offset
    }
    
    func getOffset() -> CGFloat {
        let progress  = (-offset / 80) * 20
        
        return progress
    }
    
    func getScale() -> CGFloat {
        let progress = -offset / 80
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        
        return scale < 1 ? scale : 1
    }
    
    func blurViewOpacity() -> Double {
        let progress =  -(offset + 80) / 150
        
        return Double(-offset > 80 ? progress : 0)
    }
}

struct AccountMainView_Previews: PreviewProvider {
    static var previews: some View {
        AccountMainView()
            .environmentObject(AccountMainViewModel())
            .environmentObject(AccountExistViewModel())
    }
}

extension AccountMainView {
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
}


struct TabButton: View {
    
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

struct FavoriteButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    var goal: GoalResponse = GoalResponse()
    
    @State var isFavorite: Bool = false
    
    var changeFavorite: (Int, String) -> Void
    
    init(goal: GoalResponse, changeFavorite: @escaping (Int, String) -> Void) {
        self.goal = goal
        self.changeFavorite = changeFavorite
        _isFavorite = State(initialValue: goal.isFavorite())
    }
    
    var body: some View {
        HStack(spacing: 0) {
            LazyVStack {
                Button(action: {
                    isFavorite = !isFavorite
                    changeFavorite(goal.id, goal.createDate)
                }, label: {
                    Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18)
                        .padding(8)
                        .background(colorScheme == .dark ? Color.black : Color.white)
                        .foregroundColor(.red)
                })
            }
        }
    }
}
