//
//  WeatherViewController.swift
//  3.Weather
//
//  Created by 홍진석 on 2021/01/08.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var countryName : String?
    var dataname : String?
    var weatherInfo : [WeatherData] = []
    
    @IBOutlet weak var weatherTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        weatherTable.delegate = self
        weatherTable.dataSource = self
        
        let decoder : JSONDecoder = JSONDecoder()
       
        guard let dataAsset : NSDataAsset = NSDataAsset(name: dataname!)else{
            return
        }
       
        do{
            self.weatherInfo = try decoder.decode([WeatherData].self, from: dataAsset.data)
        }
        catch{
                print(error)
            }
        self.weatherTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let wcell : WeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: "weathercell", for: indexPath) as! WeatherTableViewCell
        
        let data : WeatherData = self.weatherInfo[indexPath.row]
        
        wcell.cityName.text = "\(data.city_name)"
        wcell.tempInfo.text = "섭씨 " + "\(data.state)" + " / " + "화씨 " + "\(data.celsius)"
        wcell.rainInfo.text = "강수확률 : " + "\(data.rainfall_probability)" + "%"
        
        if data.rainfall_probability >= 70{
            if data.celsius > 10{
                wcell.weatherImage.image = #imageLiteral(resourceName: "rainy")
                wcell.weatherName = "비"
            }else{
                wcell.weatherImage.image = #imageLiteral(resourceName: "snowy")
                wcell.weatherName = "눈"
            }
        }else{
            if data.celsius > 10{
                wcell.weatherImage.image = #imageLiteral(resourceName: "sunny")
                wcell.weatherName = "맑음"
            }else{
                wcell.weatherImage.image = #imageLiteral(resourceName: "cloudy")
                wcell.weatherName = "흐림"
            }
        }

        return wcell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "날씨 정보"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let next : DetailViewController = segue.destination as? DetailViewController else{
            return
        }
    
        guard let cell : WeatherTableViewCell = sender as? WeatherTableViewCell else{
            return
        }
        
        next.weatherName = cell.weatherName
        next.weatherTemp = cell.tempInfo.text
        next.weatherRain = cell.rainInfo.text
        next.location = cell.cityName.text
        next.countryName = countryName
    }
}
