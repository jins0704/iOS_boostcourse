//
//  CollectionViewCell.swift
//  5.BoxOffice
//
//  Created by 홍진석 on 2021/01/19.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
    
    var id : String?
    var userRating : Double?
}
