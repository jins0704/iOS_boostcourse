//
//  APIcontroller.swift
//  5.BoxOffice
//
//  Created by 홍진석 on 2021/01/27.
//

import Foundation

protocol APIControllerDelegate{
    func UpdateView(_ apicontrol : APIController, _ dd : Data)
}

struct APIController{
    
    var delegate : APIControllerDelegate?
    var currentURL : String?
    
   func responseAPI(current : String){
        guard let url : URL = URL(string: current) else{return}
        
        let session : URLSession = URLSession(configuration: .default)
        let dataTask : URLSessionDataTask = session.dataTask(with: url){
            (data: Data?, response : URLResponse?, error: Error?) in
            
            if let error = error{
                print(error)
                return
            }
            
            guard let data = data else{return}
            
            self.delegate?.UpdateView(self,data)
        }
        dataTask.resume()
    }
}
