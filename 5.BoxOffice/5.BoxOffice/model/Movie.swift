//
//  Movie.swift
//  5.BoxOffice
//
//  Created by 홍진석 on 2021/01/14.
//

import Foundation

struct APIResponse : Codable{
    let movies : [Movie]
}

struct Movie : Codable{
    var id : String?
    var reservation_rate : Double?
    var date : String?
    var grade : Int?
    var reservation_grade : Int?
    var thumb : String?
    var title : String?
    var user_rating : Double?
}
