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
                    print("REFRESH!!!")
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
                                Color(.green)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        width: getRect().width,
                                        height: minY > 0 ? 180 + minY: 180,
                                        alignment: .center)
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
                            Image("samurai")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(8)
                                .background(colorScheme == .dark ? Color.black : Color.white)
                                .clipShape(Circle())
                                .offset(y: offset < 0 ? getOffset() - 20 : -20)
                                .scaleEffect(getScale())
                            
                            Spacer()
                            Button(action: {}, label: {
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
                        HStack (spacing: 0) {
                            ForEach(TabButtonTitle.allCases) { title in
                                TabButton(title: title.rawValue, currentTab: $accountMainVm.currentTab, animation: animation)
                            }
                        }
                        Divider()
                    }
                    .padding(.top, 30)
                    .background(Color.white)
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
                
                    // Goal List
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(accountMainVm.myGoal) { item in
                            NavigationLink{
                                GoalDetailView(goalId: item.id, createDate: item.createDate)
//                                    .environmentObject(GoalDetailViewModel())
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.title)
                                            .font(.title)
                                            .lineLimit(1)
                                            .foregroundColor(.primary)
                                        HStack {
                                            (
                                                Text("期日:\(item.dueDateFormat())")
                                                    .foregroundColor(Color.gray)
                                            )
                                        }
                                        Text(item.purpose)
                                            .font(.body)
                                            .lineLimit(3)
                                            .padding(.top, 8)
                                            .foregroundColor(.primary)
                                    }
                                    .padding(8)
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                            }
                            
                            
                            VStack(alignment: .center, spacing: 0) {
                                FavoriteButton(goal: item, changeFavorite: { goalId, createDate in
                                    
                                    accountMainVm.changeGoalFavorite(request: .init(goalId: goalId, goalCreateDate: createDate)) {
                                        
                                    }
                                })
                            }.padding(.top, 10)
                            
                            Divider()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .zIndex(0)
                }
            }
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarHidden(true)
        }
        .onAppear{
            accountMainVm.onApperLoadData()
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
