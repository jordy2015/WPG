//
//  FavoritesLocalDataSource.swift
//  WPG
//
//  Created by Jordy Gonzalez on 23/05/21.
//

import Foundation

protocol FavoritesLocalDataSource {
    func getPhotos(completitionHandler: @escaping(_ response: [PhotoProtocol]?, _ error: Error?) -> Void)
}

class FavoritesLocalDataSourceImpl: FavoritesLocalDataSource {
    
    let database: DatabaseHandler
    
    init(database: DatabaseHandler) {
        self.database = database
    }
    
    func getPhotos(completitionHandler: @escaping ([PhotoProtocol]?, Error?) -> Void) {
        let photos = database.fetch(Photo.self)
        completitionHandler(photos as [PhotoProtocol], nil)
    }
}

