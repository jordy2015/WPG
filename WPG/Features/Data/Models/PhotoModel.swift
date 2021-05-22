//
//  ImageModel.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation

struct PhotoModel: Decodable, PhotoProtocol {
    let id: String
    let width: Int
    let height: Int
    let color: String
    let blurHash: String
    let likes: Int
    let urls: UrlModel
    
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case color
        case blurHash = "blur_hash"
        case likes
        case urls
    }
}
