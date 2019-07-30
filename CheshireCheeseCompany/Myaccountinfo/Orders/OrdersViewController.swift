//
//  OrdersViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 16/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import MBProgressHUD
import Foundation

struct orders{
    let entity_id : String
    let status : String
    let created_at : String
    let increment_id : String
    let grand_total : String
    let subtotal : String
    let tax_amount : String
    let shipping_description : String
    let shipping_amount : String
    let discount_amount : String
    let shipping_method : String
    init(orderinfo :[String:Any]) {
        entity_id = orderinfo["entity_id"] as? String ?? ""
        status = orderinfo["status"] as? String ?? ""
        created_at = orderinfo["created_at"] as? String ?? ""
        increment_id = orderinfo["increment_id"] as? String ?? ""
        grand_total = orderinfo["grand_total"] as? String ?? ""
        subtotal = orderinfo["subtotal"] as? String ?? ""
        tax_amount = orderinfo["tax_amount"] as? String ?? ""
        shipping_description = orderinfo["shipping_description"] as? String ?? ""
        shipping_amount = orderinfo["shipping_amount"] as? String ?? ""
        discount_amount = orderinfo["discount_amount"] as? String ?? ""
         shipping_method = orderinfo["shipping_method"] as? String ?? ""
    }
}

class OrdersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    var orderflag=Int()
    @IBOutlet weak var btnorders: UIButton!
    @IBOutlet weak var btnaddress: UIButton!
    @IBOutlet weak var btnmyaccount: UIButton!
    @IBOutlet weak var viewtoolbar: UIView!
    var header:UIImageView!
    var myorder=MyorderTableViewCell()
    var orderaccount=OrderaccountTableViewCell()
    var hud:MBProgressHUD=MBProgressHUD()
    var incrementidarray=[String]()
    var statusarray=[String]()
    var createdatarray=[String]()
    var datecreated=String()
    var status=String()
    var shipngmethodarray=[String]()
    var shippingamntarray=[String]()
    var taxamntarray=[String]()
    var grandtotalarray=[String]()
    var subtotalarray=[String]()
    var discountamountarray=[String]()
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

    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tablevieworder: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let logo = UIImage(named: "logo")
//        header = UIImageView(image: logo)
//        header.contentMode = .scaleAspectFit // set imageview's content mode
//        header.frame = CGRect(x:50, y:0, width: 60, height:40)
//        self.navigationController?.navigationBar.addSubview(header)
        // let backlogoimage=UIImage (named: "back")
        let searchlogoimage = UIImage (named: "icon-1")
       // let cartlogoimage = UIImage (named: "shoppingcart")
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
        
       serviceorderbyemail()
        tablevieworder.register(UINib(nibName: "MyorderTableViewCell", bundle: nil), forCellReuseIdentifier: "MyorderTableViewCell")
        tablevieworder.register(UINib(nibName: "OrderaccountTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderaccountTableViewCell")
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
            }else if button.tag==2{
                button.setTitle("Orders", for: .normal)
                button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 80, height: 30)
                scrlabel.frame=CGRect(x: xOffset, y:statusbarheight+navigationbarheight+70, width: 80, height: 2)
                scrlabel.backgroundColor=UIColor.black
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
    
    @objc func btnTouch(sender:UIButton){
        if(sender.tag==0){
            let account = self.storyboard?.instantiateViewController (withIdentifier: "MyAccountViewController") as! MyAccountViewController
            account.accountflag=1
            self.navigationController?.pushViewController(account, animated: false)
        }else if(sender.tag==1){
            let address = self.storyboard?.instantiateViewController (withIdentifier: "AddressViewController") as! AddressViewController
            address.addressflag=1
            self.navigationController?.pushViewController(address, animated: false)
        }
        else if (sender.tag==3){
            let whishlist = self.storyboard?.instantiateViewController (withIdentifier: "MywhishlistViewController") as! MywhishlistViewController
            //address.addressflag=1
            self.navigationController?.pushViewController(whishlist, animated: false)
        }else{
            
        }
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
//     @objc func btnorderdtails(sender:UIButton){
//        let item = self.storyboard?.instantiateViewController (withIdentifier: "ItemdetailsViewController") as! ItemdetailsViewController
//        //header.removeFromSuperview()
//        self.navigationController?.pushViewController(item, animated: true)
//
//    }
//
    
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
            return 1
        }else{
            return incrementidarray.count
        }
    }
    
   
    @IBAction func btnadressactn(_ sender: Any) {
        let address = self.storyboard?.instantiateViewController (withIdentifier: "AddressViewController") as! AddressViewController
        address.addressflag=1
        self.navigationController?.pushViewController(address, animated: false)
    }
    @IBAction func btnmyacntactn(_ sender: Any) {
        let account = self.storyboard?.instantiateViewController (withIdentifier: "MyAccountViewController") as! MyAccountViewController
        account.accountflag=1
        self.navigationController?.pushViewController(account, animated: false)
    }
    
    @IBAction func btnmyordersactn(_ sender: Any) {
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section==0{
        myorder = (tableView.dequeueReusableCell(withIdentifier: "MyorderTableViewCell", for: indexPath) as? MyorderTableViewCell)!
          myorder.Outerview.layer.cornerRadius = 5.0
        return myorder
        }else{
            orderaccount = (tableView.dequeueReusableCell(withIdentifier: "OrderaccountTableViewCell", for: indexPath) as? OrderaccountTableViewCell)!
            orderaccount.Outerview.layer.cornerRadius = 5.0
            if statusarray[indexPath.row]=="pending"||statusarray[indexPath.row]=="processing"{
                let redcolor=UIColor(red: 210/255, green:  66/255, blue: 82/255, alpha: 1.0)
                self.orderaccount.lblstatus.backgroundColor=redcolor
            }else{
                let greencolor=UIColor(red: 93/255, green:  166/255, blue: 41/255, alpha: 1.0)
                self.orderaccount.lblstatus.backgroundColor=greencolor
            }
            orderaccount.lblorderid.text="#"+incrementidarray[indexPath.row]
            orderaccount.lblstatus.text=statusarray[indexPath.row].uppercased()
//            let delimiter = "  "
//            let datecreated = createdatarray[indexPath.row].components(separatedBy: delimiter)
//            orderaccount.lbldate.text=datecreated[indexPath.row]
            orderaccount.lbldate.text=createdatarray[indexPath.row]
//            orderaccount.btnorderdtails.addTarget(self, action: #selector(btnorderdtails(sender:)), for: .touchUpInside)
            return orderaccount
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       if indexPath.section==0{
        return 67
       }else{
        return 149
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
        let item = self.storyboard?.instantiateViewController (withIdentifier: "ItemdetailsViewController") as! ItemdetailsViewController
        print("incrementid",incrementidarray[indexPath.row])
         item.incrementid=incrementidarray[indexPath.row]
         item.status=statusarray[indexPath.row]
         item.created = createdatarray[indexPath.row]
         item.shipngmethod = shipngmethodarray[indexPath.row]
         item.shipingamnt = shippingamntarray[indexPath.row]
         item.taxamnt = taxamntarray[indexPath.row]
         item.grndtotal = grandtotalarray[indexPath.row]
         item.subtotal = subtotalarray[indexPath.row]
         item.discountamnt = discountamountarray[indexPath.row]
        self.navigationController?.pushViewController(item, animated: true)
        
    }
    
    
    func serviceorderbyemail(){
        self.showhud()
        var urlstring:String!
        email = UserDefaults.standard.value(forKey: "email") as? String
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/order/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"+email
        
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let orderinfo = value["orders"] as! NSArray
                    for value in orderinfo{
                        let orderdata = orders(orderinfo: value as! [String : Any])
                        print("orderdata",orderdata)
                        let entityid=orderdata.entity_id
                        let incremetid=orderdata.increment_id
                        self.status=orderdata.status
                        print("status",self.status)
                        let createdat=orderdata.created_at.components(separatedBy: " ")
                        let seperated:String=createdat[0]
                        print("entityid",entityid)
                        let shipngmethod=orderdata.shipping_method
                        let shippingamnt=orderdata.shipping_amount
                         let taxamnt=orderdata.tax_amount
                         let grandtotal=orderdata.grand_total
                         let subtotal=orderdata.subtotal
                         let discountamount=orderdata.discount_amount
//                         let fullName = "First Last" let fullNameArr = fullName.components(separatedBy: " ")
                        self.shipngmethodarray.append(shipngmethod)
                        self.shippingamntarray.append(shippingamnt)
                        self.taxamntarray.append(taxamnt)
                        self.grandtotalarray.append(grandtotal)
                        self.subtotalarray.append(subtotal)
                        self.discountamountarray.append(discountamount)
                        
                        
                        self.incrementidarray.append(incremetid)
                        self.statusarray.append(self.status)
                        self.createdatarray.append(seperated)
                    }
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.tablevieworder.reloadData()
                    }
                }
            }
            catch{
                let alert = UIAlertController(title: "Alert", message: "Wrong Email Or You Have Not Created Any Orders.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                    print("Invalidlogin")
                }))
                self.present(alert, animated: true)
                DispatchQueue.main.async {
                    self.hud.hide(animated: true)
                    
                }
            }
            
            }.resume()
        
}
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
}

