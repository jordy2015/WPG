//
//  UserModel.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

struct UserModel: Decodable {
    let id: String
    let userName: String
    let name: String
    let profileImage: ProfileImageModel
    let portfolioUrl: String
    let totalPhotos: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "username"
        case name
        case portfolioUrl = "portfolio_url"
        case profileImage = "profile_image"
        case totalPhotos = "total_photos"
    }
}
