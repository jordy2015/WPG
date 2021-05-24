//
//  Data+ToImage.swift
//  WPG
//
//  Created by Jordy Gonzalez on 23/05/21.
//

import Foundation
import UIKit

extension Data {
    var getImage: UIImage? { UIImage(data: self) }
}
