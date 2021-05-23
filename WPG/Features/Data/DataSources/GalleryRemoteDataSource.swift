//
//  GalleryRemoteDataSource.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

protocol GalleryRemoteDataSource {
    func getPhotos(inPage: Int, completitionHandler: @escaping(_ response: [PhotoModel]?, _ error: Error?) -> Void)
}

class GalleryRemoteDataSourceImpl: GalleryRemoteDataSource {
    
    let httpClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.httpClient = apiClient
    }
    
    func getPhotos(inPage: Int, completitionHandler: @escaping ([PhotoModel]?, Error?) -> Void) {
        var url = Endpoints.photosUrl
        let params: [String : String] = [
            "{clientId}": "\(Credentials.accessKey)",
            "{page}": "\(inPage)"
        ]
        
        params.forEach { (key, value) in
            url = url.replacingOccurrences(of: key, with: value)
        }
        httpClient.performRequest(to: url, httpMethod: .Get, completitionHandler: completitionHandler)
    }
}
