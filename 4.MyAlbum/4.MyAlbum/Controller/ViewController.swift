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
    
    //앨범 정보
    var fetchResult :
        PHFetchResult<PHAsset>!
    let imageManager = PHCachingImageManager()
    var cameraRoll : PHFetchResult<PHAssetCollection>!
    
    let flowLayout = UICollectionViewFlowLayout()
    let half : Double  = Double(UIScreen.main.bounds.width/2 - 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        print(cameraRoll.count)
        guard let cameraRollColletction = cameraRoll.firstObject else {
            print("cameraRoll error")
            return
        }
        
        //정렬 - 최신순
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        //목록 다 가져와서 fetchResult에 저장
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollColletction, options: nil)
        
        print(fetchResult.count)
    }
    
    //CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //cell
        guard let cell : PhotoCollectionViewCell = collectionview.dequeueReusableCell(withReuseIdentifier: "cell" , for: indexPath) as? PhotoCollectionViewCell else{
            print("cell error")
            return UICollectionViewCell()
        }
        
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
}


