//
//  OrderinfrmtnViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 25/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import MBProgressHUD

//struct shippingAddress1{
//    let company : String
//    let firstname : String
//    let middlename : String
//    let lastname : String
//    let telephone : String
//    let street : String
//    let city : String
//    let postcode : String
//    init(shippinginfo :[String:Any]) {
//        company = shippinginfo["company"] as? String ?? ""
//        firstname = shippinginfo["firstname"] as? String ?? ""
//        lastname = shippinginfo["lastname"] as? String ?? ""
//        middlename = shippinginfo["middlename"] as? String ?? ""
//        telephone = shippinginfo["telephone"] as? String ?? ""
//        street = shippinginfo["street"] as? String ?? ""
//        city = shippinginfo["city"] as? String ?? ""
//        postcode = shippinginfo["postcode"] as? String ?? ""
//    }
//}
//
//struct billingAddress1{
//    let company : String
//    let firstname : String
//    let middlename : String
//    let lastname : String
//    let telephone : String
//    let street : String
//    let city : String
//    let postcode : String
//    init(billinginfo :[String:Any]) {
//        company = billinginfo["company"] as? String ?? ""
//        firstname = billinginfo["firstname"] as? String ?? ""
//        middlename = billinginfo["middlename"] as? String ?? ""
//        lastname = billinginfo["lastname"] as? String ?? ""
//        telephone = billinginfo["telephone"] as? String ?? ""
//        street = billinginfo["street"] as? String ?? ""
//        city = billinginfo["city"] as? String ?? ""
//        postcode = billinginfo["postcode"] as? String ?? ""
//    }
//}

class OrderinfrmtnViewController: UIViewController {
    var header:UIImageView!
    var informtn=InformationTableViewCell()
    var shpngadrs=InfrmtnshpngadrsTableViewCell()
    var billingadrs=InfrmtnadrsTableViewCell()
    var shpngmethod=InfrmtnshpnngmethodTableViewCell()
    var hud:MBProgressHUD=MBProgressHUD()
    var shipingmethod=String()
    var firstname:String!
    
    
//    var shpngnamearray=[String]()
//    var shpngstreetarray=[String]()
//    var shpngcityarray=[String]()
//    var shpngcompanyarray=[String]()
//    var shpngpostcodearray=[String]()
//    var  billingnamearray=[String]()
//    var billingstreetarray=[String]()
//    var billingcityarray=[String]()
//    var billingcompanyarray=[String]()
//    var billingpostcodearray=[String]()
//    var infrmtnorderincrementid=String()
    
    

    @IBOutlet weak var tablevieworderinfrmtn: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        let logo = UIImage(named: "logo")
//        header = UIImageView(image: logo)
//        header.contentMode = .scaleAspectFit // set imageview's content mode
//        header.frame = CGRect(x:50, y:0, width: 60, height:40)
//        self.navigationController?.navigationBar.addSubview(header)
        // let backlogoimage=UIImage (named: "back")
//        let searchlogoimage = UIImage (named: "icon-1")
//        let cartlogoimage = UIImage (named: "shoppingcart")
//        let loginlogoimage = UIImage (named: "icon-3")
//        let btnsearch = UIBarButtonItem (image: searchlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.searchaction))
//        let btncart = UIBarButtonItem (image: cartlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.cartaction))
//        let btnlogin = UIBarButtonItem (image: loginlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.loginaction))
//        navigationItem.setRightBarButtonItems([btnlogin,btncart,btnsearch], animated: true)
        
        
        
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        
//
//        tablevieworderinfrmtn.register(UINib(nibName: "InformationTableViewCell", bundle: nil), forCellReuseIdentifier: "InformationTableViewCell")
//        tablevieworderinfrmtn.register(UINib(nibName: "InfrmtnshpngadrsTableViewCell", bundle: nil), forCellReuseIdentifier: "InfrmtnshpngadrsTableViewCell")
//        tablevieworderinfrmtn.register(UINib(nibName: "InfrmtnadrsTableViewCell", bundle: nil), forCellReuseIdentifier: "InfrmtnadrsTableViewCell")
//        tablevieworderinfrmtn.register(UINib(nibName: "InfrmtnshpnngmethodTableViewCell", bundle: nil), forCellReuseIdentifier: "InfrmtnshpnngmethodTableViewCell")
        //        viewtoolbar.layer.cornerRadius=5
        //        searchbar.isHidden=true
        //servicecustomerinfobyemail()
      
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
    
    @objc func loginaction(){
        if firstname != nil && firstname != "Hi Guest"{
            let myaccount = self.storyboard?.instantiateViewController (withIdentifier: "MyAccountViewController") as! MyAccountViewController
            //header.removeFromSuperview()
            self.navigationController?.pushViewController(myaccount, animated: true)
        }else{
            let signin = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
            //header.removeFromSuperview()
            self.navigationController?.pushViewController(signin, animated: true)
        }
        
    }
    
    @objc func searchaction(){
        //        if searchbar.isHidden==true{
        //            searchbar.isHidden=false
        //        }else{
        //            searchbar.isHidden=true
        //        }
        
    }
    
    @objc func cartaction(){
        let mybag = self.storyboard?.instantiateViewController (withIdentifier: "MyBagViewController") as! MyBagViewController
        //header.removeFromSuperview()
        self.navigationController?.pushViewController(mybag, animated: false)
    }
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return 4
        
    }
    
   // func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section==0{
//            return 1
//        }else if section==1{
//            return shpngnamearray.count
//        } else if section==2{
//            return billingnamearray.count
//        }else{
//            return 1
//        }
  //  }
   // func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section==0{
//            informtn = (tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as? InformationTableViewCell)!
//              informtn.Outerview.layer.cornerRadius = 5.0
////            informtn.btnitemordered.addTarget(self, action: #selector(btnitemordered(sender:)), for: .touchUpInside)
//            return informtn
//        }else  if indexPath.section==1{
//            shpngadrs = (tableView.dequeueReusableCell(withIdentifier: "InfrmtnshpngadrsTableViewCell", for: indexPath) as? InfrmtnshpngadrsTableViewCell)!
//            shpngadrs.Outerview.layer.cornerRadius = 5.0
//            shpngadrs.lblname.text=shpngnamearray[indexPath.row]
//            shpngadrs.lbladrs1.text=shpngstreetarray[indexPath.row]
//            shpngadrs.lbladrs2.text=shpngcityarray[indexPath.row]
//            shpngadrs.lbladrs3.text=shpngpostcodearray[indexPath.row]
//            return shpngadrs
//        }else  if indexPath.section==2{
//            billingadrs = (tableView.dequeueReusableCell(withIdentifier: "InfrmtnadrsTableViewCell", for: indexPath) as? InfrmtnadrsTableViewCell)!
//            billingadrs.Outerview.layer.cornerRadius = 5.0
//            billingadrs.lblname.text=billingnamearray[indexPath.row]
//            billingadrs.lbladrs1.text=billingstreetarray[indexPath.row]
//            billingadrs.lbladrts2.text=billingcityarray[indexPath.row]
//            billingadrs.lbladrs3.text=billingpostcodearray[indexPath.row]
//            return billingadrs
//        }else{
//            shpngmethod = (tableView.dequeueReusableCell(withIdentifier: "InfrmtnshpnngmethodTableViewCell", for: indexPath) as? InfrmtnshpnngmethodTableViewCell)!
//            shpngmethod.Outerview.layer.cornerRadius = 5.0
//            shpngmethod.lblshpngmethod.text=shipingmethod
//            return shpngmethod
//        }

//}
    
    
    
   // func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section==0{
//            return 67
//        }else if indexPath.section==1{
//            return 174
//        }else if indexPath.section==2{
//            return 174
//        }else{
//            return 126
//        }
    //}
    
//
//    @objc func btnitemordered(sender: UIButton){
//        let itemdetails = self.storyboard?.instantiateViewController (withIdentifier: "ItemdetailsViewController") as! ItemdetailsViewController
//        //header.removeFromSuperview()
//        itemdetails.informationorderflag="1"
//        itemdetails.incrementid=infrmtnorderincrementid
//        self.navigationController?.pushViewController(itemdetails, animated: false)
//
//    }
    
//    func servicecustomerinfobyemail(){
//        self.showhud()
//        var urlstring:String!
//
//        urlstring = "https://www.cheshirecheesecompany.co.uk//rest/V1/capi/CustomerInfo/33urorbe0o4fqu8jwpu25jbtowi8p5uc/testapi@gamil.com"
//
//        guard let url = URL(string: urlstring) else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            guard let data = data else {return}
//            do{
//                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
//
//                for item in json{
//                    let value : [String:Any] = item as! [String : Any]
//                    let shippinginfo = value["shippingAddress"] as! NSArray
//                    let billinginfo = value["billingAddress"] as! NSArray
//                    for value1 in shippinginfo{
//                        let shippingdata = shippingAddress1(shippinginfo: value1 as! [String : Any])
//                        let lastname = shippingdata.lastname
//                        print("lastname",lastname)
//                        let firstname = shippingdata.firstname
//                        let middlename = shippingdata.middlename
//                        let company = shippingdata.company
//                        let street = shippingdata.street
//                        let city = shippingdata.city
//                        let phone=shippingdata.telephone
//                        let postcode=shippingdata.postcode
//                        self.shpngnamearray.append(firstname+" "+middlename+" "+lastname)
//                        self.shpngstreetarray.append(street)
//                        self.shpngcompanyarray.append(company)
//                        self.shpngcityarray.append(city)
//                        self.shpngpostcodearray.append(postcode)
//
//                    }
//                    for value2 in billinginfo{
//                        let billingdata = billingAddress1(billinginfo: value2 as! [String : Any])
//                        let lastname = billingdata.lastname
//                        print("lastname",lastname)
//                        let firstname = billingdata.firstname
//                        let middlename = billingdata.middlename
//                        let company = billingdata.company
//                        let street = billingdata.street
//                        let city = billingdata.city
//                        print("city",city)
//                        let phone = billingdata.telephone
//                        let postcode=billingdata.postcode
//                        self.billingnamearray.append(firstname+" "+middlename+" "+lastname)
//                        self.billingstreetarray.append(street)
//                        self.billingcompanyarray.append(company)
//                        self.billingcityarray.append(city)
//                        self.billingpostcodearray.append(postcode)
//                    }
//                    DispatchQueue.main.async {
//                        self.hud.hide(animated: true)
//                        self.tablevieworderinfrmtn.reloadData()
//                    }
//                }
//            }
//            catch{
//                print("Error in parsing")
//            }
//
//            }.resume()
//
//    }
//
//
//    func showhud(){
//        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//        hud.mode = MBProgressHUDMode.indeterminate
//    }
//
//
    
}
