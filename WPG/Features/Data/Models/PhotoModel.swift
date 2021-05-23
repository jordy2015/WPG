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
    func save(in database: DatabaseHandler) {
        guard let userEntity = database.add(User.self) else { return }
        guard let photoEntity = database.add(Photo.self) else { return }
        
        userEntity.id = getUser().getId()
        userEntity.portfolioUrl = getUser().getPortfolioUrl()
        userEntity.profileImage = nil
        userEntity.profileImageUrl = getUser().getProfileImageUrl()
        userEntity.shouldReloadImage = true
        userEntity.totalPhotos = Int32(getUser().getTotalPhotos())
        userEntity.userName = getUser().getUserName()
        userEntity.name = getUser().getName()
        
        photoEntity.height = Int32(getHeight())
        photoEntity.id = getId()
        photoEntity.image = nil
        photoEntity.imageUrl = getImageUrl()
        photoEntity.likes = Int32(getLikes())
        photoEntity.width = Int32(getWidth())
        photoEntity.shouldReloadImage = true
        photoEntity.user = userEntity
        
        database.save()
    }
    
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
    
    func isFavorite(search database: DatabaseHandler) -> Bool {
        return database.searchPhoto(with: self.getId()) != nil ? true : false
    }
}
