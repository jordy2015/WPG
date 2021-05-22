//
//  DI.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

class DI {
    static let `factory` = DI()
    
    func getGalleryRepository() -> GalleryRepository {
        return GalleryRepositoryImpl(httpConnection: ApiClient.default, remote: DI.factory.getGalleryRomoteDataSource())
    }
    
    func getGalleryRomoteDataSource() -> GalleryRemoteDataSource {
        return GalleryRemoteDataSourceImpl(apiClient: ApiClient.default)
    }
}
