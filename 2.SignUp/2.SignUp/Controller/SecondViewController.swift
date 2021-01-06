//
//  SecondViewController.swift
//  2.SignUp
//
//  Created by 홍진석 on 2021/01/06.
//

import UIKit


class SecondViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imageController = UIImagePickerController()
    
    //MARK: -IBOulet
    @IBOutlet weak var IDLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var checkLabel: UITextField!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        NextButton.isEnabled = false
        IDLabel.delegate = self
        passwordLabel.delegate = self
        checkLabel.delegate = self
        imageController.delegate = self
    }

    //MARK: - func
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = IDLabel.text else{return false}
        
        if text.count == 10{
            return false
        }
        return true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage]{
            imageView.image = selectedImage as? UIImage
        }
        
        dismiss(animated: true, completion: nil)
    }

    func openLibrary(){
        imageController.sourceType = .photoLibrary
        imageController.allowsEditing = true
        present(imageController, animated: false, completion: nil)

    }

    func openCamera(){
        imageController.sourceType = .camera
        imageController.allowsEditing = true
        present(imageController, animated: false, completion: nil)
    }

    func ButtonState() -> Bool{
        guard let password = passwordLabel.text else{return false}
        
        if password == checkLabel.text{
            if password.count >= 1{
                return true
            }
        }
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        NextButton.isEnabled = ButtonState()
    }

    //MARK: -IBAction
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageButton(_ sender: UIButton) {
        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)
      
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.openLibrary()
        }
      
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
       
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }
}
