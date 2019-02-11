//
//  DetailImage.swift
//  LabScan
//
//  Created by Android on 10/2/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DetailImage: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var snapshot :DataSnapshot? = nil
    //var data = [String():Array<DetailMediaData>()]
    var data = Array<DetailMediaData>()
    
    var controller :DetailViewController? = nil
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //let slot = data[indexPath.row]
        
        var count = 0
        
        for i in data {
            if(i.info == "image"){
                count += 1
            }
        }
        
        /*
        if(slot.info == "image"){
            count =
        }
        */
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVIMAGE", for: indexPath) as! DetailImageCell
        
        let slot = data[indexPath.row]
        
        if(slot.info == "image"){
            cell.imageView.downloaded(from: slot.url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let viewController = ImagePreviewViewController(nibName: "YourViewController", bundle: nil)
        let vc = MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().ImagePreviewViewController) as! ImagePreviewViewController
        //let vc = ImagePreviewViewController()
        
        vc.url = data[indexPath.row].url
        
        
        if(self.controller != nil){
            self.controller?.navigationController?.pushViewController(vc, animated: true)
            //vc.reloadView()
        }
        
        
        //let vc = MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().DetailViewController) as! DetailViewController
        //MainConfig().actionNavVC(this: self, viewController: vc)
        
        
        
    }
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        collectionView.register(UINib.init(nibName: "DetailImageCell", bundle: nil), forCellWithReuseIdentifier: "CVIMAGE")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: 120, height: collectionView.bounds.height - 30)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //let a = shareSnapshot!.childSnapshot(forPath: "Beaker").childSnapshot(forPath: "media")
        //let des = a.childSnapshot(forPath: "description").value as! String
        
        //self.data["รายชื่อ"] = []
        
        
        
        
        // Initialization code
    }
    
    func loadSnap() {
        if(self.snapshot != nil){
            
            let media = self.snapshot!.childSnapshot(forPath: "media") as! DataSnapshot
            if(media != nil){
                var i = 0
                if(media.childrenCount > 0){
                    data = []
                    for child in media.children {
                        let snap = child as? DataSnapshot
                        //let id = snap?.key as! String
                        //print(id)
                        
                        let value = snap!.value as? NSDictionary
                          let info = value?["info"] as? String ?? ""
                        let url = value?["url"] as? String ?? ""

                        let detail = DetailMediaData.init(info: info, url: url)

                        data.append(detail)
                        
                         if(i == media.childrenCount - 1){
                         self.collectionView.reloadData()
                         
                         }
                         i+=1
                        
                        
                        
                    }
                }else {
                    print("Hello")
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
