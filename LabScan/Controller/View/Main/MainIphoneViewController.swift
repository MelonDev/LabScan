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
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 70.0, height: menuCollection.frame.size.height + (((UIScreen.main.bounds.size.width / menuCollection.frame.size.height)*100) * (UIScreen.main.bounds.size.width / menuCollection.frame.size.height) ))
        
        //print(menuCollection.frame.size.height)
    //print(UIScreen.main.bounds.size.width)
        //print()
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
        UIApplication.shared.setStatusBarStyle(.default, animated: animated)

        
        //self.viewInnerScroll.backgroundColor = UIColor.white
       

    }
    
    @objc func confirmTapped(sender: AnyObject) {
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let size = data().count
        
        self.menuPageCon.numberOfPages = size
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = menuCollection.dequeueReusableCell(withReuseIdentifier: "menuIphoneCell", for: indexPath) as! MenuiPhoneCollectionViewCell
        
        let slot = data()[indexPath.row]
        
        if(slot.imageBg != nil){
            cell.cellImageBg.image = slot.imageBg
        }
        if(slot.color != nil){
            cell.cellView.backgroundColor = slot.color
        }
        if(slot.description != nil){
            cell.cellDesciption.text = slot.description
        }else {
            cell.cellDesciption.text = ""
        }
        cell.cellTitle.text = slot.title
        if(slot.colorLabel != nil){
            cell.cellTitle.textColor = slot.colorLabel
            cell.cellDesciption.textColor = slot.colorLabel?.withAlphaComponent(0.7)
        }
        if(slot.image != nil){
            cell.cellIcon.image = slot.image
        }
        
        
        //cell.lblTitle.text = "TItle - \(indexPath.row + 1)"
        //cell.lblTitle.text = "Sub TItle - \(indexPath.row + 1)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let slot = data()[indexPath.row]
        
        //let storyboard = UIStoryboard(name: "AppStoryboard", bundle: nil)
        //let vc = storyboard.instantiateViewController(withIdentifier: "testAppVC") as! TestAppViewController
        
        let vc = MainConfig().requireViewController(storyboard: "AppStoryboard", viewController: "testAppVC") as! TestAppViewController


        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "testVC") as! TestViewController
        
        
        
        //vc.modalPresentationStyle = .popover
        
        //let aObjNavi = UINavigationController(rootViewController: vc)
        //aObjNavi.modalPresentationStyle = UIModalPresentationStyle.formSheet
        //aObjNavi.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        //self.hero.isEnabled = true
        //self.present(aObjNavi, animated: true, completion: nil)
        
        vc.bgColor = slot.color
        
        vc.isHeroEnabled = true
        self.present(vc, animated: true, completion: nil)

        
        //print("itm selected == \(indexPath.row)")
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
    
    func data() -> [MenuStruct] {
        
        let menu = [
            MenuStruct(imageBg: #imageLiteral(resourceName: "menu_wall_1_plus"), title: "สแกนอุปกรณ์", image: nil,color :nil,description :"เปิดกล้องเพื่อสแกน",colorLabel :UIColor.init(red: 77/255, green: 64/255, blue: 40/255, alpha: 1)),
            MenuStruct(imageBg: nil, title: "หมวดหมู่", image: #imageLiteral(resourceName: "bookshelf"),color :UIColor.init(red: 186/255, green: 50/255, blue: 50/255, alpha: 1),description :"อุปกรณ์การทดลองวิทยาศาสตร์",colorLabel :UIColor.white),
            MenuStruct(imageBg: nil, title: "ประวัติ", image: #imageLiteral(resourceName: "history-clock-button"),color :UIColor.init(red: 74/255, green: 54/255, blue: 202/255, alpha: 1),description :"การค้นหา",colorLabel: UIColor.white)

            //MenuStruct(imageBg: #imageLiteral(resourceName: "menu_wall_1"), title: "สแกนอุปกรณ์", image: #imageLiteral(resourceName: "9"))

        ]
        
        return menu
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
