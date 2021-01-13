//
//  ViewController.swift
//  4.MyAlbum
//
//  Created by 홍진석 on 2021/01/11.
//

import UIKit
import Photos


class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    //다음 뷰로 이동 가능여부
    var goNext : Bool?
    
    //버튼정보
    @IBOutlet weak var selectButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var heartButton: UIBarButtonItem!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    @IBOutlet weak var myToolbar: UIToolbar!
    
    //앨범 정보
    var fetchResult :
        PHFetchResult<PHAsset>!
    let imageManager = PHCachingImageManager()
    var cameraRoll : PHFetchResult<PHAssetCollection>!
    
    let flowLayout = UICollectionViewFlowLayout()
    let half : Double  = Double(UIScreen.main.bounds.width/2 - 10)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        myToolbar.isHidden = true
        goNext = true
        
        collectionview.dataSource = self
        collectionview.delegate = self
        
        self.navigationItem.title = "앨범"
        settingFlowlayout()
        checkPermission()

        self.collectionview.reloadData()
    }
    
    //permission 확인
    func checkPermission(){
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus{
        case .authorized :
            print("authorized")
            self.requestCollection()
            self.collectionview.reloadData()
        case .denied :
            print("denied")
        case .notDetermined:
            print("notdetermined.")
            PHPhotoLibrary.requestAuthorization() {
            (status) in
            switch status {
            case .authorized:
                print("User permiited")
                self.requestCollection()
                
                //비동기적으로 실행
                OperationQueue.main.addOperation {
                    self.collectionview.reloadData()
                }
            case .denied:
                print("User denied")
                break
            default:
                break
            }
        }
        case .restricted:
            print("restricted")
            
        default : break
        }
    }
    
    //layout 설정
    func settingFlowlayout(){

        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 30
        flowLayout.minimumInteritemSpacing = 10
        
        flowLayout.itemSize = CGSize(width: half, height: half)
        
        self.collectionview.collectionViewLayout = flowLayout
    }
    
    func requestCollection(){
        
        //카메라롤 목록
        cameraRoll = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        guard let cameraRollColletction = cameraRoll.firstObject else {
            print("cameraRoll error")
            return
        }
        print(cameraRollColletction) //Recents
        
        //정렬 - 최신순
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        //목록 다 가져와서 fetchResult에 저장
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollColletction, options: nil)
    }
    
    //CollectionView
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell else{fatalError()}
        if goNext == false{
            collectionview.allowsMultipleSelection = true
            print("\(cell.photoLabel.text!) 색상해제")
            cell.checkSelected = false
            cell.backgroundColor = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell else{fatalError()}
        
        if goNext == false{
            collectionview.allowsMultipleSelection = true
            print("\(cell.photoLabel.text!) 색상변경")
            cell.checkSelected = true
            cell.backgroundColor = UIColor.lightGray
        }else{
            collectionview.allowsMultipleSelection = false
            performSegue(withIdentifier: "segue", sender: cell)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //cell
        guard let cell : PhotoCollectionViewCell = collectionview.dequeueReusableCell(withReuseIdentifier: "cell" , for: indexPath) as? PhotoCollectionViewCell else{
            print("cell error")
            return UICollectionViewCell()
        }
        
        //let asset : PHAsset = fetchResult.object(at: indexPath.item)
        let asset : PHAsset = fetchResult.object(at: indexPath.item)
        //사진 요청
        imageManager.requestImage(for: asset, targetSize: CGSize(width:50, height: 50), contentMode: .aspectFit, options: nil, resultHandler: {asset, _ in
            let num = indexPath.item + 1
            cell.imageView?.image = asset
            cell.photoLabel.text = "사진" + " \(num)"
        })
        
        //이미지 잘 가져왔는지 확인차
        //cell.backgroundColor = UIColor.black
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let next : PhotoDetailViewController = segue.destination as? PhotoDetailViewController else{return}
                
        guard let cell : PhotoCollectionViewCell = sender as? PhotoCollectionViewCell else{return}
        guard let index : IndexPath = self.collectionview.indexPath(for: cell)else{return}
        
        next.photos = fetchResult
        next.num = index.item
    }
    
    //버튼에 따른 동작들
    @IBAction func selectPhoto(_ sender: Any) {
        if selectButton.title == "선택"{
            selectButton.title = "취소"
            goNext = false
            myToolbar.isHidden = false
        }else{
            selectButton.title = "선택"
            goNext = true
            myToolbar.isHidden = true
            
            for i in 0..<fetchResult.count{
                let checkCell : PhotoCollectionViewCell = collectionview.cellForItem(at: [0,i]) as! PhotoCollectionViewCell
                if checkCell.checkSelected == true{
                    checkCell.checkSelected = false
                    checkCell.backgroundColor = nil
                }
            }
        }
    }
    
    @IBAction func heartPressed(_ sender: Any) {
        if heartButton.image == UIImage(systemName: "heart"){
            heartButton.image = UIImage(systemName: "heart.fill")

        }else{
            heartButton.image = UIImage(systemName: "heart")
        }
    }
    @IBAction func TrashPressed(_ sender: Any) {
        
        var asset = [PHAsset]()
        asset.append(fetchResult.object(at: 1))
        PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.deleteAssets(asset as NSFastEnumeration)}, completionHandler: nil)
    }
    
 
}


