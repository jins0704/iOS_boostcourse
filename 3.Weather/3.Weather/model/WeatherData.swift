//
//  WeatherData.swift
//  3.Weather
//
//  Created by 홍진석 on 2021/01/08.
//

/*"city_name":"깐느",
"state":13,
"celsius":9.7,
"rainfall_probability":60*/

import Foundation

struct WeatherData : Codable{
    var city_name : String
    var state : Int
    var celsius : Double
    var rainfall_probability : Int
}

