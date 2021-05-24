//
//  FavoritesPresenter.swift
//  WPG
//
//  Created by Jordy Gonzalez on 23/05/21.
//

import Foundation

class FavoritesPresenter {
    private let useCase: GetFavorites
    private weak var view: FavoritesProtocol?
    private var gettingData: Bool = false
    
    init(useCase: GetFavorites) {
        self.useCase = useCase
    }
    
    func attachView(_ view: FavoritesProtocol) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func getFavorites() {
        guard !gettingData else { return }
        gettingData = true
        self.view?.shouldDisplayActivityIndicator(true)
        useCase.call() { [unowned self] (photosList, error) in
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
