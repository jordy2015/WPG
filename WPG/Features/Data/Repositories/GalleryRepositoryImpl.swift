//
//  GalleryRepositoryImpl.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

class GalleryRepositoryImpl: GalleryRepository {
    
    let httpConnection: NetworkProtocol
    let remoteDataSource: GalleryRemoteDataSource
    let localDataSource: FavoritesLocalDataSource
    
    init(httpConnection: NetworkProtocol, remote: GalleryRemoteDataSource, local: FavoritesLocalDataSource) {
        self.httpConnection = httpConnection
        self.remoteDataSource = remote
        self.localDataSource = local
    }
    
    func getPhotos(inPage: Int, completitionHandler: @escaping ([PhotoProtocol]?, Error?, Bool) -> Void) {
        if httpConnection.hasConnection() {
            remoteDataSource.getPhotos(inPage: inPage) { (photosList, error) in
                guard let photos = photosList else {
                    completitionHandler(nil, error, false)
                    return
                }
                completitionHandler(photos, nil, false)
            }
        } else {
            localDataSource.getPhotos { (photosList, error) in
                guard let photos = photosList else {
                    completitionHandler(nil, nil, true)
                    return
                }
                completitionHandler(photos, nil, true)
            }
        }
    }
}
