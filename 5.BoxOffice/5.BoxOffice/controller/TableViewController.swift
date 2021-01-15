//
//  TableViewController.swift
//  5.BoxOffice
//
//  Created by 홍진석 on 2021/01/14.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var movieList : [Movie]  = []
    
    @IBOutlet weak var movieTableView: UITableView!
    let cellIdentifier = "tablecell"
    
    override func viewDidAppear(_ animated: Bool) {
        guard let url : URL = URL(string: "https://connect-boxoffice.run.goorm.io/movies") else{
            return
        }
        
        let session : URLSession = URLSession(configuration: .default)
        let dataTask : URLSessionDataTask = session.dataTask(with: url){
            (data: Data?, response : URLResponse?, error: Error?) in
            
            if let error = error{
                print(error)
                return
            }
            
            guard let data = data else{return}
            
            do{
                let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                self.movieList = apiResponse.movies
                
                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                }
            }catch(let err){
                print(err.localizedDescription)
            }
        }
        
        dataTask.resume()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self

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
       
        cell.reservationGrade = movie.reservation_grade
        cell.reservationRating = movie.reservation_rate
        cell.userRating = movie.user_rating
        
        cell.detailLabel.text = "평점 : \(movie.user_rating!)  예매순위 : \(movie.reservation_grade!) 예매율 : \(movie.reservation_rate!)"
       
        cell.titleLabel.text = movie.title
        cell.dateLabel.text = "개봉일 : \(movie.date!)"
        
        if movie.grade == 0{
            cell.gradeImage.image = #imageLiteral(resourceName: "ic_allages")
        }
        if movie.grade == 19{
            cell.gradeImage.image = #imageLiteral(resourceName: "ic_19")
        }
        if movie.grade == 12{
            cell.gradeImage.image = #imageLiteral(resourceName: "ic_12")
        }
        if movie.grade == 15{
            cell.gradeImage.image = #imageLiteral(resourceName: "ic_15")
        }
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
        
        let Action1 = UIAlertAction(title: "예매율", style: .default, handler: {
                 (alert: UIAlertAction!) -> Void in
        })

        let Action2 = UIAlertAction(title: "큐레이션", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
        })
      
        let Action3 = UIAlertAction(title: "개봉일", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
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
        guard let next : DetailTableViewController = segue.destination as? DetailTableViewController else{
            return
        }
        
        guard let cell : TableViewCell = sender as? TableViewCell else{
            return
        }
    
        next.userRating = cell.userRating
        next.reservationRating = cell.reservationRating
        next.reservationGrade = cell.reservationGrade
        next.gradeimage = cell.gradeImage.image
        next.date = cell.dateLabel.text
        next.movieimage = cell.movieImage.image
        next.movietitle = cell.titleLabel.text
    }
}
