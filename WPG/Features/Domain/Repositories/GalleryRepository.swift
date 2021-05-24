//
//  GalleryRepository.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

protocol GalleryRepository {
    func getPhotos(inPage: Int, completitionHandler: @escaping(_ response: [PhotoProtocol]?, _ error: Error?, _ isLocal: Bool) -> Void)
}
