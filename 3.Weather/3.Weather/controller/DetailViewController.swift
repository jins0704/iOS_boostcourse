//
//  DetailViewController.swift
//  3.Weather
//
//  Created by 홍진석 on 2021/01/08.
//

import UIKit

class DetailViewController: UIViewController {

    var weatherName : String?
    var weatherTemp : String?
    var weatherRain : String?
    var location : String?
    var countryName : String?
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var RainLabel: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        navigationItem.title = location
        
        NameLabel.text = weatherName
        TempLabel.text = weatherTemp
        RainLabel.text = weatherRain
        
        if weatherName == "맑음"{
            weatherImage.image = #imageLiteral(resourceName: "sunny")
            Description.text = "날씨가 좋습니다!"
        }else if weatherName == "흐림"{
            weatherImage.image = #imageLiteral(resourceName: "cloudy")
            Description.text = "날씨가 흐려요.."
        }else if weatherName == "눈"{
            weatherImage.image = #imageLiteral(resourceName: "snowy")
            Description.text = "눈이옵니다~~"
        }else{
            weatherImage.image = #imageLiteral(resourceName: "rainy")
            Description.text = "우산을 챙기세요"
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
