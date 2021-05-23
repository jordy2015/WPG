//
//  GetPhotos.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

class GetPhotos {
    let gelleryRepository: GalleryRepository
    
    init(repository: GalleryRepository) {
        self.gelleryRepository = repository
    }
    
    func call(inPage: Int, completitionHandler: @escaping ([PhotoProtocol]?, Error?, Bool) -> Void) {
        gelleryRepository.getPhotos(inPage: inPage, completitionHandler: completitionHandler)
    }
}
