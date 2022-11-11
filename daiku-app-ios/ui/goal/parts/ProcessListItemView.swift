//
//  ProcessListItemView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/20.
//

import SwiftUI

struct ProcessListItemView: View {
    @EnvironmentObject var goalDetailVM: GoalDetailViewModel
    private var process: ProcessResponse = ProcessResponse()
    private var duringProcessId: Int = 0
    
    init(process: ProcessResponse, duringProcessId: Int = 0) {
        self.process = process
        self.duringProcessId = duringProcessId
    }
    
    var body: some View {
        
        NavigationLink{
            ProcessDetailView(
                processId: process.id,
                goalCreateDate: process.goalCreateDate,
                goalId: process.goalId
            )
        } label: {
            LazyVStack(alignment: .leading, spacing: 8) {
                
                Text(process.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 8) {
                    Text("\(process.startDisp()) 〜 \(process.endDisp()) ")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    if process.endDate().compare(goalDetailVM.goalDetail.dueDateToDate()) == .orderedDescending {
                        Text("遅")
                            .fontWeight(.bold)
                            .padding(8)
                            .background(.red)
                            .cornerRadius(15)
                            .compositingGroup()
                            .shadow(color: .gray, radius: 3, x: 1, y: 1)
                        
                    }
                    
                }
                HStack(spacing: 8) {
                    Text(process.statusToEnum().title)
                        .fontWeight(.bold)
                        .padding(8)
                        .background(process.statusToEnum().backColor())
                        .cornerRadius(15)
                        .compositingGroup()
                        .shadow(color: .gray, radius: 3, x: 1, y: 1)
                    Text(process.priorityToEnum().title)
                        .fontWeight(.bold)
                        .padding(8)
                        .background(process.priorityToEnum().backColor())
                        .cornerRadius(15)
                        .compositingGroup()
                        .shadow(color: .gray, radius: 3, x: 1, y: 1)
                    Spacer()
                }
                .padding(.leading, 8)
                HStack {
                    
                    Text(process.body)
                        .font(.body)
                        .padding(.leading, 16)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Divider()
            }
            .contentShape(Rectangle())
            .foregroundColor(.primary)
            .background(process.id == duringProcessId ? .yellow : .white)
            
        }
        .background(.primary)
    }
}

struct ProcessListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessListItemView(process: ProcessResponse())
    }
}
