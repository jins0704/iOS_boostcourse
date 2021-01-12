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
    var fetchResult =
        [PHFetchResult<PHAsset>]()
    let imageManager = PHCachingImageManager()
    var cameraRoll : PHFetchResult<PHAssetCollection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.dataSource = self
        collectionview.delegate = self
        
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
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        let half : CGFloat = UIScreen.main.bounds.width / 2.0
        flowLayout.itemSize = CGSize(width: half+20, height: 50)
        
        self.collectionview.collectionViewLayout = flowLayout
    }
    
    func requestCollection(){
        
        //앨범 목록
        let Album = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
        print(Album.count)
       
        let AlbumList = Album.objects(at: IndexSet(0..<Album.count))
        
        //정렬 - 최신순
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        //목록 다 가져와서 fetchResult에 저장
        for i in 0..<Album.count{
            fetchResult.append(PHAsset.fetchAssets(in: AlbumList[i], options: fetchOption))
        }
        print(fetchResult.count)
    }
    
    //CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.fetchResult?.count ?? 0
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //cell
        guard let cell : PhotoCollectionViewCell = collectionview.dequeueReusableCell(withReuseIdentifier: "cell" , for: indexPath) as? PhotoCollectionViewCell else{
            print("cell error")
            return UICollectionViewCell()
        }
        
        let asset: PHAsset = fetchResult[indexPath.item].object(at: 0)
        //사진 요청
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil, resultHandler: {asset, _ in
            //cell.imageView?.image = asset
            
        })
        
        //이미지 잘 가져왔는지 확인차
        cell.backgroundColor = UIColor.black
        
        return cell
    }
    
}

