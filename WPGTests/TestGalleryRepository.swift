//
//  GalleryRepository.swift
//  WPGTests
//
//  Created by Jordy Gonzalez on 24/07/21.
//

import XCTest
@testable import WPG

class ApiClientMock: NetworkProtocol {
    
    let connection: Bool
    
    init(hasConnection: Bool) {
        self.connection = hasConnection
    }
    
    func performRequest<T>(to url: String, httpMethod: HttpMethod, keyPath: String?, body: [String : AnyObject]?, completitionHandler: @escaping (T?, Error?) -> Void) where T : Decodable {
        completitionHandler(nil, nil)
    }
    
    func hasConnection() -> Bool {
        return connection
    }
}

class GalleryRemoteDataSourceMock: GalleryRemoteDataSource {
    
    private var success: [PhotoModel]?
    private var error: NSError?
    
    init(success: [PhotoModel]?, error: NSError?) {
        self.success = success
        self.error = error
    }
    
    func getPhotos(inPage: Int, completitionHandler: @escaping ([PhotoModel]?, Error?) -> Void) {
        completitionHandler(success, error)
    }
}

class FavoritesLocalDataSourceMock: FavoritesLocalDataSource {
    private var success: [PhotoProtocol]?
    private var error: NSError?
    
    init(success: [PhotoProtocol]?, error: NSError?) {
        self.success = success
        self.error = error
    }
    
    func getPhotos(completitionHandler: @escaping ([PhotoProtocol]?, Error?) -> Void) {
        completitionHandler(success, error)
    }
}

class PhotoEntityMock: PhotoProtocol {
    func getId() -> String {
        return "1234"
    }
    
    func getLikes() -> Int {
        return 222
    }
    
    func getWidth() -> Int {
        return 123
    }
    
    func getHeight() -> Int {
        return 1234
    }
    
    func getImageUrl() -> String {
        return ""
    }
    
    func getImage() -> Data? {
        return nil
    }
    
    func getUser() -> UserProtocol {
        return (Any).self as! UserProtocol
    }
    
    func isFavorite(search database: DatabaseHandler) -> Bool {
        return false
    }
    
    func save(in database: DatabaseHandler, cache imageCache: ImagesCache) {
        
    }
}

class TestGalleryRepository: XCTestCase {
    
    var photoModel: PhotoModel?
    var photo: PhotoProtocol?
    var error: NSError?
    
    override func setUpWithError() throws {
        let userMock = UserModel(id: "1235",
                                 userName: "user1",
                                 name: "Jonh",
                                 profileImage: ProfileImageModel(medium: "url"),
                                 portfolioUrl: "imageUrl",
                                 totalPhotos: 123)
        
        self.photoModel = PhotoModel(id: "123",
                                   width: 2,
                                   height: 3,
                                   color: "red",
                                   blurHash: "blur",
                                   likes: 10,
                                   urls: UrlModel(full: "full", regular: "regular"),
                                   user: userMock)
        
        self.photo = PhotoEntityMock()
        
        self.error = NSError(domain: "XCTest", code: 22, userInfo: nil)
    }
    
    func testGetFromRemote() {
        let apiClientMock = ApiClientMock(hasConnection: true)
        let galleryRemoteDataSourceMock = GalleryRemoteDataSourceMock(success: [self.photoModel!], error: nil)
        let favoritesLocalDataSourceMock = FavoritesLocalDataSourceMock(success: nil, error: nil)
        
        let galleryRepository = GalleryRepositoryImpl(httpConnection: apiClientMock, remote: galleryRemoteDataSourceMock, local: favoritesLocalDataSourceMock)
        
        galleryRepository.getPhotos(inPage: 1) { (photos, error, isLocal) in
            assert(!isLocal)
            XCTAssertNil(error)
            XCTAssertNotNil(photos)
            XCTAssertEqual(self.photoModel?.getId(), photos?.first?.getId())
        }
    }
    
    func testGetFromLocal() {
        let apiClientMock = ApiClientMock(hasConnection: false)
        let galleryRemoteDataSourceMock = GalleryRemoteDataSourceMock(success: nil, error: nil)
        let favoritesLocalDataSourceMock = FavoritesLocalDataSourceMock(success: [self.photo!], error: nil)
        
        let galleryRepository = GalleryRepositoryImpl(httpConnection: apiClientMock, remote: galleryRemoteDataSourceMock, local: favoritesLocalDataSourceMock)
        
        galleryRepository.getPhotos(inPage: 1) { (photos, error, isLocal) in
            assert(isLocal)
            XCTAssertNil(error)
            XCTAssertNotNil(photos)
            XCTAssertEqual(self.photo?.getId(), photos?.first?.getId())
        }
    }
    
    func testGetFromRemoteWithError() {
        let apiClientMock = ApiClientMock(hasConnection: true)
        let galleryRemoteDataSourceMock = GalleryRemoteDataSourceMock(success: nil, error: self.error)
        let favoritesLocalDataSourceMock = FavoritesLocalDataSourceMock(success: nil, error: nil)
        
        let galleryRepository = GalleryRepositoryImpl(httpConnection: apiClientMock, remote: galleryRemoteDataSourceMock, local: favoritesLocalDataSourceMock)
        
        galleryRepository.getPhotos(inPage: 1) { (photos, error, isLocal) in
            assert(!isLocal)
            XCTAssertNil(photos)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, self.error?.localizedDescription)
        }
    }

}
