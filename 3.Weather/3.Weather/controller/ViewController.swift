//
//  ViewController.swift
//  3.Weather
//
//  Created by 홍진석 on 2021/01/07.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var Countrylist = Array<Country>()
    var selectNum : Int?
    var dates : [Date] = []
    
    @IBOutlet weak var CountryTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetting()
        
        
        CountryTable.delegate = self
        CountryTable.dataSource = self
    }
    
    func initialSetting(){
        let c1 = Country(name: "Korea", image: #imageLiteral(resourceName: "flag_kr"), code : "kr")
        let c2 = Country(name: "Germany", image: #imageLiteral(resourceName: "flag_de"), code : "de")
        let c3 = Country(name: "Italy", image: #imageLiteral(resourceName: "flag_it"), code : "it")
        let c4 = Country(name: "US", image: #imageLiteral(resourceName: "flag_us"), code : "us")
        let c5 = Country(name: "France", image: #imageLiteral(resourceName: "flag_fr"), code : "fr")
        let c6 = Country(name: "Japan", image: #imageLiteral(resourceName: "flag_jp"), code : "jp")
        Countrylist.append(c1)
        Countrylist.append(c2)
        Countrylist.append(c3)
        Countrylist.append(c4)
        Countrylist.append(c5)
        Countrylist.append(c6)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Countrylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CountryTableViewCell
        
        cell.CountryName.text = Countrylist[indexPath.row].name
        cell.CountryImage.image = Countrylist[indexPath.row].image
        
        cell.CountryCode = Countrylist[indexPath.row].code
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "나라"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let next : WeatherViewController = segue.destination as? WeatherViewController else{
            return
        }
    
        guard let cell : CountryTableViewCell = sender as? CountryTableViewCell else{
            return
        }
        next.dataname = cell.CountryCode
        next.countryName = cell.CountryName.text
    }
}

