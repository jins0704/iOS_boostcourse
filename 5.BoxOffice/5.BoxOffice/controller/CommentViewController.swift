//
//  CommentViewController.swift
//  5.BoxOffice
//
//  Created by 홍진석 on 2021/01/16.
//

import UIKit

class CommentViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var commentList : [MovieComment]  = []
    var movieName : String!
    var movieGrade : UIImage?

    var starImage1 : UIImage?
    var starImage2 : UIImage?
    var starImage3 : UIImage?
    var starImage4 : UIImage?
    var starImage5 : UIImage?
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return movieName
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment : MovieComment = self.commentList[indexPath.row]
        
        let cell : ContentViewCell = contentTable.dequeueReusableCell(withIdentifier: "commentcell", for: indexPath) as! ContentViewCell
        
        cell.nameLabel.text = "\(comment.writer!)"
        cell.contentLabel.text = comment.contents
        cell.cellrating = comment.rating!
        
        starGrade(rate : cell.cellrating!)
        
        cell.star1.image = starImage1
        cell.star2.image = starImage2
        cell.star3.image = starImage3
        cell.star4.image = starImage4
        cell.star5.image = starImage5
        
        cell.userImage.image = #imageLiteral(resourceName: "ic_user_loading")
        return cell
        
    }
    
    
    var movieID : String?
    @IBOutlet weak var contentTable: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        guard let url : URL = URL(string: "\(baseURL)comments?movie_id=\(movieID!)") else{
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
                let apiResponse: APIResponse2 = try JSONDecoder().decode(APIResponse2.self, from: data)
                self.commentList = apiResponse.comments
                
                DispatchQueue.main.async {
                    self.contentTable.reloadData()
                }
            }catch(let err){
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTable.delegate = self
        contentTable.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "writecomment"{
            guard let next : WriteCommentViewController = segue.destination as? WriteCommentViewController else{
                return
            }
            next.movieName = movieName
            next.gradeImage = movieGrade
        }
    }
    
    @IBAction func unwindComment(segue : UIStoryboardSegue){
        let before = segue.source as! WriteCommentViewController
        let nickname = before.nicknameLabel.text!
        let comment = before.commentField.text!
        let rating = before.gradeText.text!
        
        guard let r = Double(rating)else {
                    return
        }
        let newcomment = MovieComment(writer: nickname, rating: r,contents : comment)
        commentList.append(newcomment)
        
        self.contentTable.reloadData()
    }
    
    func starGrade(rate : Double){
        
        starImage1 = #imageLiteral(resourceName: "ic_star_label")
        starImage2 = #imageLiteral(resourceName: "ic_star_label")
        starImage3 = #imageLiteral(resourceName: "ic_star_label")
        starImage4 = #imageLiteral(resourceName: "ic_star_label")
        starImage5 = #imageLiteral(resourceName: "ic_star_label")
        
        if rate < 1{
            starImage1 = #imageLiteral(resourceName: "ic_star_large")
            starImage2 = #imageLiteral(resourceName: "ic_star_large")
            starImage3 = #imageLiteral(resourceName: "ic_star_large")
            starImage4 = #imageLiteral(resourceName: "ic_star_large")
            starImage5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 2{
            starImage1 = #imageLiteral(resourceName: "ic_star_large_half")
            starImage2 = #imageLiteral(resourceName: "ic_star_large")
            starImage3 = #imageLiteral(resourceName: "ic_star_large")
            starImage4 = #imageLiteral(resourceName: "ic_star_large")
            starImage5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 3{
            starImage2 = #imageLiteral(resourceName: "ic_star_large")
            starImage3 = #imageLiteral(resourceName: "ic_star_large")
            starImage4 = #imageLiteral(resourceName: "ic_star_large")
            starImage5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 4{
            starImage2 = #imageLiteral(resourceName: "ic_star_large_half")
            starImage3 = #imageLiteral(resourceName: "ic_star_large")
            starImage4 = #imageLiteral(resourceName: "ic_star_large")
            starImage5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 5{
            starImage3 = #imageLiteral(resourceName: "ic_star_large")
            starImage4 = #imageLiteral(resourceName: "ic_star_large")
            starImage5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 6{
            starImage3 = #imageLiteral(resourceName: "ic_star_large_half")
            starImage4 = #imageLiteral(resourceName: "ic_star_large")
            starImage5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 7{
            starImage4 = #imageLiteral(resourceName: "ic_star_large")
            starImage5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 8{
            starImage4 = #imageLiteral(resourceName: "ic_star_large_half")
            starImage5 = #imageLiteral(resourceName: "ic_star_large")
        }
        else if rate < 9{
            starImage5 = #imageLiteral(resourceName: "ic_star_large")
        }
        
        else if rate < 10{
            starImage5 = #imageLiteral(resourceName: "ic_star_large_half")
        }
        else{
            
        }
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
