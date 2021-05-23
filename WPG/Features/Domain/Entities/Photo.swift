//
//  Photo+CoreDataClass.swift
//  WPG
//
//  Created by Jordy Gonzalez on 23/05/21.
//
//

import CoreData

public class Photo: NSManagedObject {
    @NSManaged public var height: Int32
    @NSManaged public var id: String?
    @NSManaged public var image: Data?
    @NSManaged public var imageUrl: String?
    @NSManaged public var likes: Int32
    @NSManaged public var width: Int32
    @NSManaged public var user: User?
    @NSManaged public var shouldReloadImage: Bool
}

extension Photo: PhotoProtocol {
    func getId() -> String {
        return self.id ?? ""
    }
    
    func getLikes() -> Int {
        return Int(self.likes)
    }
    
    func getWidth() -> Int {
        return Int(self.width)
    }
    
    func getHeight() -> Int {
        return Int(self.height)
    }
    
    func getImageUrl() -> String {
        return self.imageUrl ?? ""
    }
    
    func getImage() -> Data? {
        return self.image
    }
    
    func getUser() -> UserProtocol {
        return self.user! as UserProtocol
    }
    
    func isFavorite(search database: DatabaseHandler) -> Bool {
        return true
    }
    
    func save(in database: DatabaseHandler) {
        
    }
}
