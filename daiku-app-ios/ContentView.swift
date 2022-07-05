//
//  ContentView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/06/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AccountExistView()
            .environmentObject(AccountExistViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
