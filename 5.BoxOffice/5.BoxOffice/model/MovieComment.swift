//
//  MovieComment.swift
//  5.BoxOffice
//
//  Created by 홍진석 on 2021/01/16.
//

import Foundation

struct APIResponse2 : Codable{
    let comments : [MovieComment]
}
struct MovieComment : Codable{
    var id : String?
    var rating : Double?
    var contents : String?
    var timestamp : Double?
    var writer : String?
    var movie_id : String?
}
