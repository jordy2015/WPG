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
    let portfolioUrl: String?
    let totalPhotos: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "username"
        case name
        case profileImage = "profile_image"
        case portfolioUrl = "portfolio_url"
        case totalPhotos = "total_photos"
    }
}

extension UserModel: UserProtocol {
    func getName() -> String {
        return self.name
    }
    
    func getId() -> String {
        return self.id
    }
    
    func getUserName() -> String {
        return self.userName
    }
    
    func getProfileImageUrl() -> String {
        return self.profileImage.medium
    }
    
    func getPortfolioUrl() -> String {
        return self.portfolioUrl ?? "None"
    }
    
    func getTotalPhotos() -> Int {
        return self.totalPhotos
    }
    
    func getProfileImage() -> Data? {
        return nil
    }
    
    func isFavorite() -> Bool {
        return false
    }
}
