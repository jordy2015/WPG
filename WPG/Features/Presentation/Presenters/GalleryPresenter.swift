//
//  GalleryPresenter.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

class GalleryPresenter {
    fileprivate let repository: GalleryRepository
    fileprivate weak var view: GalleryProtocol?
    
    init(repository: GalleryRepository) {
        self.repository = repository
    }
    
    func attachView(_ view: GalleryProtocol) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func getPhotos(page: Int) {
        self.view?.shouldDisplayActivityIndicator(true)
        repository.getPhotos(inPage: page) { (photosList, error) in
            self.view?.shouldDisplayActivityIndicator(false)
            if let e = error {
                self.view?.gotError(e)
            } else {
                self.view?.gotPhotos(photoList: photosList ?? [])
            }
        }
    }
}
