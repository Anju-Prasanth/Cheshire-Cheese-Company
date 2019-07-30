//
//  AllreviewsViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 04/07/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Cosmos
import MBProgressHUD

class AllreviewsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var allreview=AllreviewTableViewCell()
    var titlearray=[String]()
    var nicknamearray=[String]()
    var detailarray=[String]()
    var ratingcodearray=[String]()
    var ratingvaluearray=[Double]()
    var datearray=[String]()
    var ratingcode=String()
    var btnreadmoreflag=0
    var skuidreview=String()
    var hud:MBProgressHUD=MBProgressHUD()
    var nameproduct=String()
    var isLabelAtMaxHeight = [Bool]()
    var lblheight=Bool()
    @IBOutlet weak var reviewcount: UILabel!
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var tableviewallreviews: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
       
       
        tableviewallreviews.register(UINib(nibName: "AllreviewTableViewCell", bundle: nil), forCellReuseIdentifier: "AllreviewTableViewCell")

       serviceproductreview()
    }
    

    func backButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        //        button.setImage(UIImage(named: imageName), for: .normal)
        button.setBackgroundImage(UIImage(named: imageName), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width:30, height: 30)
        button.backgroundColor = UIColor.clear
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.addTarget(self, action: selector, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        self.navigationController?.popViewController(animated: true)
    }
    public func numberOfSections(in tableView: UITableView) -> Int
    {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlearray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    allreview=(tableView.dequeueReusableCell(withIdentifier: "AllreviewTableViewCell", for: indexPath) as? AllreviewTableViewCell)!
    //productreview.Outerview.layer.cornerRadius=5
      allreview.lbltitle.text=titlearray[indexPath.row]
        allreview.lbldetail.text=detailarray[indexPath.row]
        allreview.btnprdctreviewreadmore.tag=indexPath.row
        allreview.btnprdctreviewreadmore.addTarget(self, action: #selector(btnprdctreviewreadmoreaction(sender:)), for: .touchUpInside)
        let date = datearray[indexPath.row]
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString : NSDate = dateFormatter.date(from: date)! as NSDate
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let datenew = dateFormatter.string(from: dateFromString as Date)
    
    
   productname.text=nameproduct
   reviewcount.text=String(titlearray.count) + " Reviews"
    allreview.lbldate.text=datenew
    
    
    
    allreview.lblname.text=nicknamearray[indexPath.row]
    
    
    if ratingcodearray[indexPath.row]=="Quality"{
    
    allreview.ratingquality.rating=ratingvaluearray[indexPath.row]
    
    }else if ratingcodearray[indexPath.row]=="Rating"{
    
    
    
    allreview.ratingrtng.rating=ratingvaluearray[indexPath.row]
    
    }else if ratingcodearray[indexPath.row]=="Price"{
    
    allreview.ratingprice.rating=ratingvaluearray[indexPath.row]
    }else if ratingcodearray[indexPath.row]=="Value"{
    allreview.ratingvalue.rating=ratingvaluearray[indexPath.row]
    }
    else{
    
    
    }
//    if btnreadmoreflag==1{
//    allreview.btnprdctreviewreadmore.isHidden=true
//    }else{
//
        if (allreview.lbldetail.text?.count)! > 200{
            
           allreview.btnprdctreviewreadmore.isHidden=false
            if isLabelAtMaxHeight.count != 0 {
            if isLabelAtMaxHeight[indexPath.row] == true {
                allreview.lbldetail.numberOfLines = 0
               allreview.lbldetail.lineBreakMode = NSLineBreakMode.byWordWrapping
            }
            else {
               allreview.lbldetail.numberOfLines = 4
                allreview.lbldetail.lineBreakMode = NSLineBreakMode.byWordWrapping
                
            }
        }
        }else{
            allreview.btnprdctreviewreadmore.isHidden=true
        }
    
       // }
       
    
    return allreview
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableViewAutomaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
       return 255
    }
    
    
    
    
    
    
    
    
    @objc func btnprdctreviewreadmoreaction(sender: UIButton){
        print("selected....")
//        if sender.isSelected{
//        self.allreview.lblreviewheight.constant=67
//
//        }else{
//            sender.isHidden=true
//           // btnreviewreadmoreflag=1
//        self.allreview.lblreviewheight.isActive=false
//            tableviewallreviews.reloadData()
//        }
        
        if isLabelAtMaxHeight[sender.tag]==true{
            sender.setTitle("....Read more", for: .normal)
            isLabelAtMaxHeight.append(false)
            
        }
        else {
            sender.setTitle("....Read less", for: .normal)
            isLabelAtMaxHeight.append(true)
            
        }
        tableviewallreviews.reloadData()
    }
    
        
    
        
    
    
    
    func serviceproductreview(){
        var params=[String:AnyObject]()
         self.showhud()
        params = ["token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc" as  AnyObject,"sku":skuidreview as AnyObject]
        print("stateparams:",params)
        
        guard let url=URL(string :"https://cheshirecheesecompany.co.uk/draft2/rest/V1/capi/reviews")else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("response",response)
            }
            if let data = data {
                print("data",data)
                do {
                    let jsonsignup = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                    print("jsonsignupreview",jsonsignup)
                    for item in jsonsignup{
                        let value : [String:Any] = item as! [String : Any]
                        let sku = value["sku"]
                        print("value",value)
                        let reviews=value["reviews"] as! NSArray
                        print("reviews",reviews)
                        for item in reviews{
                            let value : [String:Any] = item as! [String : Any]
                            let title=value["title"]
                            let detail=value["detail"]
                            let nickname=value["nickname"]
                            let date=value["created_at"]
                            print("title",title)
                            self.titlearray.append(title as! String)
                            self.detailarray.append(detail as! String)
                            self.nicknamearray.append(nickname as! String)
                            
                            
                            self.datearray.append(date as! String)
                            let ratingvotes=value["rating_votes"] as! NSArray
                            print("ratingvotes",ratingvotes)
                            for item in ratingvotes{
                                let value : [String:Any] = item as! [String : Any]
                                self.ratingcode=value["rating_code"] as! String
                                let ratingvalue=value["value"] as! String
                                print("ratingcode",self.ratingcode)
                                self.ratingcodearray.append(self.ratingcode)
                                self.ratingvaluearray.append(Double(ratingvalue)!)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.tableviewallreviews.reloadData()
                    }
                }
                catch{
                    print("Error in parsing")
                }
            }
            }.resume()
    }
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
    
}
