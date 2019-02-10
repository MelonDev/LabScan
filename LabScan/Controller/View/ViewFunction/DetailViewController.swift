//
//  DetailViewController.swift
//  LabScan
//
//  Created by Android on 10/2/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DetailViewController: UIViewController {
    
    let alert = UIAlertController(title: nil, message: "กำลังโหลดข้อมูล...", preferredStyle: .alert)
    @IBOutlet weak var tableView: UITableView!
    
    var shareSnapshot :DataSnapshot? = nil
    var alertStatus = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = MainConfig()
        config.initVC(viewController: self)
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        //tableView.register(UINib.init(nibName: "DetailTitle", bundle: nil), forCellReuseIdentifier: "DetailTVCS")
        //tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
        
        /*
         collectionView.register(UINib.init(nibName: "DetailTitle", bundle: nil), forCellWithReuseIdentifier: "DetailCVC")
         
         let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         //layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
         layout.itemSize = CGSize(width: collectionView.bounds.width, height: 100)
         layout.scrollDirection = .vertical
         layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 10
         collectionView.collectionViewLayout = layout
         
         collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
         
         //let vc = DetailMain()
         collectionView.delegate = self
         collectionView.dataSource = self
         */
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "SukhumvitSet-Bold", size: 20)!]
        self.navigationController?.navigationBar.largeTitleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                              NSAttributedString.Key.font: UIFont(name: "SukhumvitSet-Bold", size: 36)!]
        
        self.navigationController?.setNavigationBarBorderColor(.clear)
        
        
        let cancelButton = UIBarButtonItem.init(title: "ย้อนกลับ", style: .plain, target: self, action: #selector(cancelAction))
        
        cancelButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "SukhumvitSet-Bold", size: 18.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 255/255)],
                                            for: .normal)
        
        self.navigationItem.leftBarButtonItem = cancelButton
        
        
    }
    
    
    
    func showLoadingDialog() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        self.alertStatus = true
    }
    
    func stopLoadingDialog() {
        MainConfig.init().dismissAction(viewController: alert)
        self.alertStatus = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        MainConfig.init().darkStatusBar(animated: animated)
        
        if(navigationItem.title?.count == 0){
            showLoadingDialog()
        }else if(self.alertStatus){
            stopLoadingDialog()
        }
        
        let ref = Database.database().reference().child("lab").child("equipment").child("glass")
        //self.showLoadingDialog()
        ref.observe(.value, with: {(snapshot) in
            //self.stopLoadingDialog()
            if(snapshot.hasChildren()){
                
                let a = snapshot.childSnapshot(forPath: "Beaker").childSnapshot(forPath: "info")
                
                let thai = a.childSnapshot(forPath: "thai").value as! String
                //let english = a.childSnapshot(forPath: "english").value as! String
                //let des = a.childSnapshot(forPath: "description").value as! String
                //let thai = b.value as! String
                
                self.navigationItem.title = thai
                
                self.shareSnapshot = snapshot
                self.tableView.reloadData()
                
                if(self.alertStatus){
                    self.stopLoadingDialog()
                }

                //self.engName.text = english
                //self.desLabel.text = "\(des)\n\(des)\n\(des)\n\(des)"\
                //self.desLabel.text = "     \(des)"
                //self.setTextWithReload(label: self.desLabel, text: "     \(des)")
                
                //self.scrollView.updateContentView()
                
            }
        })
    }
    
    func setTextWithReload(label :UILabel,text :String) {
        label.text = text
        //print(text)
        //resetScrollView()
        //self.scrollView.updateContentView()
        
    }
    
    @objc func cancelAction(sender: AnyObject) {
        MainConfig.init().dismissAction(viewController: self)
        
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

extension DetailViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.tableView){
            return 3

        }else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTVC", for: indexPath) as! TableDetailTitle
            
            if(shareSnapshot != nil){
                let a = shareSnapshot!.childSnapshot(forPath: "Beaker").childSnapshot(forPath: "info")
                let english = a.childSnapshot(forPath: "english").value as! String
                
                cell.label.text = english
            }
            
            
            //cell.contentView.backgroundColor = .clear
            
            
            return cell
        }else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTVCS", for: indexPath) as! DetailDescription
            
            if(shareSnapshot != nil){
                let a = shareSnapshot!.childSnapshot(forPath: "Beaker").childSnapshot(forPath: "info")
                let des = a.childSnapshot(forPath: "description").value as! String
                
                cell.label.text = "     \(des)"
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailImageTVC", for: indexPath) as! DetailImage
            
            /*
            if(shareSnapshot != nil){
                let a = shareSnapshot!.childSnapshot(forPath: "Beaker").childSnapshot(forPath: "info")
                let des = a.childSnapshot(forPath: "description").value as! String
                
                //cell.label.text = "     \(des)"
            }
 */
            
            return cell
        }
        
        /*if(indexPath.row == 0){
         let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCVC", for: indexPath) as! TableDetailTitle
         
         return cell
         }else{
         let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCVC", for: indexPath) as! TableDetailTitle
         
         return cell
         }*/
        
    }
    
    
}

/*
 extension DetailViewController :UICollectionViewDelegate,UICollectionViewDataSource {
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 return 10
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCVC", for: indexPath) as! DetailTitle
 
 
 /*if(indexPath == 0){
 
 }*/
 
 //cell.content.frame.height = 100.0
 
 
 return cell
 }
 
 func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
 return 1
 }
 
 
 func collectionView(_ collectionView: UICollectionView,
 layout collectionViewLayout: UICollectionViewLayout,
 sizeForItemAt indexPath: IndexPath) -> CGSize {
 
 
 let kWhateverHeightYouWant = 300
 return CGSize(width: collectionView.bounds.size.width, height: CGFloat(kWhateverHeightYouWant))
 }
 
 
 
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
 /*
 let vc = MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().DetailViewController) as! DetailViewController
 MainConfig().actionNavVC(this: self, viewController: vc)
 */
 
 
 }
 
 
 
 }
 */


