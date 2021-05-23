//
//  GetPhotos.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

class GetPhotos {
    let gelleryRepository: GalleryRepository
    
    init(gallery: GalleryRepository) {
        self.gelleryRepository = gallery
    }
    
    func call(inPage: Int, completitionHandler: @escaping ([PhotoProtocol]?, Error?) -> Void) {
        gelleryRepository.getPhotos(inPage: inPage, completitionHandler: completitionHandler)
    }
}
