//
//  ThirdViewController.swift
//  2.SignUp
//
//  Created by 홍진석 on 2021/01/06.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func beforeButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func successButton(_ sender: UIButton) {
        let alert =  UIAlertController(title: "알림", message: "가입되었습니다", preferredStyle: .alert)
      
        let success = UIAlertAction(title: "OK", style: .default, handler: nil)

        alert.addAction(success)
        present(alert, animated: true, completion: nil)
    }
}
