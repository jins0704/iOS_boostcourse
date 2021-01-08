//
//  Country.swift
//  3.Weather
//
//  Created by 홍진석 on 2021/01/08.
//

import Foundation
import UIKit

class Country{
    var name : String?
    var image : UIImage?
    var code : String?
    
    init(name : String, image : UIImage, code : String) {
        self.name = name
        self.image = image
        self.code = code
    }
}
