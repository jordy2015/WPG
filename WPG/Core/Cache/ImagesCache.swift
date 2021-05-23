//
//  ImagesCache.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

class ImagesCache {
    static private var photos: [String : Data] = [:]
    static private var profileImages: [String : Data] = [:]
    
    static func set(key: String, photo: Data) {
        photos[key] = photo
    }
    
    static func set(key: String, profileImage: Data) {
        profileImages[key] = profileImage
    }
    
    static func getPhoto(key: String) -> Data? {
        return photos[key]
    }
    
    static func getprofileImage(key: String) -> Data? {
        return profileImages[key]
    }
}
