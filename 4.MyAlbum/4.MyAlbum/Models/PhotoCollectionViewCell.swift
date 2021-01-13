//
//  PhotoCollectionViewCell.swift
//  4.MyAlbum
//
//  Created by 홍진석 on 2021/01/11.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photoLabel: UILabel!
    var checkSelected : Bool?
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }
}
