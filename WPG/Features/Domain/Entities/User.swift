//
//  User+CoreDataClass.swift
//  WPG
//
//  Created by Jordy Gonzalez on 23/05/21.
//
//

import CoreData

public class User: NSManagedObject {
    @NSManaged public var id: String?
    @NSManaged public var portfolioUrl: String?
    @NSManaged public var profileImage: Data?
    @NSManaged public var profileImageUrl: String?
    @NSManaged public var shouldReloadImage: Bool
    @NSManaged public var totalPhotos: Int32
    @NSManaged public var userName: String?
}

extension User: UserProtocol {
    func getId() -> String {
        return self.id ?? ""
    }
    
    func getUserName() -> String {
        return self.userName ?? ""
    }
    
    func getName() -> String {
        return ""
    }
    
    func getProfileImageUrl() -> String {
        return self.profileImageUrl ?? ""
    }
    
    func getPortfolioUrl() -> String {
        return self.portfolioUrl ?? ""
    }
    
    func getTotalPhotos() -> Int {
        return Int(self.totalPhotos)
    }
    
    func getProfileImage() -> Data? {
        return self.profileImage
    }
    
    func isFavorite() -> Bool {
        return true
    }
}
