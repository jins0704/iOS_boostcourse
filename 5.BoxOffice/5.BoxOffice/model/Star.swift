//
//  Star.swift
//  5.BoxOffice
//
//  Created by 홍진석 on 2021/01/21.
//

import Foundation
import UIKit

struct Star{
    var rating : Double?
    var star1 : UIImage?
    var star2 : UIImage?
    var star3 : UIImage?
    var star4 : UIImage?
    var star5 : UIImage?
 
    mutating func starGrade(rate : Double){
        
        star1 = #imageLiteral(resourceName: "ic_star_label")
        star2 = #imageLiteral(resourceName: "ic_star_label")
        star3 = #imageLiteral(resourceName: "ic_star_label")
        star4 = #imageLiteral(resourceName: "ic_star_label")
        star5 = #imageLiteral(resourceName: "ic_star_label")
        
        if rate < 1{
            star1 = #imageLiteral(resourceName: "ic_star_large")
            star2 = #imageLiteral(resourceName: "ic_star_large")
            star3 = #imageLiteral(resourceName: "ic_star_large")
            star4 = #imageLiteral(resourceName: "ic_star_large")
            star5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 2{
            star1 = #imageLiteral(resourceName: "ic_star_large_half")
            star2 = #imageLiteral(resourceName: "ic_star_large")
            star3 = #imageLiteral(resourceName: "ic_star_large")
            star4 = #imageLiteral(resourceName: "ic_star_large")
            star5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 3{
            star2 = #imageLiteral(resourceName: "ic_star_large")
            star3 = #imageLiteral(resourceName: "ic_star_large")
            star4 = #imageLiteral(resourceName: "ic_star_large")
            star5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 4{
            star2 = #imageLiteral(resourceName: "ic_star_large_half")
            star3 = #imageLiteral(resourceName: "ic_star_large")
            star4 = #imageLiteral(resourceName: "ic_star_large")
            star5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 5{
            star3 = #imageLiteral(resourceName: "ic_star_large")
            star4 = #imageLiteral(resourceName: "ic_star_large")
            star5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 6{
            star3 = #imageLiteral(resourceName: "ic_star_large_half")
            star4 = #imageLiteral(resourceName: "ic_star_large")
            star5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 7{
            star4 = #imageLiteral(resourceName: "ic_star_large")
            star5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 8{
            star4 = #imageLiteral(resourceName: "ic_star_large_half")
            star5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 9{
            star5 = #imageLiteral(resourceName: "ic_star_large")
        }
        
        else if rate < 10{
            star5 = #imageLiteral(resourceName: "ic_star_large_half")
        }
        else{}
    }
   
}
