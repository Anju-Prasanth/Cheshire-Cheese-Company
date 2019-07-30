//
//  AddressViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 16/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import MBProgressHUD

struct Customeradrs{
    let email : String
    let firstname : String
    let middlename : String
    let lastname : String
    let dob : String
    let taxvat : String
    let default_billing : String
    let  default_shipping : String
    init(customerinfo :[String:Any]) {
        email = customerinfo["email"] as? String ?? ""
        firstname = customerinfo["firstname"] as? String ?? ""
        middlename = customerinfo["middlename"] as? String ?? ""
        lastname = customerinfo["lastname"] as? String ?? ""
        dob = customerinfo["dob"] as? String ?? ""
        taxvat = customerinfo["taxvat"] as? String ?? ""
        default_billing = customerinfo["default_billing"] as? String ?? ""
        default_shipping = customerinfo["default_shipping"] as? String ?? ""
    }
}


struct shippingAddress{
    let company : String
    let firstname : String
    let middlename : String
    let lastname : String
    let telephone : String
    let street : String
    let city : String
    let postcode : String
    let region: String
    let id: String
    let country_id: String
    let country_name:String
    init(shippinginfo :[String:Any]) {
        company = shippinginfo["company"] as? String ?? ""
        firstname = shippinginfo["firstname"] as? String ?? ""
        lastname = shippinginfo["lastname"] as? String ?? ""
        middlename = shippinginfo["middlename"] as? String ?? ""
        telephone = shippinginfo["telephone"] as? String ?? ""
        street = shippinginfo["street"] as? String ?? ""
        city = shippinginfo["city"] as? String ?? ""
        postcode = shippinginfo["postcode"] as? String ?? ""
        region = shippinginfo["region"] as? String ?? ""
        id = shippinginfo["id"] as? String ?? ""
        country_id = shippinginfo["country_id"] as? String ?? ""
        country_name = shippinginfo["country_name"] as? String ?? ""
    }
    }


struct billingAddress{
    let company : String
    let firstname : String
    let middlename : String
    let lastname : String
    let telephone : String
    let street : String
    let city : String
    let postcode : String
    let region: String
    let id: String
    let country_id: String
    let country_name:String
    init(billinginfo :[String:Any]) {
        company = billinginfo["company"] as? String ?? ""
        firstname = billinginfo["firstname"] as? String ?? ""
        middlename = billinginfo["middlename"] as? String ?? ""
        lastname = billinginfo["lastname"] as? String ?? ""
        telephone = billinginfo["telephone"] as? String ?? ""
        street = billinginfo["street"] as? String ?? ""
        city = billinginfo["city"] as? String ?? ""
        postcode = billinginfo["postcode"] as? String ?? ""
        region = billinginfo["region"] as? String ?? ""
        id = billinginfo["id"] as? String ?? ""
        country_id = billinginfo["country_id"] as? String ?? ""
        country_name = billinginfo["country_name"] as? String ?? ""
    }
}

class AddressViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    var addressflag=Int()
    var shipngadrs=ShippingadrsTableViewCell()
    var blngadrs=AddressTableViewCell()
    var noshipping=NoshippingadrsTableViewCell()
    var nobilling=NobillingadrsTableViewCell()
    @IBOutlet weak var btnorders: UIButton!
    @IBOutlet weak var btnaddress: UIButton!
    @IBOutlet weak var btnmyaccount: UIButton!
    @IBOutlet weak var viewtoolbar: UIView!
    @IBOutlet weak var tableviewaddress: UITableView!
    
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    var firstnamearray=[String]()
    var lastnamearray=[String]()
    var middlenamearray=[String]()
    var emailarray=[String]()
    var dobarray=[String]()
    var taxvatarray=[String]()
    var defaultbilling=String()
    var defaultshipping=String()
    
    
     var shpngnamearray=[String]()
     var shpngstreetarray=[String]()
     var shpngcityarray=[String]()
     var shpngcompanyarray=[String]()
     var shpngpostcodearray=[String]()
     var shpngtelephoneearray=[String]()
     var shpngregionarray=[String]()
     var shpngidarray=[String]()
     var shpngfirstnamearray=[String]()
     var shpnglastnamearray=[String]()
    var shpngcountryidarray=[String]()
    var shpngmiddlenamearray=[String]()
    var shpngcountrynamearray=[String]()
     var  billingnamearray=[String]()
     var billingstreetarray=[String]()
     var billingcityarray=[String]()
     var billingcompanyarray=[String]()
     var billingpostcodearray=[String]()
    var billingregionarray=[String]()
    var billingphonearray=[String]()
    var billingidarray=[String]()
    var billingfirstnamearray=[String]()
    var billinglastnamearray=[String]()
    var billingcountryidarray=[String]()
    var billingmiddlenamearray=[String]()
    var billingcountrynamearray=[String]()
    
     var header:UIImageView!
     var hud:MBProgressHUD=MBProgressHUD()
    var email:String!
    let cartbtn=SSBadgeButton()
    var cartnamearray=[String]()
    var firstname:String!
    
    var scView:UIScrollView!
    let buttonPadding:CGFloat = 10
    var xOffset:CGFloat = 10
    var scrlabel=UILabel()
    var statusbarheight:CGFloat!
    var navigationbarheight:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let logo = UIImage(named: "logo")
//        header = UIImageView(image: logo)
//        header.contentMode = .scaleAspectFit // set imageview's content mode
//        header.frame = CGRect(x:50, y:0, width: 60, height:40)
//        self.navigationController?.navigationBar.addSubview(header)
        // let backlogoimage=UIImage (named: "back")
        let searchlogoimage = UIImage (named: "icon-1")
        //let cartlogoimage = UIImage (named: "shoppingcart")
        let loginlogoimage = UIImage (named: "icon-3")
        let btnsearch = UIBarButtonItem (image: searchlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.searchaction))
       // let btncart = UIBarButtonItem (image: cartlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.cartaction))
        let btnlogin = UIBarButtonItem (image: loginlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.loginaction))
        // let btnback = UIBarButtonItem (image: backlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.backaction))
        cartbtn.addTarget(self, action: #selector(cartaction), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [btnlogin,UIBarButtonItem(customView: cartbtn),btnsearch]
        
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
         servicecustomerinfobyemail()

        tableviewaddress.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressTableViewCell")
         tableviewaddress.register(UINib(nibName: "ShippingadrsTableViewCell", bundle: nil), forCellReuseIdentifier: "ShippingadrsTableViewCell")
        
        tableviewaddress.register(UINib(nibName: "NoshippingadrsTableViewCell", bundle: nil), forCellReuseIdentifier: "NoshippingadrsTableViewCell")
        
        tableviewaddress.register(UINib(nibName: "NobillingadrsTableViewCell", bundle: nil), forCellReuseIdentifier: "NobillingadrsTableViewCell")
        //viewtoolbar.layer.cornerRadius=5
        searchbar.isHidden=true
        statusbarheight=UIApplication.shared.statusBarFrame.size.height
        navigationbarheight=self.navigationController?.navigationBar.frame.height
        
        scView = UIScrollView(frame: CGRect(x: 0, y: statusbarheight+navigationbarheight+20, width: view.bounds.width, height: 50))
        scView.indicatorStyle=UIScrollViewIndicatorStyle.white
        view.addSubview(scView)
        view.addSubview(searchbar)
        view.addSubview(scrlabel)
        
        scView.backgroundColor = UIColor.white
        scView.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 0 ... 3 {
            let button = UIButton()
            button.tag = i
            button.backgroundColor = UIColor.white
            button.setTitleColor( UIColor.black, for: .normal)
            if button.tag==0{
                button.setTitle("My Account", for: .normal)
                button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 110, height: 30)
                
            }else if button.tag==1{
                button.setTitle("Address", for: .normal)
                button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 80, height: 30)
                scrlabel.frame=CGRect(x: xOffset, y:statusbarheight+navigationbarheight+70, width: 80, height: 2)
                scrlabel.backgroundColor=UIColor.black
            }else if button.tag==2{
                button.setTitle("Orders", for: .normal)
                button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 80, height: 30)
            }
                //else if button.tag==3{
                //             button.setBackgroundImage(UIImage(named: "right-arrow"), for: .normal)
                //                button.frame = CGRect(x: UIScreen.main.bounds.width-15, y: 15, width: 10, height: 20)
                //            }
            else{
                button.setTitle("My Wish List", for: .normal)
                
                button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 110, height: 30)
            }
            //button.setTitle("\(i)", for: .normal)
            button.addTarget(self, action: #selector(btnTouch), for: UIControlEvents.touchUpInside)
            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            scView.addSubview(button)
        }
        
        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
         self.hideKeyboardWhenTappedAround()
       
    }
    override func viewWillAppear(_ animated: Bool)
    {
        firstname = UserDefaults.standard.value(forKey: "name") as? String
//        let logo = UIImage(named: "logo")
//        header = UIImageView(image: logo)
//        header.contentMode = .scaleAspectFit // set imageview's content mode
//        header.frame = CGRect(x:50, y:0, width: 60, height:40)
//        self.navigationController?.navigationBar.addSubview(header)
        
        if (UserDefaults.standard.stringArray(forKey: "cartbadge")) != nil{
            cartnamearray=UserDefaults.standard.stringArray(forKey: "cartbadge") as! [String]
        }else{
            print(UserDefaults.standard.stringArray(forKey: "cartbadge"))
        }
        if cartnamearray.count==0{
            cartbtn.badge = " "
            cartbtn.badgeBackgroundColor = UIColor.clear
        }else{
            cartnamearray=UserDefaults.standard.stringArray(forKey: "cartbadge") as! [String]
            self.cartbtn.badgeBackgroundColor = UIColor.white
            cartbtn.badge = String(cartnamearray.count)
            print("cartnamearray",cartnamearray)
        }
        cartbtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        cartbtn.setBackgroundImage(UIImage(named: "shoppingcart"), for: .normal)
        cartbtn.badgeEdgeInsets = UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 18)
        searchbar.isHidden=true
        
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchbar.text == ""{
            print("no search")
        }
        else{
            print("yes search")
            let searchstring = searchbar.text
            searchbar.text = ""
            let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as! ProdctlistingShopbyctgryViewController
            productlisting.searchflag = 1
            productlisting.keyword = searchstring!
            self.navigationController?.pushViewController(productlisting, animated: true)
            
            
        }
    }
    

    
    @objc func searchaction(){
        if searchbar.isHidden==true{
            searchbar.isHidden=false
        }else{
            searchbar.isHidden=true
        }
        
    }
    @objc func cartaction(){
        if cartnamearray.count==0{
            let emptycart = self.storyboard?.instantiateViewController (withIdentifier: "EmptycartViewController") as! EmptycartViewController
            
            self.navigationController?.pushViewController(emptycart, animated: false)
        }else{
            let mybag = self.storyboard?.instantiateViewController (withIdentifier: "MyBagViewController") as! MyBagViewController
            
            self.navigationController?.pushViewController(mybag, animated: false)
        }
    }
    
  
    public func numberOfSections(in tableView: UITableView) -> Int
    {
       
           return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
            if defaultbilling==""{
                return 1
            }else{
            return billingnamearray.count
            }
        }else{
            if defaultshipping==""{
                return 1
            }else{
            return shpngnamearray.count
        }
        }
    }
    @objc func btnTouch(sender:UIButton){
        if(sender.tag==0){
            let account = self.storyboard?.instantiateViewController (withIdentifier: "MyAccountViewController") as! MyAccountViewController
           account.accountflag=1
            self.navigationController?.pushViewController(account, animated: false)
        }else if(sender.tag==2){
            let orders = self.storyboard?.instantiateViewController (withIdentifier: "OrdersViewController") as! OrdersViewController
            orders.orderflag=1
            self.navigationController?.pushViewController(orders, animated: false)
        }
        else if sender.tag==3{
            let whishlist = self.storyboard?.instantiateViewController (withIdentifier: "MywhishlistViewController") as! MywhishlistViewController
            //address.addressflag=1
            self.navigationController?.pushViewController(whishlist, animated: false)
        }else{
            
        }
    }
    
//    @IBAction func btnordersactn(_ sender: Any) {
//        let order = self.storyboard?.instantiateViewController (withIdentifier: "OrdersViewController") as! OrdersViewController
//        order.orderflag=1
//        self.navigationController?.pushViewController(order, animated: false)
//
//    }
    
//    @IBAction func btnmyacntactn(_ sender: Any) {
//        let account = self.storyboard?.instantiateViewController (withIdentifier: "MyAccountViewController") as! MyAccountViewController
//        account.accountflag=1
//        self.navigationController?.pushViewController(account, animated: false)
//    }
//    
    @IBAction func btnmyadrsactn(_ sender: Any) {
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            if indexPath.section==0{
                  if defaultbilling==""{
                    nobilling = (tableView.dequeueReusableCell(withIdentifier: "NobillingadrsTableViewCell", for: indexPath) as? NobillingadrsTableViewCell)!
                    nobilling.btnaddars.addTarget(self, action: #selector(btneditadrs(sender:)), for: .touchUpInside)
                    return nobilling
                  }else{
                    blngadrs = (tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as? AddressTableViewCell)!
                    
                    blngadrs.Outerview.layer.cornerRadius = 5.0
                    blngadrs.lblname.text=billingnamearray[indexPath.row]
                    blngadrs.lbladrs1.text=billingstreetarray[indexPath.row]
                    blngadrs.lbladrts2.text=billingcityarray[indexPath.row]
                    blngadrs.lbladrs3.text=billingregionarray[indexPath.row]
                    blngadrs.lblregion.text=billingpostcodearray[indexPath.row]+","+billingcountrynamearray[indexPath.row]
                    blngadrs.lblphonenumbr.text="T:"+billingphonearray[indexPath.row]
                    //blngadrs.btneditadrs.addTarget(self, action: #selector(btneditadrs(sender:)), for: .touchUpInside)
                    return blngadrs
                }
            }
                else{
                    if defaultshipping==""{
                        noshipping = (tableView.dequeueReusableCell(withIdentifier: "NoshippingadrsTableViewCell", for: indexPath) as? NoshippingadrsTableViewCell)!
                        noshipping.btnaddars.addTarget(self, action: #selector(btneditadrs(sender:)), for: .touchUpInside)
                        return noshipping
                    }else{
                        shipngadrs = (tableView.dequeueReusableCell(withIdentifier: "ShippingadrsTableViewCell", for: indexPath) as? ShippingadrsTableViewCell)!
                        shipngadrs.Outerview.layer.cornerRadius = 5.0
                        
                        shipngadrs.lblname.text=shpngnamearray[indexPath.row]
                        shipngadrs.lbladrs1.text=shpngstreetarray[indexPath.row]
                        shipngadrs.lbladrs2.text=shpngcityarray[indexPath.row]
                        shipngadrs.lbladrs3.text=shpngregionarray[indexPath.row]
                        shipngadrs.lblregion.text=shpngpostcodearray[indexPath.row]+","+shpngcountrynamearray[indexPath.row]
                        shipngadrs.lblphonenumbr.text="T: "+shpngtelephoneearray[indexPath.row]
                        // shipngadrs.btneditadrs.addTarget(self, action: #selector(btneditadrs(sender:)), for: .touchUpInside)
                        return shipngadrs
                    }
                }
        }
                    
                
                
//            }else{
//                nobilling = (tableView.dequeueReusableCell(withIdentifier: "NobillingadrsTableViewCell", for: indexPath) as? NobillingadrsTableViewCell)!
//                 nobilling.btnaddars.addTarget(self, action: #selector(btneditadrs(sender:)), for: .touchUpInside)
//                return nobilling
//            }
//        }else if indexPath.section==0{
//        blngadrs = (tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as? AddressTableViewCell)!
//
//         blngadrs.Outerview.layer.cornerRadius = 5.0
//        blngadrs.lblname.text=billingnamearray[indexPath.row]
//        blngadrs.lbladrs1.text=billingstreetarray[indexPath.row]
//        blngadrs.lbladrts2.text=billingcityarray[indexPath.row]
//        blngadrs.lbladrs3.text=billingregionarray[indexPath.row]
//        blngadrs.lblregion.text=billingpostcodearray[indexPath.row]+","+billingcountrynamearray[indexPath.row]
//            blngadrs.lblphonenumbr.text="T:"+billingphonearray[indexPath.row]
//        //blngadrs.btneditadrs.addTarget(self, action: #selector(btneditadrs(sender:)), for: .touchUpInside)
//        return blngadrs
//            }
//        else
//        {
//            shipngadrs = (tableView.dequeueReusableCell(withIdentifier: "ShippingadrsTableViewCell", for: indexPath) as? ShippingadrsTableViewCell)!
//            shipngadrs.Outerview.layer.cornerRadius = 5.0
//
//            shipngadrs.lblname.text=shpngnamearray[indexPath.row]
//            shipngadrs.lbladrs1.text=shpngstreetarray[indexPath.row]
//            shipngadrs.lbladrs2.text=shpngcityarray[indexPath.row]
//            shipngadrs.lbladrs3.text=shpngregionarray[indexPath.row]
//            shipngadrs.lblregion.text=shpngpostcodearray[indexPath.row]+","+shpngcountrynamearray[indexPath.row]
//            shipngadrs.lblphonenumbr.text="T: "+shpngtelephoneearray[indexPath.row]
//           // shipngadrs.btneditadrs.addTarget(self, action: #selector(btneditadrs(sender:)), for: .touchUpInside)
//            return shipngadrs
//    }
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            if indexPath.section==0{
                if defaultbilling==""{
                return 125
                }else{
                    return 236
                }
            }else{
                if defaultshipping==""{
                    return 125
                }else{
                    return 236
                }
            }
    }
    
    
    @objc func btneditadrs(sender: UIButton){
        let newaddress = self.storyboard?.instantiateViewController (withIdentifier: "NewaddressViewController") as! NewaddressViewController
       
        self.navigationController?.pushViewController(newaddress, animated: false)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if defaultbilling==""||defaultshipping==""{
            let  addadress=self.storyboard?.instantiateViewController (withIdentifier: "AddadressViewController") as! AddadressViewController
            if indexPath.section==0{
               addadress.addressfag=0
            }else{
                addadress.addressfag=1
            }
            
             self.navigationController?.pushViewController(addadress, animated: false)
        }else{
        let newaddress = self.storyboard?.instantiateViewController (withIdentifier: "NewaddressViewController") as! NewaddressViewController
        if indexPath.section==0{
            newaddress.adressid=billingidarray[indexPath.row]
            newaddress.postalcode=billingpostcodearray[indexPath.row]
            newaddress.city=billingcityarray[indexPath.row]
            newaddress.phonenum=billingphonearray[indexPath.row]
            newaddress.street=billingstreetarray[indexPath.row]
            newaddress.region=billingregionarray[indexPath.row]
            newaddress.countryid=billingcountryidarray[indexPath.row]
            newaddress.firstname=billingfirstnamearray[indexPath.row]
            newaddress.lastname=billinglastnamearray[indexPath.row]
            newaddress.middlename=billingmiddlenamearray[indexPath.row]
        }else{
            newaddress.adressid=shpngidarray[indexPath.row]
            newaddress.postalcode=shpngpostcodearray[indexPath.row]
            newaddress.city=shpngcityarray[indexPath.row]
            newaddress.phonenum=shpngtelephoneearray[indexPath.row]
            newaddress.street=shpngstreetarray[indexPath.row]
            newaddress.region=shpngregionarray[indexPath.row]
            newaddress.countryid=shpngcountryidarray[indexPath.row]
            newaddress.firstname=shpngfirstnamearray[indexPath.row]
            newaddress.lastname=shpnglastnamearray[indexPath.row]
            newaddress.middlename=shpngmiddlenamearray[indexPath.row]
        }
       
        self.navigationController?.pushViewController(newaddress, animated: false)
        }
        
    }
    func servicecustomerinfobyemail(){
         self.showhud()
        var urlstring:String!
         email = UserDefaults.standard.value(forKey: "email") as? String
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/CustomerInfo/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"+email
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                print("json",json)
                
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let customerinfo = value["CustomerInfo"] as! NSArray
        
                    for value in customerinfo{
                        let customerdata = Customeradrs(customerinfo: value as! [String : Any])
                        print("customerdata",customerdata)
                        let lastname = customerdata.lastname
                        print("lastname",lastname)
                        let firstname = customerdata.firstname
                        let middlename = customerdata.middlename
                        let email = customerdata.email
                        let dob=customerdata.dob
                        let taxvat=customerdata.taxvat
                    self.defaultbilling=customerdata.default_billing
                    self.defaultshipping=customerdata.default_shipping
                        //self.namearray.append(firstname + " " + lastname + " " + middlename)
                        //print("namearray",self.namearray)
                        self.emailarray.append(email)
                        self.firstnamearray.append(firstname)
                        self.lastnamearray.append(lastname)
                        self.middlenamearray.append(middlename)
                        self.dobarray.append(dob)
                        self.taxvatarray.append(taxvat)
//                        self.defaultbillingarray.append(defaultbilling)
//                        self.defaultshippingarray.append(defaultshpng)
                        
                    }
                    
                    if (self.defaultshipping != "") {
            
                 let shippinginfo = value["shippingAddress"] as! NSArray

                
                    for value1 in shippinginfo{
                        let shippingdata = shippingAddress(shippinginfo: value1 as! [String : Any])
                    let lastname = shippingdata.lastname
                    print("lastname",lastname)
                    let firstname = shippingdata.firstname
                    let middlename = shippingdata.middlename
                    let company = shippingdata.company
                    let street = shippingdata.street
                    print("street",street)
                    let city = shippingdata.city
                    let phone=shippingdata.telephone
                    let postcode=shippingdata.postcode
                    let region=shippingdata.region
                    let id=shippingdata.id
                    let countryid=shippingdata.country_id
                    let countryname=shippingdata.country_name
                    self.shpngnamearray.append(firstname+" "+middlename+" "+lastname)
                    self.shpngstreetarray.append(street)
                    self.shpngcompanyarray.append(company)
                    self.shpngcityarray.append(city)
                    self.shpngpostcodearray.append(postcode)
                    self.shpngtelephoneearray.append(phone)
                    self.shpngregionarray.append(region)
                    self.shpngidarray.append(id)
                    self.shpngfirstnamearray.append(firstname)
                    self.shpnglastnamearray.append(lastname)
                    self.shpngcountryidarray.append(countryid)
                    self.shpngmiddlenamearray.append(middlename)
                    self.shpngcountrynamearray.append(countryname)
                    }
                    }else{
                    }
                    if (self.defaultbilling != "") {
                         let billinginfo = value["billingAddress"] as! NSArray
                    for value2 in billinginfo{
                        let billingdata = billingAddress(billinginfo: value2 as! [String : Any])
                        let lastname = billingdata.lastname
                        print("lastname",lastname)
                    let firstname = billingdata.firstname
                    let middlename = billingdata.middlename
                    let company = billingdata.company
                    let street = billingdata.street
                    let city = billingdata.city
                      print("city",city)
                    let phone = billingdata.telephone
                    let postcode=billingdata.postcode
                    let region=billingdata.region
                    let id=billingdata.id
                    let countryid=billingdata.country_id
                    let countryname=billingdata.country_name
                    self.billingnamearray.append(firstname+" "+middlename+" "+lastname)
                    self.billingstreetarray.append(street)
                    self.billingmiddlenamearray.append(middlename)
                    print("billingstreetarray",self.billingstreetarray)
                    print("billingstreetarray.count",self.billingstreetarray.count)
                    self.billingcompanyarray.append(company)
                    self.billingcityarray.append(city)
                    self.billingpostcodearray.append(postcode)
                    self.billingregionarray.append(region)
                    self.billingphonearray.append(phone)
                    self.billingidarray.append(id)
                    self.billingfirstnamearray.append(firstname)
                    self.billinglastnamearray.append(lastname)
                    self.billingcountryidarray.append(countryid)
                    self.billingcountrynamearray.append(countryname)
                        
                        
                    }
                    }else{
                        
                    }
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.tableviewaddress.reloadData()
                    }
                }
            }
            catch{
                print("Error in parsing")
            }
            
            }.resume()
        
        
    }
    
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
}
