//
//  AccountUploadImageRequest.swift
//  daiku-app-ios
//
//  Created by 木村猛 on 2022/09/04.
//

import Foundation

struct AccountUploadImageRequest: Encodable {
    var imagePath: String
    var imageType: String
}
