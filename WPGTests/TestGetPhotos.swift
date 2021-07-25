//
//  TestGetPhotos.swift
//  WPGTests
//
//  Created by Jordy Gonzalez on 24/07/21.
//

import XCTest
@testable import WPG

class GalleryRepositoryMock: GalleryRepository {
    
    var success: [PhotoProtocol]?
    var error: NSError?
    
    init(success: [PhotoProtocol]?, error: NSError?) {
        self.success = success
        self.error = error
    }
    
    func getPhotos(inPage: Int, completitionHandler: @escaping ([PhotoProtocol]?, Error?, Bool) -> Void) {
        completitionHandler(success, error, true)
    }
}

class TestGetPhotos: XCTestCase {
    var photoModel: PhotoModel?
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
        self.error = NSError(domain: "XCTest", code: 1, userInfo: nil)
    }

    func testGetPhotosSuccessfully() {
        let repoMock = GalleryRepositoryMock(success: [self.photoModel!], error: nil)
        let useCase = GetPhotos(repository: repoMock)
        useCase.call(inPage: 1) { (photos, error, isLocal) in
            XCTAssertNil(error)
            XCTAssertTrue(isLocal)
            XCTAssertEqual(photos?.first?.getId(), self.photoModel?.getId())
        }
    }
    
    func testGetPhotosWithError() {
        let repoMock = GalleryRepositoryMock(success: nil, error: self.error)
        let useCase = GetPhotos(repository: repoMock)
        useCase.call(inPage: 1) { (photos, error, isLocal) in
            XCTAssertNil(photos)
            XCTAssertTrue(isLocal)
            XCTAssertEqual(error?.localizedDescription, self.error?.localizedDescription)
        }
    }
}
