//
//  CountryTableViewCell.swift
//  3.Weather
//
//  Created by 홍진석 on 2021/01/07.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var CountryImage: UIImageView!
    @IBOutlet weak var CountryName: UILabel!
    var CountryCode : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
