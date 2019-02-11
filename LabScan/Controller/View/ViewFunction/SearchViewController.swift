//
//  SearchViewController.swift
//  LabScan
//
//  Created by Android on 18/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchViewController: UIViewController, UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {
    
    
    
    var data = Array<ObjectData>()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBAction func backAction(_ sender: Any) {
        MainConfig.init().dismissAction(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        //tableView.delegate = self
        //tableView.dataSource = self
        

        let config = MainConfig()
        tableView.delegate = self
        tableView.dataSource = self
        
        //let ref = Database.database().reference().child("lab")
        searchObject(str: "")
        
 
        
        
    //config.initVC(viewController: self)
        
        // Do any additional setup after loading the view.
    }
    
    func searchObject(str :String){
        let ref = Database.database().reference().child("lab")
        
        ref.observe(.value, with: {(snapshot) in
            //self.stopLoadingDialog()
            
            if(snapshot.hasChildren()){
                var i = 0
                self.data = []
                self.tableView.reloadData()
                
                
                let eq = snapshot.childSnapshot(forPath: "equipment")
                for child in eq.children {
                    let snap = child as? DataSnapshot
                    
                    
                    
                    
                    let gro = snap?.childSnapshot(forPath: "group")
                    
                    if(gro!.hasChildren()){
                        for childa in gro!.children {
                            let infoSnap = childa as? DataSnapshot
                            let info = infoSnap?.childSnapshot(forPath: "info")
                            
                            let value = info!.value as? NSDictionary
                            let english = value?["english"] as? String ?? ""
                            let thai = value?["thai"] as? String ?? ""
                            
                            let media = infoSnap?.childSnapshot(forPath: "media")
                            var imageUrl = ""
                            
                            var pass = false
                            
                            if(media!.childrenCount > 0){
                                var y = 0
                                for iwa in media!.children {
                                    if(!pass){
                                        let iwas = iwa as? DataSnapshot
                                        
                                        let valueMedia = iwas!.value as? NSDictionary
                                        let mediaInfo = valueMedia?["info"] as? String ?? ""
                                        let mediaUrl = valueMedia?["url"] as? String ?? ""
                                        
                                        if(mediaInfo == "image"){
                                            imageUrl = mediaUrl
                                            //print(imageUrl)
                                            pass = true
                                        }
                                    }
                                    y+=1
                                    if(y == media!.childrenCount){
                                        self.checkObj(english: english, thai: thai, url: imageUrl, want: str)
                                    }
                                }
                            }else {
                                self.checkObj(english: english, thai: thai, url: imageUrl, want: str)
                            }
                            
                            
                            
                            
                            
                            
                        }
                    }
                    
                    
                    
                    
                    //print(id)
                    
                    //let value = snap!.value as? NSDictionary
                    //let name = value?["name"] as? String ?? ""
                    
                    //self.data.append(name)
                    
                    
                    if(i == snapshot.childrenCount - 1){
                        self.tableView.reloadData()
                        
                    }
                    i+=1
                    
                    
                    
                }
                
                //self.engName.text = english
                //self.desLabel.text = "\(des)\n\(des)\n\(des)\n\(des)"\
                //self.desLabel.text = "     \(des)"
                //self.setTextWithReload(label: self.desLabel, text: "     \(des)")
                
                //self.scrollView.updateContentView()
                
            }
        })
    }
    
    func checkObj(english :String,thai :String, url :String,want :String){
        print(english)
        
        let d = ObjectData.init(english: english, thai: thai, url: url, description: "", type: "")
        
        if(want.count > 0){
            if(english.index(of: want) != nil || thai.index(of: want) != nil){
                data.append(d)
                self.tableView.reloadData()
            }
        }else {
            data.append(d)
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var s :String = searchBar.text!
        //print(s)
        
        //if()
        searchObject(str: s)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
        //return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchTVC", for: indexPath) as! ObjectCell
        
        let slot = data[indexPath.row]
        
            cell.imag.downloaded(from: slot.url)
        cell.titleLabel.text = slot.thai
        cell.subTitleLabel.text = slot.english
            
            //cell.contentView.backgroundColor = .clear
            
            
            return cell
        //}else {
    }

}
