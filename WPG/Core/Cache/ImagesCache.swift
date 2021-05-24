//
//  ImagesCache.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

class ImagesCache {
    
    static let `default` = ImagesCache()
    let maxPhotosCache: Int = 100
    let maxProfileImagesCache: Int = 300
    private var photos: [String : Data] = [:]
    private var profileImages: [String : Data] = [:]
    
    func set(key: String, photo: Data?) {
        guard let data = photo else { return }
        if photos.count >= maxPhotosCache {
            photos.removeAll()
        }
        photos[key] = data
    }
    
    func set(key: String, profileImage: Data?) {
        guard let data = profileImage else { return }
        if profileImages.count >= maxProfileImagesCache {
            profileImages.removeAll()
        }
        profileImages[key] = data
    }
    
    func getPhoto(key: String) -> Data? {
        return photos[key]
    }
    
    func getprofileImage(key: String) -> Data? {
        return profileImages[key]
    }
}
