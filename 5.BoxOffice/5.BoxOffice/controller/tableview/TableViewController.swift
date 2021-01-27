//
//  TableViewController.swift
//  5.BoxOffice
//
//  Created by 홍진석 on 2021/01/14.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,APIControllerDelegate{

    var APIManager = APIController()
    var movieList : [Movie]  = []
    @IBOutlet weak var movieTableView: UITableView!
    let cellIdentifier = "tablecell"
    
    override func viewDidAppear(_ animated: Bool) {
        APIManager.responseAPI(current: "\(Constants.baseURL)movies")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        APIManager.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie : Movie = self.movieList[indexPath.row]
        
        let cell : TableViewCell = movieTableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! TableViewCell
        
        cell.userRating = movie.user_rating
        cell.id = movie.id
        
        cell.detailLabel.text = "평점 : \(movie.user_rating!)  예매순위 : \(movie.reservation_grade!) 예매율 : \(movie.reservation_rate!)"
       
        cell.titleLabel.text = movie.title
        cell.dateLabel.text = "개봉일 : \(movie.date!)"
        
        if movie.grade == 0{cell.gradeImage.image = #imageLiteral(resourceName: "ic_allages")}
        else if movie.grade == 19{cell.gradeImage.image = #imageLiteral(resourceName: "ic_19")}
        else if movie.grade == 12{cell.gradeImage.image = #imageLiteral(resourceName: "ic_12")}
        else if movie.grade == 15{cell.gradeImage.image = #imageLiteral(resourceName: "ic_15")}
        else{}
        
        if let url = URL(string: movie.thumb!){
            do{
                let urldata = try Data(contentsOf: url)
                 cell.movieImage.image = UIImage(data: urldata)
            }catch{
                print("data error")
                print(error)
            }
        }
        return cell
    }
    
    @IBAction func selectSorting(_ sender: Any) {
        let optionMenu = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        
        let Action1 = UIAlertAction(title: "예매순위", style: .default, handler: {
                 (alert: UIAlertAction!) -> Void in
            self.APIManager.responseAPI(current: "\(Constants.baseURL)movies?order_type=0")
        })

        let Action2 = UIAlertAction(title: "큐레이션", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
            self.APIManager.responseAPI(current: "\(Constants.baseURL)movies?order_type=1")
        })
      
        let Action3 = UIAlertAction(title: "개봉일", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
            self.APIManager.responseAPI(current: "\(Constants.baseURL)movies?order_type=2")
        })
       
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {
                 (alert: UIAlertAction!) -> Void in
        })

        optionMenu.addAction(Action1)
        optionMenu.addAction(Action2)
        optionMenu.addAction(Action3)
        optionMenu.addAction(cancelAction)

        self.present(optionMenu, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let next : DetailViewController = segue.destination as? DetailViewController else{
            return
        }
        
        guard let cell : TableViewCell = sender as? TableViewCell else{
            return
        }
        next.id = cell.id
        next.gradeimage = cell.gradeImage.image
        next.movieimage = cell.movieImage.image
        next.userRating = cell.userRating
    }
    
    func UpdateView(_ apicontrol: APIController, _ dd: Data) {
       
        do{
            let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: dd)
            self.movieList = apiResponse.movies
              
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
            
        }catch(let err){
            print(err.localizedDescription)
        }
    }

}
