//
//  ViewController.swift
//  4.MyAlbum
//
//  Created by 홍진석 on 2021/01/11.
//

import UIKit
import Photos


class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet weak var photocollection: UICollectionView!
    var allPhotos : [PHFetchResult<PHAsset>] = [] // 앨범 정보
    var imageManager = PHCachingImageManager() // 앨범에서 받아오기 위한 객체
    var fetchOptions: PHFetchOptions {
        let fetchOptions = PHFetchOptions()
       fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
       return fetchOptions
    }//옵션
    var photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
    var flowLayout : UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        settingFlowlayout()
        check()
        
        photocollection.dataSource = self
        photocollection.delegate = self
        
    }
    
    func check(){
        switch self.photoAuthorizationStatus{
        case .authorized :
            print("authorized")
            self.requestCollection()
        case .denied :
            print("denied")
        case .notDetermined :
            print("notDetermined")
        case .restricted:
            print("restricted")
        default : break
        }
    }
    
    func settingFlowlayout(){
        self.flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        let half : CGFloat = UIScreen.main.bounds.width / 2.0
        flowLayout.estimatedItemSize = CGSize(width: half-30, height: 90)
        self.photocollection.collectionViewLayout = flowLayout
    }
    
    func requestCollection(){
        let cameraRoll = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        addAlbums(collection: cameraRoll)
        
        OperationQueue.main.addOperation {
                self.photocollection.reloadData()
        }
        
        fetchOptions.sortDescriptors = [NSSortDescriptor(key : "creationDate", ascending: false)]
    }
    
    private func addAlbums(collection : PHFetchResult<PHAssetCollection>){
        for i in 0 ..< collection.count {
            let collection = collection.object(at: i)
            self.allPhotos.append(PHAsset.fetchAssets(in: collection, options: fetchOptions))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = photocollection.dequeueReusableCell(withReuseIdentifier: "cell" , for: indexPath) as! PhotoCollectionViewCell
        guard let asset = allPhotos[indexPath.row].firstObject else{
            return UICollectionViewCell()
        }
       
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 50, height: 50), contentMode: .aspectFill, options: nil, resultHandler: {image, _ in cell.imageView.image = image})
        cell.backgroundColor = UIColor.black
        
        return cell
    }
    
}

