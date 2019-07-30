//
//  MywhishlistViewController.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 15/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD

struct wishlistItems{
    let ProductName : String
    let ProductPrice : String
    let ProductImageUrl : String
    let ProductSku : String
   
    init(wishlistdata :[String:Any]) {
        ProductName = wishlistdata["ProductName"] as? String ?? ""
        ProductPrice = wishlistdata["ProductPrice"] as? String ?? ""
        ProductImageUrl = wishlistdata["ProductImageUrl"] as? String ?? ""
        ProductSku = wishlistdata["ProductSku"] as? String ?? ""
    }
}


class MywhishlistViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {

    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var lblnumofitems: UILabel!
    @IBOutlet weak var lblwhishlist: UILabel!
    @IBOutlet weak var tableviewwhishlist: UITableView!
     var whishlist=whishlistTableViewCell()
    var firstname:String!
    var email:String!
    var hud:MBProgressHUD=MBProgressHUD()
    
    
    var scView:UIScrollView!
    let buttonPadding:CGFloat = 10
    var xOffset:CGFloat = 10
    var scrlabel=UILabel()
    var statusbarheight:CGFloat!
    var navigationbarheight:CGFloat!
    
    var productnamearray=[String]()
    var productpricearray=[String]()
    var productimagearray=[String]()
    var productskuarray=[String]()
    var whishlistsku=String()
    let cartbtn=SSBadgeButton()
    var cartnamearray=[String]()
    var whishlistnamearray=[String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    firstname = UserDefaults.standard.value(forKey: "name") as? String
        searchbar.isHidden=true
        let searchlogoimage = UIImage (named: "icon-1")
        let cartlogoimage = UIImage (named: "shoppingcart")
        let loginlogoimage = UIImage (named: "icon-3")
        let btnsearch = UIBarButtonItem (image: searchlogoimage, style: .plain, target: self, action: #selector(MywhishlistViewController.searchaction))
//        let btncart = UIBarButtonItem (image: cartlogoimage, style: .plain, target: self, action: #selector(MywhishlistViewController.cartaction))
        let btnlogin = UIBarButtonItem (image: loginlogoimage, style: .plain, target: self, action: #selector(MywhishlistViewController.loginaction))
//        let backlogoimage=UIImage (named: "back")
//        let btnback = UIBarButtonItem (image: backlogoimage, style: .plain, target: self, action: #selector(OrderhistoryViewController.backaction))
//        navigationItem.setLeftBarButton(btnback, animated: true)
//       self.navigationItem.setHidesBackButton(true, animated:true)
//        
        
        cartbtn.addTarget(self, action: #selector(cartaction), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [btnlogin,UIBarButtonItem(customView: cartbtn),btnsearch]
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        
        tableviewwhishlist.register(UINib(nibName: "whishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "whishlistTableViewCell")
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
            }
                //else if button.tag==3{
                //             button.setBackgroundImage(UIImage(named: "right-arrow"), for: .normal)
                //                button.frame = CGRect(x: UIScreen.main.bounds.width-15, y: 15, width: 10, height: 20)
                //            }
            else{
                button.setTitle("My Wish List", for: .normal)
                
                button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 110, height: 30)
                scrlabel.frame=CGRect(x: xOffset, y:statusbarheight+navigationbarheight+70, width: 100, height: 2)
                scrlabel.backgroundColor=UIColor.black
            }
            //button.setTitle("\(i)", for: .normal)
            button.addTarget(self, action: #selector(btnTouch), for: UIControlEvents.touchUpInside)
            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            scView.addSubview(button)
        }
        
        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
        lblwhishlist.isHidden=false
        serviceviewwhishlist()
         self.hideKeyboardWhenTappedAround()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
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
        if(sender.tag==1){
            let address = self.storyboard?.instantiateViewController (withIdentifier: "AddressViewController") as! AddressViewController
            address.addressflag=1
            self.navigationController?.pushViewController(address, animated: false)
        }else if(sender.tag==2){
            let orders = self.storyboard?.instantiateViewController (withIdentifier: "OrdersViewController") as! OrdersViewController
            orders.orderflag=1
            self.navigationController?.pushViewController(orders, animated: false)
        }
        else if (sender.tag==0){
            let account = self.storyboard?.instantiateViewController (withIdentifier: "MyAccountViewController") as! MyAccountViewController
            account.accountflag=1
            self.navigationController?.pushViewController(account, animated: false)
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
    @objc func backaction(){
        
       navigationController?.popViewController(animated: true)
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
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productnamearray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        whishlist = (tableView.dequeueReusableCell(withIdentifier: "whishlistTableViewCell", for: indexPath) as? whishlistTableViewCell)!
        print("productnamearray.count",productnamearray.count)
        lblnumofitems.text=String(productnamearray.count) + " Items"
        whishlist.Outerview.layer.cornerRadius = 5.0
        let url = URL(string:productimagearray[indexPath.row])
        whishlist.imageviewwhishlistitem.kf.indicatorType = .activity
        whishlist.imageviewwhishlistitem.kf.setImage(with: url)
        whishlist.imageviewwhishlistitem.contentMode = .scaleToFill
        whishlist.lblitemname.text=productnamearray[indexPath.row]
        whishlist.lblprice.text="£"+String(productpricearray[indexPath.row])
        whishlist.btnclose.tag=indexPath.row
        whishlist.btnbuynow.tag=indexPath.row
        whishlist.btnclose.addTarget(self, action: #selector(btncloseaction(sender:)), for: .touchUpInside)
        whishlist.btnbuynow.addTarget(self, action: #selector(btnbuynowaction(sender:)), for: .touchUpInside)
        return whishlist
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 164
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func btncloseaction(sender: UIButton){
        whishlistsku=productskuarray[sender.tag]
       // productskuarray.remove(at: sender.tag)
        servicewhishlistremove()
    }
    @objc func btnbuynowaction(sender: UIButton){
        let productdetails = self.storyboard?.instantiateViewController (withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        productdetails.skuid=productskuarray[sender.tag]
        self.navigationController?.pushViewController(productdetails, animated: false)
    }
    
    
    func serviceviewwhishlist(){
         self.showhud()
        email = UserDefaults.standard.value(forKey: "email") as? String
        let parameters:[String:Any] = ["email" : email,"token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc"]
        guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/ViweToWishlist")else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
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
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)as! NSArray
                    print(json)
                    self.productskuarray.removeAll()
                    self.productnamearray.removeAll()
                    self.productimagearray.removeAll()
                    self.productpricearray.removeAll()
                    for item in json{
                        let value : [String:Any] = item as! [String : Any]
                        if (value["wishlistItems"]) != nil{
                        let whishlistdata = value["wishlistItems"] as! NSArray 
                        print("logindata",whishlistdata as Any)
                        self.productskuarray.removeAll()
                        self.productnamearray.removeAll()
                        self.productimagearray.removeAll()
                            self.productpricearray.removeAll()
                        for value in whishlistdata{
                            let whishlist=wishlistItems(wishlistdata: value as! [String : Any])
                            print("productname",whishlist)
                            let productname=whishlist.ProductName
                            let productimage=whishlist.ProductImageUrl
                             print("productimage",productimage)
                            let productprice=whishlist.ProductPrice
                            let productsku=whishlist.ProductSku
                            self.productnamearray.append(productname)
                            self.productpricearray.append(productprice)
                            self.productimagearray.append(productimage)
                            self.productskuarray.append(productsku)
                        }
                        print("productskuarray",self.productskuarray)
                            
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                           self.tableviewwhishlist.reloadData()
                        }
                     
                        }else{
                            DispatchQueue.main.async {
                                self.hud.hide(animated: true)
                                self.lblwhishlist.isHidden=true
                                self.lblnumofitems.isHidden=true
                                self.tableviewwhishlist.reloadData()
                                
                            }
                          
                              //self.lblwhishlist.isHidden=true
                            let alert = UIAlertController(title: "", message: "No items found in Wishlist" , preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                            self.present(alert, animated: true)
                            
                           
                        }
                }
                    
                }
                    catch {
                    print(error)
                }
            }
            }.resume()
        
    }
    
    func servicewhishlistremove(){
        print("whishlistsku",whishlistsku)
        var params=[String:AnyObject]()
        email = UserDefaults.standard.value(forKey: "email") as? String
        params = ["email" :email as AnyObject,"token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc" as AnyObject,"sku" :whishlistsku as AnyObject,"action" : "remove" as AnyObject]
        
        
        guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/addtoWishlist")else{return}
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
                        let jsonsignup = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        print("jsonsignup",jsonsignup)
                        let datastring=jsonsignup?.replacingOccurrences(of: "[]", with: "")
                        print("datastring",datastring)
                        let jsonText = datastring
                        var dictonary:NSDictionary?

                        if let data = jsonText?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {

                            do {
                                dictonary = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary

                                if let myDictionary = dictonary
                                {

                                    if "(\(myDictionary["status"]))" != nil || "(\(myDictionary["status"]))" != ""{
                                        let status1="\(myDictionary["status"]!)"
                                        let message1="\(myDictionary["message"]!)"
                                        let status=status1
                                        let message=message1
                                        if status=="TRUE"{
                                            
                                            let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
//                                                {
//                                                action in
//                                                let home = self.storyboard?.instantiateViewController (withIdentifier: "HomeViewController") as! HomeViewController
//                                                self.navigationController?.pushViewController(home, animated: false)
//                                            }))
                                            self.present(alert, animated: true)
                                        }else{
                                            let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                                            self.present(alert, animated: true)
                                        }

                                    }else{
                                        let message1="\(myDictionary["message"]!)"
                                        let message=message1
                                        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                                        self.present(alert, animated: true)

                                    }
                                    
                                }
                                
                                DispatchQueue.main.async {
                                    self.hud.hide(animated: true)
                                    self.serviceviewwhishlist()
                                    //                                    self.tableviewwhishlist.reloadData()
                                }
                            } catch let error as NSError {
                                print(error)
                            }
                        }


                    }
                }
            }
            
            .resume()
        }

    
    
    
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    

}
