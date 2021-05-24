//
//  GetFavorites.swift
//  WPG
//
//  Created by Jordy Gonzalez on 23/05/21.
//

import Foundation

class GetFavorites {
    let localDataSource: FavoritesLocalDataSource
    
    init(local: FavoritesLocalDataSource) {
        self.localDataSource = local
    }
    
    func call(completitionHandler: @escaping ([PhotoProtocol]?, Error?) -> Void) {
        localDataSource.getPhotos(completitionHandler: completitionHandler)
    }
}
