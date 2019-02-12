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
    
    
    //var collData = Array<CollectionData>()

    var data = Array<ObjectData>()
    var collectionData = Array<CollectionData>()
    var groupData = Array<CollectionData>()
    
    
    
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
        tableView.separatorStyle = .none

        
        //let ref = Database.database().reference().child("lab")
        searchObject(str: "")
        
 
        
        
    //config.initVC(viewController: self)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func searchObject(str :String){
        let ref = Database.database().reference().child("lab")
        
        ref.observe(.value, with: {(snapshot) in
            //self.stopLoadingDialog()
            
            if(snapshot.hasChildren()){
                var i = 0
                self.data = []
                self.collectionData = []
                self.groupData = []
                
                self.tableView.reloadData()
                
                let cos = snapshot.childSnapshot(forPath: "collection")
                for cosChild in cos.children {
                    
                    let cosSnapA = cosChild as? DataSnapshot
                    let cosSnapB = cosSnapA?.childSnapshot(forPath: "info")
                    if(cosSnapB?.value != nil){
                        let aValue = cosSnapB!.value as? NSDictionary
                        let aEng = aValue?["eng"] as? String ?? ""
                        let aTh = aValue?["thai"] as? String ?? ""
                        let aico = aValue?["url"] as? String ?? ""
                        
                        self.checkCollection(english: aEng, thai: aTh, url: aico, want: str)
                        
                    }
                    
                    
                }
                
                
                let eq = snapshot.childSnapshot(forPath: "equipment")
                for child in eq.children {
                    let snap = child as? DataSnapshot
                    
                    let aa = snap?.childSnapshot(forPath: "info")

                    if(aa?.value != nil){
                        let aValue = aa!.value as? NSDictionary
                        let aEng = aValue?["eng"] as? String ?? ""
                        let aTh = aValue?["thai"] as? String ?? ""
                        let aico = aValue?["icon"] as? String ?? ""
                        
                        self.checkGroup(english: aEng, thai: aTh, url: aico, want: str)

                    }
                    
                    
                    let gro = snap?.childSnapshot(forPath: "group")
                    
                    if(gro!.hasChildren()){
                        for childa in gro!.children {
                            let infoSnap = childa as? DataSnapshot
                            let info = infoSnap?.childSnapshot(forPath: "info")
                            
                            let keys = infoSnap?.key as? String

                            
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
                                        self.checkObj(english: english, thai: thai, url: imageUrl, want: str, key: keys!)
                                    }
                                }
                            }else {
                                self.checkObj(english: english, thai: thai, url: imageUrl, want: str,key :keys!)
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
    
    func checkObj(english :String,thai :String, url :String,want :String,key :String){
        //print(english)
        
        let d = ObjectData.init(english: english, thai: thai, url: url, description: "", type: "",key: key)
        
        if(want.count > 0){
            if(english.index(of: want) != nil || thai.index(of: want) != nil){
                data.append(d)
                self.tableView.reloadData()
            }else {
                self.tableView.reloadData()
            }
        }else {
            //print(english)
            //print(thai)
            data.append(d)
            self.tableView.reloadData()
        }
    }
    
    func checkGroup(english :String,thai :String, url :String,want :String){
        //print(english)
        
        let d = CollectionData.init(english: english, thai: thai, url: url)
        
        if(want.count > 0){
            if(english.index(of: want) != nil || thai.index(of: want) != nil){
                groupData.append(d)
                self.tableView.reloadData()
            }else {
                self.tableView.reloadData()
            }
        }else {
            groupData.append(d)
            self.tableView.reloadData()
        }
 
    }
    
    func checkCollection(english :String,thai :String, url :String,want :String){
        print(english)
        
        let d = CollectionData.init(english: english, thai: thai, url: url)
        
        if(want.count > 0){
            if(english.index(of: want) != nil || thai.index(of: want) != nil){
                collectionData.append(d)
                self.tableView.reloadData()
            }else {
                self.tableView.reloadData()
            }
        }else {
            collectionData.append(d)
            self.tableView.reloadData()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var s :String = searchBar.text!
        //print(s)
        
        //if()
        searchObject(str: s)
        
        view.endEditing(true)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var total = 0
        
        if(collectionData.count > 0){
            total += 1
        }
        
        if(data.count > 0){
            total += (data.count + 1)

        }else {
            total += (data.count)

        }
        return total
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        var pos = indexPath.row - 1
        if(collectionData.count > 0){
            pos -= 1
            
            if(pos >= 0){
                
                let slot = data[pos]

                let vc = MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().DetailViewController) as! DetailViewController
                MainConfig().actionNavVC(this: self, viewController: vc)
                
                vc.name = slot.key
            }else {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: indexPath, animated: false)
                }
            }
        }else {
            if(pos >= 0){
                
                let slot = data[pos]
                
                let vc = MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().DetailViewController) as! DetailViewController
                MainConfig().actionNavVC(this: self, viewController: vc)
                
                vc.name = slot.key
            }else {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: indexPath, animated: false)
                }
            }
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
        var position = 0
        var loadDataCell = false
        var loadCollectionCell = false
        
        if(collectionData.count > 0){
            position += 1
            loadCollectionCell = true
        }
        if(data.count > 0){
            position += 1
            loadDataCell = true
        }
        */
        
        if(collectionData.count > 0){
            if(indexPath.row == 0){
                return collectCell(tableView: tableView, position: indexPath)
            }else if(indexPath.row == 1){
                return objectCell(tableView: tableView, position: indexPath)
            }else {
               return  equipmentCell(tableView: tableView, position: indexPath)
            }
        }else {
            if(indexPath.row == 0){
                return objectCell(tableView: tableView, position: indexPath)
            }else {
                return equipmentCell(tableView: tableView, position: indexPath)
            }
        }
    /*
        
        if(indexPath.row == 0){
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchCollectionTVC", for: indexPath) as! SearchCollectionCell
            
            if(collectionData.count > 0){
                cell.isHidden = false
              cell.controller = self
                cell.data = collectionData
                
            }else {
                cell.isHidden = true
            }
            
            
            return cell
            
        } else if(indexPath.row == 1){
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchObjectTitleTVC", for: indexPath) as! UITableViewCell
        
        
            
            
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchTVC", for: indexPath) as! ObjectCell
            
            let slot = data[indexPath.row - 1]
            
            cell.imag.downloaded(from: slot.url)
            cell.titleLabel.text = slot.thai
            cell.subTitleLabel.text = slot.english
            
            //cell.contentView.backgroundColor = .clear
            
            
            return cell
        }
 */
 
    }
    
    func collectCell(tableView: UITableView,position :IndexPath) -> SearchCollectionCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCollectionTVC", for: position) as! SearchCollectionCell
        
        if(collectionData.count > 0){
            //cell.isHidden = false
            cell.controller = self
            cell.data = collectionData
            
        }
        
        
        return cell
    }
    
    func objectCell(tableView: UITableView,position :IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchObjectTitleTVC", for: position) as! UITableViewCell
        
        
        
        
        return cell
    }
    
    func equipmentCell(tableView: UITableView,position :IndexPath) -> ObjectCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTVC", for: position) as! ObjectCell
        
        var pos = position.row - 1
        
        if(collectionData.count > 0){
            pos -= 1
        }
        
        let slot = data[pos]
        
        cell.imag.downloaded(from: slot.url)
        cell.titleLabel.text = slot.thai
        cell.subTitleLabel.text = slot.english
        
        //cell.contentView.backgroundColor = .clear
        
        
        return cell
    }

}
