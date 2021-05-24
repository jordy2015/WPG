//
//  GalleryPresenter.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

class GalleryPresenter {
    private let useCase: GetPhotos
    private weak var view: GalleryProtocol?
    private var gettingData: Bool = false
    
    init(useCase: GetPhotos) {
        self.useCase = useCase
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
        useCase.call(inPage: page) { [unowned self] (photosList, error, isLocal) in
            self.view?.shouldDisplayActivityIndicator(false)
            self.view?.isLocal(isLocal)
            if let e = error {
                self.view?.gotError(e)
            } else {
                self.view?.gotPhotos(photoList: photosList ?? [])
            }
            self.gettingData = false
        }
    }
}
