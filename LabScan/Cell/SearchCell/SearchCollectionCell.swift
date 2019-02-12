//
//  SearchCollectionCell.swift
//  LabScan
//
//  Created by Android on 12/2/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit

class SearchCollectionCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var data = Array<CollectionData>()
    var controller :SearchViewController? = nil
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCV", for: indexPath) as! DetailCollectionCell
        
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

        collectionView.register(UINib.init(nibName: "DetailCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCV")
        
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
