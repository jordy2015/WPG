//
//  TestGalleryPresenter.swift
//  WPGTests
//
//  Created by Jordy Gonzalez on 25/07/21.
//

import XCTest
@testable import WPG

class GalleryRepositoryMock2: GalleryRepository {
    var success: [PhotoProtocol]?
    var error: NSError?
    
    init(success: [PhotoProtocol]?, error: NSError?) {
        self.success = success
        self.error = error
    }
    
    func getPhotos(inPage: Int, completitionHandler: @escaping ([PhotoProtocol]?, Error?, Bool) -> Void) {
        completitionHandler(success, error, false)
    }
}

class TestViewController: GalleryProtocol {
    var shouldDisplay: Bool?
    var error: NSError?
    var photos: [PhotoProtocol]?
    var isLocal: Bool?
    
    func shouldDisplayActivityIndicator(_ shouldDisplay: Bool) {
        self.shouldDisplay = shouldDisplay
    }
    
    func gotError(_ error: Error) {
        self.error = error as NSError
    }
    
    func gotPhotos(photoList: [PhotoProtocol]) {
        self.photos = photoList
    }
    
    func isLocal(_ flag: Bool) {
        self.isLocal = flag
    }
}

class TestGalleryPresenter: XCTestCase {
    var photoModel: PhotoModel?
    var error: NSError?
    var useCase: GetPhotos?
    
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
    
    func testGetPhotoSuccessfully() {
        let testViewContoller = TestViewController()
        let repoMock = GalleryRepositoryMock2(success: [self.photoModel!], error: nil)
        let useCase = GetPhotos(repository: repoMock)
        let presenter = GalleryPresenter(useCase: useCase)
        presenter.attachView(testViewContoller)
        XCTAssertNil(testViewContoller.shouldDisplay)
        XCTAssertNil(testViewContoller.error)
        XCTAssertNil(testViewContoller.photos)
        XCTAssertNil(testViewContoller.isLocal)
        presenter.getPhotos(page: 1)
        XCTAssertNotNil(testViewContoller.shouldDisplay)
        XCTAssertNil(testViewContoller.error)
        XCTAssertNotNil(testViewContoller.photos)
        XCTAssertNotNil(testViewContoller.isLocal)
        
        XCTAssertFalse(testViewContoller.shouldDisplay!)
        XCTAssertFalse(testViewContoller.isLocal!)
        XCTAssertEqual(testViewContoller.photos?.first?.getId(), self.photoModel?.getId())
    }
    
    func testGetPhotoWithError() {
        let testViewContoller = TestViewController()
        let repoMock = GalleryRepositoryMock2(success: nil, error: self.error)
        let useCase = GetPhotos(repository: repoMock)
        let presenter = GalleryPresenter(useCase: useCase)
        presenter.attachView(testViewContoller)
        XCTAssertNil(testViewContoller.shouldDisplay)
        XCTAssertNil(testViewContoller.error)
        XCTAssertNil(testViewContoller.photos)
        XCTAssertNil(testViewContoller.isLocal)
        presenter.getPhotos(page: 1)
        XCTAssertNotNil(testViewContoller.shouldDisplay)
        XCTAssertNotNil(testViewContoller.error)
        XCTAssertNil(testViewContoller.photos)
        XCTAssertNotNil(testViewContoller.isLocal)
        
        XCTAssertFalse(testViewContoller.shouldDisplay!)
        XCTAssertFalse(testViewContoller.isLocal!)
        XCTAssertEqual(testViewContoller.error?.localizedDescription, self.error?.localizedDescription)
    }
}
