//
//  DetailCollection.swift
//  LabScan
//
//  Created by Android on 11/2/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DetailCollection: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var snapshot :DataSnapshot? = nil
    //var data = [String():Array<DetailMediaData>()]
    var data = Array<CollectionData>()
    
    var controller :DetailViewController? = nil
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        
        
        for i in data {
            /*
            if(i.info == "image"){
                count += 1
            }
 */
            count+=1
        }
 
        
        /*
         if(slot.info == "image"){
         count =
         }
         */
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCOLL", for: indexPath) as! DetailCollectionCell
        
        let slot = data[indexPath.row]
        
        //if(slot.info == "image"){
            cell.imageView.downloaded(from: slot.url)
        cell.title.text = slot.thai
        cell.subTitle.text = slot.english
        
        //}
        
        return cell
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib.init(nibName: "DetailCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CVCOLL")
        
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
        
    }
    
    func searchSnap(keyword :String) {
        if(self.snapshot != nil){
            
            let collection = self.snapshot!.childSnapshot(forPath: "collection") as! DataSnapshot
            if(collection != nil){
                var i = 0
                if(collection.childrenCount > 0){
                    data = []
                    for child in collection.children {
                        //let coll = child as? DataSnapshot
                        let coll = child as? DataSnapshot
                        //let id = coll?.key as! String
                        //print(id)
                        
                        let a = coll?.childSnapshot(forPath: "member")
                        
                        let b = coll?.childSnapshot(forPath: "info")
                        let c = b!.value as? NSDictionary
                        let en = c?["eng"] as? String ?? ""
                        let th = c?["thai"] as? String ?? ""
                        //let ty = c?["type"] as? String ?? ""
                        let ur = c?["url"] as? String ?? ""
                        
                        
                        if(a != nil){
                            if(a!.childrenCount > 0){
                                
                                for point in a!.children {
                                    let colls = point as? DataSnapshot
                                    let value = colls!.value as? NSDictionary
                                    let mainPath = value?["mainPath"] as? String ?? ""
                                    let subPath = value?["subPath"] as? String ?? ""
                                    
                                    if(subPath == keyword){
                                        let w = CollectionData.init(english: en, thai: th, url: ur)
                                        data.append(w)
                                    }
                                    
                                    //print(subPath)
                                    //print(keyword)
                                    
                                    //let ids = colls?.key as! String
                                    //print(ids)
                                }
                                
                            }
                        }
                        
                       i+=1
                        if(i == collection.childrenCount){
                            collectionView.reloadData()
                        }
                        
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
