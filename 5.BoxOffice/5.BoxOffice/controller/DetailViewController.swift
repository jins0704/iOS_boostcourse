//
//  DetailTableViewController.swift
//  5.BoxOffice
//
//  Created by 홍진석 on 2021/01/15.
//

import UIKit

class DetailViewController: UIViewController, APIControllerDelegate {
    
    var APIManager = APIController()
    
    var starchanger = Star()
    
    var userRating : Double?
    var gradeimage: UIImage?
    var movieimage : UIImage?
    var id : String!

    var selectmovie : MovieDetail!
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var gradeImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var reservationLabel: UILabel!
    @IBOutlet weak var movieGrade: UILabel!
    @IBOutlet weak var movieNumber: UILabel!
    @IBOutlet weak var movieContent: UITextView!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieActor: UILabel!
    
  
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.gradeImage.image = self.gradeimage
            self.movieImage.image = self.movieimage
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.delegate = self
        starchanger.starGrade(rate: userRating!)
        star1.image = starchanger.star1
        star2.image = starchanger.star2
        star3.image = starchanger.star3
        star4.image = starchanger.star4
        star5.image = starchanger.star5
        
        APIManager.responseAPI(current: "\(Constants.baseURL)movie?id=\(id!)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let next : CommentViewController = segue.destination as? CommentViewController else{
            return
        }
        next.movieID = id
        next.movieName = movieTitle.text
        next.movieGrade = gradeimage
    }
    
    func UpdateView(_ apicontrol: APIController, _ dd: Data) {
        do{
            let apiResponse2 : MovieDetail = try JSONDecoder().decode(MovieDetail.self, from: dd)
            self.selectmovie = apiResponse2.self

            DispatchQueue.main.async {
                self.title = self.selectmovie.title!
                self.movieDate.text =
                    "\(self.selectmovie.date!) 개봉"
                self.movieTitle.text = self.selectmovie.title!
                self.reservationLabel.text = "\(self.selectmovie.reservation_grade!)위 \(self.selectmovie.reservation_rate!)%"
                self.genreLabel.text = "\(self.selectmovie.genre!)/ \(self.selectmovie.duration!)"
                self.movieGrade.text = "\(self.selectmovie.user_rating!)"
                self.movieNumber.text = "\(self.selectmovie.audience!)"
                self.movieContent.text = "줄거리 :\n\n" + "\(self.selectmovie.synopsis!)"
                self.movieDirector.text = "감독 : \(self.selectmovie.director!)"
                self.movieActor.text = "배우 : \(self.selectmovie.actor!)"
            }
           
        }catch(let err){
            print(err.localizedDescription)
        }
    }
}
