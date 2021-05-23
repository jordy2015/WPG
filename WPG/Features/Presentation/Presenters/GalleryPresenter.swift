//
//  GalleryPresenter.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

class GalleryPresenter {
    private let repository: GalleryRepository
    private weak var view: GalleryProtocol?
    private var gettingData: Bool = false
    
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
        guard !gettingData else { return }
        gettingData = true
        self.view?.shouldDisplayActivityIndicator(true)
        repository.getPhotos(inPage: page) { [unowned self] (photosList, error) in
            self.view?.shouldDisplayActivityIndicator(false)
            if let e = error {
                self.view?.gotError(e)
            } else {
                self.view?.gotPhotos(photoList: photosList ?? [])
            }
            self.gettingData = false
        }
    }
}
