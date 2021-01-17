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
        
        cell.nameLabel.text = "\(comment.writer!)/\(comment.timestamp!)"
        cell.contentLabel.text = comment.contents
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
