//
//  PhotoDetailViewController.swift
//  4.MyAlbum
//
//  Created by 홍진석 on 2021/01/12.
//

import UIKit
import Photos

class PhotoDetailViewController: UIViewController{

    var photos :
        PHFetchResult<PHAsset>!
    var num : Int!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "상세이미지"
        
        let asset : PHAsset = photos.object(at: num)
        //사진 요청
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: asset, targetSize: CGSize(width:150, height: 150), contentMode: .aspectFit, options: nil, resultHandler: {asset, _ in self.imageView?.image = asset
            })
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(PhotoDetailViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }
    
    @objc func doPinch(_ pinch:  UIPinchGestureRecognizer){
        imageView.transform = imageView.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1
    }
}

