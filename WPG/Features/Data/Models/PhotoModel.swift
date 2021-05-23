//
//  ImageModel.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

struct PhotoModel: Decodable {
    let id: String
    let width: Int
    let height: Int
    let color: String
    let blurHash: String
    let likes: Int
    let urls: UrlModel
    let user: UserModel
    
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case color
        case blurHash = "blur_hash"
        case likes
        case urls
        case user
    }
}

extension PhotoModel: PhotoProtocol {
    func getId() -> String {
        return self.id
    }
    
    func getLikes() -> Int {
        return self.likes
    }
    
    func getWidth() -> Int {
        return self.width
    }
    
    func getHeight() -> Int {
        return self.height
    }
    
    func getImageUrl() -> String {
        return self.urls.full
    }
    
    func getImage() -> Data? {
        return nil
    }
    
    func getUser() -> UserProtocol {
        return self.user
    }
    
    func isFavorite() -> Bool {
        return false
    }
}
