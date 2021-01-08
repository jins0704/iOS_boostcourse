//
//  WeatherTableViewCell.swift
//  3.Weather
//
//  Created by 홍진석 on 2021/01/08.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var rainInfo: UILabel!
    @IBOutlet weak var tempInfo: UILabel!
    var weatherName : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
