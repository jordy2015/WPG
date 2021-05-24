//
//  UserProtocol.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

protocol UserProtocol {
    func getId() -> String
    func getUserName() -> String
    func getName() -> String
    func getProfileImageUrl() -> String
    func getPortfolioUrl() -> String
    func getTotalPhotos() -> Int
    func getProfileImage() -> Data?
    func isFavorite() -> Bool
}
