//
//  ScheduleMainView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/10/25.
//

import SwiftUI

struct ScheduleMainView: View {
    @EnvironmentObject var scheduleMainViewModel: ScheduleMainViewModel
    @EnvironmentObject var storeVM: StoreViewModel
    @State var tabBarOffset: CGFloat = 0
    @Namespace var animation
    
    @Environment(\.colorScheme) var colorScheme
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollViewReader { reader in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if storeVM.isShceduleFeatureParchase {
                        VStack {
                            HStack {
                                Button(action: {
                                    withAnimation{
                                        scheduleMainViewModel.changeCalendar()
                                    }
                                }, label: {
                                    Text(scheduleMainViewModel.isCalendarShow ? "カレンダーを閉じる" : "カレンダーを開く")
                                })
                                Spacer()
                            }
                            .background(colorScheme == .dark ? Color.black : Color.white)
                            
                            if scheduleMainViewModel.isCalendarShow {
                                CalendarView(change: { date in
                                    withAnimation {
                                        reader.scrollTo(Int(date.toString(format: "yyyyMMdd")))
                                    }
                                })
                                .transition(.scale)
                            }
                            // 日付のタブ
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack (alignment: .top, spacing: 8.0){
                                    ForEach(scheduleMainViewModel.date.getDaysForMonth(), id: \.self) { date in
                                        if Calendar.current.isDate(date, equalTo: scheduleMainViewModel.date, toGranularity: .month) {
                                            Button(action: {
                                                withAnimation {
                                                    scheduleMainViewModel.date = date
                                                    reader.scrollTo(Int(scheduleMainViewModel.date.toString(format: "yyyyMMdd")))
                                                }
                                            }, label: {
                                                LazyVStack {
                                                    Text(date.toString(format: "M月d日"))
                                                        .foregroundColor(scheduleMainViewModel.isSelectedDate(listDate: date) ? .blue : .gray)
                                                    if scheduleMainViewModel.isSelectedDate(listDate: date) {
                                                        Capsule()
                                                            .fill(Color.blue)
                                                            .frame(height: 1.2)
                                                            .matchedGeometryEffect(id: "TAB", in: animation)
                                                        
                                                    } else {
                                                        Capsule()
                                                            .fill(Color.clear)
                                                            .frame(height: 1.2)
                                                        
                                                    }
                                                    
                                                }
                                            }).id(Int(date.toString(format: "yyyyMMdd")))
                                            
                                        }
                                    }
                                    
                                }
                            }
                            .background(colorScheme == .dark ? Color.black : Color.white)
                            .offset(y: tabBarOffset < 50 ? -tabBarOffset + 50 : 0)
                            .overlay(
                                GeometryReader{reader -> Color in
                                    let minY = reader.frame(in: .global).minY
                                    DispatchQueue.main.async {
                                        tabBarOffset = minY
                                    }
                                    return Color.clear
                                }
                            )
                            
                        }
                        .zIndex(1)
                        .background(colorScheme == .dark ? Color.black : Color.white)
                        
                    } else {
                        Button(action: {
                            scheduleMainViewModel.openStoreSheet()
                        }, label: {
                            Text("予定機能をレベルアップする")
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.blue, lineWidth: 3)
                                )
                        })
                        .padding(16)
                        .zIndex(1)
                        Text("\(scheduleMainViewModel.date.toString(format: "本日の予定"))")
                            .fontWeight(.bold)
                    }
                    if scheduleMainViewModel.duringProcessList.count == 0 {
                        Text("\(scheduleMainViewModel.date.toString(format: "yyyy年M月d日"))の予定はありません。")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    LazyVGrid(columns: columns) {
                        ForEach(scheduleMainViewModel.duringProcessList) { item in
                            DurirngProcessItem(duringProcess: item)
                        }
                    }
                    .transition(.slide)
                    .zIndex(0)
                }
                Spacer()
            }
            .onAppear{
                reader.scrollTo(Int(scheduleMainViewModel.date.toString(format: "yyyyMMdd")))
                scheduleMainViewModel.getScheduleData()
            }
            .gesture(DragGesture()
                .onEnded({ value in
                    if !storeVM.isShceduleFeatureParchase {
                        return
                    }
                    if value.translation.width < 0 {
                        withAnimation {
                            scheduleMainViewModel.date = Calendar.current.date(byAdding: .day, value: 1, to: scheduleMainViewModel.date)!
                            reader.scrollTo(Int(scheduleMainViewModel.date.toString(format: "yyyyMMdd")))
                        }
                    } else if value.translation.width > 0 {
                        withAnimation {
                            scheduleMainViewModel.date = Calendar.current.date(byAdding: .day, value: -1, to: scheduleMainViewModel.date)!
                            reader.scrollTo(Int(scheduleMainViewModel.date.toString(format: "yyyyMMdd")))
                        }
                    }
                }))
            .sheet(isPresented: $scheduleMainViewModel.isGoalDetail) {
                let during = scheduleMainViewModel.duringProcess
                GoalDetailView(
                    goalId: during.goalId,
                    createDate: during.goalCreateDate,
                    archiveId: during.getArchiveId(),
                    archiveCreateDate: during.getArchiveCreateDate(),
                    duringProcessId: during.processId
                )
            }
            .sheet(isPresented: $scheduleMainViewModel.isStoreSheet) {
                StoreView(productId: "ScheduleFeature", onPurchased: {
                    scheduleMainViewModel.getScheduleData()
                    scheduleMainViewModel.closeStoreSheet()
                })
            }
        }
    }
}

struct CalendarView: View {
    @EnvironmentObject var scheduleMainViewModel: ScheduleMainViewModel
    var change: (Date) -> Void = {_ in }
    
    init(change: @escaping (Date) -> Void) {
        self.change = change
    }
    
    var body: some View {
        VStack {
            DatePicker("",
                       selection: $scheduleMainViewModel.date,
                       displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .onChange(of: scheduleMainViewModel.date, perform: { value in
                change(value)
            })
        }
        
    }
}

struct ScheduleMainView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ScheduleMainView(animation: _namespace)
    }
}
