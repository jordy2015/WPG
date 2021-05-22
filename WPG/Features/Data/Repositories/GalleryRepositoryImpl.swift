//
//  GalleryRepositoryImpl.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

class GalleryRepositoryImpl: GalleryRepository {
    
    let httpConnection: ApiClient
    let remoteDataSource: GalleryRemoteDataSource
    
    init(httpConnection: ApiClient, remote: GalleryRemoteDataSource) {
        self.httpConnection = httpConnection
        self.remoteDataSource = remote
    }
    
    func getPhotos(inPage: Int, completitionHandler: @escaping ([PhotoProtocol]?, Error?) -> Void) {
        if httpConnection.hasConnection() {
            remoteDataSource.getPhotos(inPage: inPage) { (photosList, error) in
                guard let photos = photosList else {
                    completitionHandler(nil, nil)
                    return
                }
                completitionHandler(photos, nil)
            }
        } else {
            
        }
    }
}
