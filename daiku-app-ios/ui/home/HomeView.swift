//
//  HomeView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: HomeMainViewModel
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                HomeRefreshView(coodinateSpaceName: "RefreshView", onRefresh: {
                    vm.getInitHomeList()
                })
                ForEach(vm.homeList) { item in
                    NavigationLink {
                        GoalArchiveDetailView(archiveId: item.id, archiveCreateDate: item.archivesCreateDate)
                    } label: {
                        LazyVStack(alignment: .leading, spacing: 8) {
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.thoughts)
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(3)
                                        .padding(.top, 1)
                                        .foregroundColor(.primary)
                                        .multilineTextAlignment(.leading)
                                    Text("【目標】\(item.title)")
                                        .font(.body)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(3)
                                        .padding(.top, 1)
                                        .foregroundColor(.primary)
                                        .multilineTextAlignment(.leading)
                                    if item.getPublish() == .All {
                                        Text("プロセス数:\(item.processCount)")
                                            .font(.body)
                                            .foregroundColor(.gray)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .lineLimit(3)
                                            .padding(.top, 1)
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.leading)
                                        
                                    }
                                }
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .padding()
                            
                            
                            VStack(alignment: .trailing) {
                                HStack {
                                    Text(item.accountName())
                                        .foregroundColor(.gray)
                                }
                            }.frame(maxWidth: .infinity, alignment: .trailing)
                                .padding()
                        }
                    }
                    Divider()
                }
                
                if vm.homeListLoadFlg {
                    Button(action: {
                        vm.getHomeList()
                    }, label: {
                        Text("もっと見る")
                    })
                }
            }
            .onAppear {
                
                if !vm.isHomeListLoading {
                    vm.getInitHomeList()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {vm.createGoalSheet()}, label: {Text("目標作成")})
                }
            }
            .fullScreenCover(isPresented: $vm.isSheet) {
                GoalCreateView()
                    .environmentObject(GoalCreateViewModel())
            }
            .navigationTitle("みんなの目標")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

fileprivate struct HomeRefreshView: View {
    @State private var isRefreshing = false
    var coodinateSpaceName: String
    var onRefresh: () -> Void
    
    var body: some View {
        GeometryReader{geometory  in
            let midY = geometory.frame(in: .named(coodinateSpaceName)).midY
            let maxY = geometory.frame(in: .named(coodinateSpaceName)).maxY
            if midY > 148 {
                Spacer()
                    .onAppear{
                        isRefreshing = true
                    }
            }else if maxY < 116 {
                Spacer()
                    .onAppear {
                        if isRefreshing {
                            isRefreshing = false
                            onRefresh()
                        }
                    }
            }
            
            HStack {
                Spacer()
                if isRefreshing {
                    ProgressView()
                } else {
                    if midY > 116 {
                        Text("⬇︎")
                            .font(.system(size: 28))
                        
                    }
                }
                Spacer()
            }
            
        }
    }
}
