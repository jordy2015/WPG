//
//  GalleryRemoteDataSource.swift
//  WPGTests
//
//  Created by Jordy Gonzalez on 24/07/21.
//

import XCTest
@testable import WPG

class ApiClientSuccessMock: NetworkProtocol {
    let photoMock: PhotoModel
        
    init(photoMock: PhotoModel) {
        self.photoMock = photoMock
    }
    
    func performRequest<T: Decodable>(to url: String, httpMethod: HttpMethod, keyPath: String?, body: [String : AnyObject]?, completitionHandler: @escaping (T?, Error?) -> Void) {
        
        completitionHandler([photoMock] as? T, nil)
    }
    
    func hasConnection() -> Bool {
        return true
    }
}

class ApiClientErrorMock: NetworkProtocol {
    let errorMock: Error
        
    init(errorMock: Error) {
        self.errorMock = errorMock
    }
    
    func performRequest<T: Decodable>(to url: String, httpMethod: HttpMethod, keyPath: String?, body: [String : AnyObject]?, completitionHandler: @escaping (T?, Error?) -> Void) {
        completitionHandler(nil, errorMock)
    }
    
    func hasConnection() -> Bool {
        return true
    }
}

class TestGalleryRemoteDataSource: XCTestCase {
    var galleryRemoteDatasource: GalleryRemoteDataSourceImpl?

    func testGetDataCorrectly() {
        let userMock = UserModel(id: "1235",
                                 userName: "user1",
                                 name: "Jonh",
                                 profileImage: ProfileImageModel(medium: "url"),
                                 portfolioUrl: "imageUrl",
                                 totalPhotos: 123)
        let photoMock = PhotoModel(id: "123",
                                   width: 2,
                                   height: 3,
                                   color: "red",
                                   blurHash: "blur",
                                   likes: 10,
                                   urls: UrlModel(full: "full", regular: "regular"),
                                   user: userMock)
        
        let apiClient = ApiClientSuccessMock(photoMock: photoMock)
        galleryRemoteDatasource = GalleryRemoteDataSourceImpl(apiClient: apiClient)
        galleryRemoteDatasource?.getPhotos(inPage: 0, completitionHandler: { (photos, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(photos)
            XCTAssertEqual(photos?.first?.getId(), photoMock.getId())
            XCTAssertEqual(photos?.first?.getUser().getId(), userMock.getId())
        })
    }
    
    func testGetDataWithError() {
        let err = NSError(domain: "XCTest", code: 123, userInfo: nil)
        let apiClient = ApiClientErrorMock(errorMock: err)
        galleryRemoteDatasource = GalleryRemoteDataSourceImpl(apiClient: apiClient)
        galleryRemoteDatasource?.getPhotos(inPage: 0, completitionHandler: { (photos, error) in
            XCTAssertNil(photos)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, err.localizedDescription)
        })
    }
}
