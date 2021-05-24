//
//  Image+ToData.swift
//  WPG
//
//  Created by Jordy Gonzalez on 23/05/21.
//

import UIKit

extension UIImage {
    var getData: Data? { jpegData(compressionQuality: 1) }
}
