//
//  FavoriteViewController.swift
//  LabScan
//
//  Created by Android on 18/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FavoriteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var favArr = Array<FavoriteChecklist>()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return favArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let slot = favArr[indexPath.row]
        
        let vc = MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().DetailViewController) as! DetailViewController
        MainConfig().actionNavVC(this: self, viewController: vc)
        
        vc.name = slot.key
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTVC", for: indexPath) as! FavoriteCell
        
        let slot = favArr[indexPath.row]
        
        let ref = Database.database().reference().child("lab").child( "equipment").child("glass").child("group").child(slot.key)
        //self.showLoadingDialog()
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            //self.stopLoadingDialog()
            if(snapshot.hasChildren()){
                
                let info = snapshot.childSnapshot(forPath: "info")
                let thai = info.childSnapshot(forPath: "thai").value as! String
                let eng = info.childSnapshot(forPath: "english").value as! String
                
                cell.titleLabel.text = thai
                cell.subTitleLabel.text = eng
                
                let media = snapshot.childSnapshot(forPath: "media")
                
                var pass = false
                for i in media.children {
                    if(!pass){
                        let ia = i as! DataSnapshot
                        let inf = ia.childSnapshot(forPath: "info").value as! String
                        if(inf == "image"){
                            let url = ia.childSnapshot(forPath: "url").value as! String
                            cell.imv.downloaded(from: url)
                            pass = true
                        }
                    }
                }
                
                
            }
        })
        
        
        
        return cell
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func backAction(_ sender: Any) {
        MainConfig.init().dismissAction(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let config = MainConfig()
        if(config.isIpad()){
            config.initVC(viewController: self)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        
        let ref = Database.database().reference().child("favorite")
        //self.showLoadingDialog()
        
        ref.observe(.value, with: {(snapshot) in
            //self.stopLoadingDialog()
            if(snapshot.hasChildren()){
                
                self.favArr = []
                self.tableView.reloadData()
                
                for i in snapshot.children{
                    let snap = i as! DataSnapshot
                    let check = snap.value as! Bool
                    let key = snap.key as! String
                    
                    if(check){
                        let fav = FavoriteChecklist.init(key: key, check: check)
                        self.favArr.append(fav)
                        self.tableView.reloadData()
                    }
                    
                    
                    
                    
                }
                
            }
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
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
