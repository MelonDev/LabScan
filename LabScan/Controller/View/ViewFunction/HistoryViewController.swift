//
//  HistoryViewController.swift
//  LabScan
//
//  Created by Android on 18/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var data = Array<CollectData>()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTVC", for: indexPath) as! UITableViewCell
        
        let slot = data[indexPath.row]

        
        cell.textLabel?.text = slot.thai
        cell.textLabel?.font = UIFont(name:"Sukhumvit Set", size: 20.0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let slot = data[indexPath.row]
        
        
        let vc = MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().DetailViewController) as! DetailViewController
        MainConfig().actionNavVC(this: self, viewController: vc)
        
        vc.name = slot.key
    }
    
    
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBAction func backBtn(_ sender: Any) {
        MainConfig.init().dismissAction(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let config = MainConfig()
        config.initVC(viewController: self)
        
        if(MainConfig.init().isIpad()){
            self.titleLabel.hero.id = "TITLE_H"
        }else {
            self.titleLabel.hero.id = "TITLE"
        }
        //self.view.backgroundColor = UIColor.white
        
        let topView = UIView(frame:CGRect(x: 0,y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50))
        topView.backgroundColor = UIColor.white
        self.view.insertSubview(topView, at: 0)
        
        //tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        let ref = Database.database().reference().child("history").child("chaiwiwat")
        
        ref.observe(.value, with: {(snapshot) in
            //self.stopLoadingDialog()
            if(snapshot.hasChildren()){
                var i = 0
                self.data = []
                for child in snapshot.children {
                    let snap = child as? DataSnapshot
                    //let id = snap?.key as! String
                    //print(id)
                    
                    let value = snap!.value as? NSDictionary
                    let thai = value?["thai"] as? String ?? ""
                    let eng = value?["english"] as? String ?? ""
                    let key = value?["key"] as? String ?? ""


                    
                    let wa = CollectData.init(english: eng, thai: thai, url: "", key: key)
                    
                    self.data.append(wa)
                    
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
        
        
        
        
        

        /*
        if(!MainConfig.init().isIpad()){
            self.contentView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        }
        */
        
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] 

       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         contentView.hero.modifiers = [.translate(y: UIScreen.main.bounds.height), .useGlobalCoordinateSpace]
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
        MainConfig.init().lightStatusBar(animated: animated)
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


