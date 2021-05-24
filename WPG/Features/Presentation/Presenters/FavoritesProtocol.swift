//
//  FavoritesProtocol.swift
//  WPG
//
//  Created by Jordy Gonzalez on 23/05/21.
//

import Foundation

protocol FavoritesProtocol: class {
    func shouldDisplayActivityIndicator(_ shouldDisplay: Bool)
    func gotError(_ error: Error)
    func gotPhotos(photoList: [PhotoProtocol])
}
