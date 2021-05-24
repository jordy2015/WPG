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
        return GalleryRepositoryImpl(httpConnection: ApiClient.default, remote: DI.factory.getGalleryRomoteDataSource(), local: DI.factory.getFavoritesLocalDataSource())
    }
    
    func getGalleryRomoteDataSource() -> GalleryRemoteDataSource {
        return GalleryRemoteDataSourceImpl(apiClient: ApiClient.default)
    }
    
    func getFavoritesLocalDataSource() -> FavoritesLocalDataSource {
        return FavoritesLocalDataSourceImpl(database: DI.factory.getDatabaseHandler())
    }
    
    func getPhotosUseCase() -> GetPhotos {
        return GetPhotos(repository: DI.factory.getGalleryRepository())
    }
    
    func getFavoritesUseCase() -> GetFavorites {
        return GetFavorites(local: DI.factory.getFavoritesLocalDataSource())
    }
    
    func getDatabaseHandler() -> DatabaseHandler {
        return DatabaseHandler()
    }
    
    func getImageCache() -> ImagesCache {
        return ImagesCache.default
    }
}
