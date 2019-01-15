//
//  MainIphoneViewController.swift
//  LabScan
//
//  Created by Android on 14/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit

class MainIphoneViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var menuPageCon: UIPageControl!
    @IBOutlet weak var menuCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollection.register(UINib.init(nibName: "MenuiPhoneCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "menuIphoneCell")
        
        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 70.0, height: menuCollection.frame.size.height + 100)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.8
        floawLayout.sideItemAlpha = 0.6
        floawLayout.spacingMode = .fixed(spacing: 5.0)
        //floawLayout.spacingMode = .overlap(visibleOffset: 5.0)
        menuCollection.collectionViewLayout = floawLayout
        
        menuCollection.delegate = self
        menuCollection.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.navigationController?.navigationBar.barTintColor = UIColor.white
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        //self.navigationItem.largeTitleDisplayMode = .always
        //self.navigationItem.title = "LABScan"
        
        
        
        //self.navigationItem.rightBarButtonItem = confirmAction

        
        //self.viewInnerScroll.backgroundColor = UIColor.init(red: 239/255, green: 239/255, blue: 239/255, alpha: 255/255)
        self.view.backgroundColor = UIColor.init(red: 239/255, green: 239/255, blue: 239/255, alpha: 255/255)
        
        
        //self.viewInnerScroll.backgroundColor = UIColor.white
       

    }
    
    @objc func confirmTapped(sender: AnyObject) {
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let size = 5
        
        self.menuPageCon.numberOfPages = size
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = menuCollection.dequeueReusableCell(withReuseIdentifier: "menuIphoneCell", for: indexPath) as! MenuiPhoneCollectionViewCell
        
        //cell.lblTitle.text = "TItle - \(indexPath.row + 1)"
        //cell.lblTitle.text = "Sub TItle - \(indexPath.row + 1)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("itm selected == \(indexPath.row)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let layout = self.menuCollection.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        testCurrentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.menuCollection.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    fileprivate var currentPage: Int = 0 {
        didSet {
            //self.menuPageCon.currentPage = currentPage
            //print("page at centre = \(currentPage)")
        }
    }
    
    fileprivate var testCurrentPage: Int = 0 {
        didSet {
            self.menuPageCon.currentPage = testCurrentPage
            //print("page at center = \(testCurrentPage)")
        }
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.menuCollection.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        //print(pageSize.height)
        
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
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
