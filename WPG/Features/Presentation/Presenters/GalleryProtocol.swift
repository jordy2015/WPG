//
//  GalleryProtocol.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

protocol GalleryProtocol: class {
    func shouldDisplayActivityIndicator(_ shouldDisplay: Bool)
    func gotError(_ error: Error)
    func gotPhotos(photoList: [PhotoProtocol])
    func isLocal(_ flag: Bool)
}
