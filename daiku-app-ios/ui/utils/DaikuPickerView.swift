//
//  DaikuPickerView.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/07/06.
//

import SwiftUI

struct ProcessStatusPickerView: View {
    var pickerTitle: String = ""
    @State var selectedValue: ProcessStatus = .New
    
    init(title: String) {
        pickerTitle = title
    }
    
    var body: some View {
        Text("test")
    }
}
