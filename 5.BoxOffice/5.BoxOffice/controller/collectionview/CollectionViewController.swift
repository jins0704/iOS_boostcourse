//
//  CollectionViewController.swift
//  5.BoxOffice
//
//  Created by 홍진석 on 2021/01/19.
//

import UIKit

class CollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var movieList : [Movie]  = []
    
    let flowLayout = UICollectionViewFlowLayout()
    let half : Double  = Double(UIScreen.main.bounds.width/2 - 5)
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    let cellIdentifier = "collectioncell"
    
    override func viewDidAppear(_ animated: Bool) {
        responseAPI(current: currentURL)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie : Movie = self.movieList[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CollectionViewCell else {
                return UICollectionViewCell()
        }
        cell.userRating = movie.user_rating
        
        cell.id = movie.id
        
        cell.detailLabel.text = "\(movie.reservation_grade!)위(\(movie.user_rating!)) / \(movie.reservation_rate!)%"
       
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        settingFlowlayout()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectSorting(_ sender: Any) {
        let optionMenu = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        
        let Action1 = UIAlertAction(title: "예매순위", style: .default, handler: {
                 (alert: UIAlertAction!) -> Void in
            currentURL = "\(baseURL)movies?order_type=0"
            self.responseAPI(current: currentURL)
        })

        let Action2 = UIAlertAction(title: "큐레이션", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
            currentURL = "\(baseURL)movies?order_type=1"
            self.responseAPI(current: currentURL)
        })
      
        let Action3 = UIAlertAction(title: "개봉일", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
            currentURL = "\(baseURL)movies?order_type=2"
            self.responseAPI(current: currentURL)
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

    func responseAPI(current : String){
        guard let url : URL = URL(string: current) else{
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
                    self.movieCollectionView.reloadData()
                }
            }catch(let err){
                print("Error?")
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    func settingFlowlayout(){

           flowLayout.sectionInset = UIEdgeInsets.zero
           flowLayout.minimumLineSpacing = 20
           flowLayout.minimumInteritemSpacing = 10
           
           flowLayout.itemSize = CGSize(width: half, height: half)
           
           self.movieCollectionView.collectionViewLayout = flowLayout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let next : DetailViewController = segue.destination as? DetailViewController else{
            return
        }
        
        guard let cell : CollectionViewCell = sender as? CollectionViewCell else{
            return
        }
        next.id = cell.id
        next.gradeimage = cell.gradeImage.image
        next.movieimage = cell.movieImage.image
        next.userRating = cell.userRating
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
