//
//  WriteCommentViewController.swift
//  5.BoxOffice
//
//  Created by 홍진석 on 2021/01/17.
//

import UIKit

class WriteCommentViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    var starchanger = Star()

    var textCheck = 0
    var movieName : String?
    var gradeImage : UIImage?
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var gradeText: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var grade: UIImageView!
    @IBOutlet weak var completeButton: UIBarButtonItem!
    
    @IBOutlet weak var nicknameLabel: UITextField!
    @IBOutlet weak var commentField: UITextView!
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textCheck == 0{
            textView.text = nil
            textCheck += 1
        }
    }

    override func viewDidLoad() {
        nameLabel.text = movieName
        grade.image =  gradeImage
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        commentField.delegate = self
        gradeText.delegate = self
        completeButton.isEnabled = false
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let grade = Double(gradeText.text!) else{
            return
        }
        if grade <= 10 && grade >= 0{
            completeButton.isEnabled = true
            starchanger.starGrade(rate: grade)
            star1.image = starchanger.star1
            star2.image = starchanger.star2
            star3.image = starchanger.star3
            star4.image = starchanger.star4
            star5.image = starchanger.star5
        }else{
            completeButton.isEnabled = false
            star1.image = #imageLiteral(resourceName: "ic_star_large")
            star2.image = #imageLiteral(resourceName: "ic_star_large")
            star3.image = #imageLiteral(resourceName: "ic_star_large")
            star4.image = #imageLiteral(resourceName: "ic_star_large")
            star5.image = #imageLiteral(resourceName: "ic_star_large")

        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
