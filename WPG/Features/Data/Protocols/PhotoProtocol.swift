//
//  PhotoProtocol.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

protocol PhotoProtocol {
    func getId() -> String
    func getLikes() -> Int
    func getWidth() -> Int
    func getHeight() -> Int
    func getImageUrl() -> String
    func getImage() -> Data?
    func getUser() -> UserProtocol
    func isFavorite() -> Bool
    func save(in database: DatabaseHandler) 
}
