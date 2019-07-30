//
//  MyAccountViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 08/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import MBProgressHUD

struct CustomerInfo{
    let email : String
    let firstname : String
    let middlename : String
    let lastname : String
    init(customerinfo :[String:Any]) {
        email = customerinfo["email"] as? String ?? ""
        firstname = customerinfo["firstname"] as? String ?? ""
        middlename = customerinfo["middlename"] as? String ?? ""
        lastname = customerinfo["lastname"] as? String ?? ""
    }
}

//struct shippingAddress{
//    let company : String
//    let firstname : String
//    let middlename : String
//    let lastname : String
//    let telephone : String
//    let street : String
//    let city : String
//    init(shippinginfo :[String:Any]) {
//        company = shippinginfo["company"] as? String ?? ""
//        firstname = shippinginfo["firstname"] as? String ?? ""
//        lastname = shippinginfo["lastname"] as? String ?? ""
//        middlename = shippinginfo["middlename"] as? String ?? ""
//        telephone = shippinginfo["telephone"] as? String ?? ""
//        street = shippinginfo["street"] as? String ?? ""
//        city = shippinginfo["city"] as? String ?? ""
//    }
//}
//
//struct billingAddress{
//    let company : String
//    let firstname : String
//    let middlename : String
//    let lastname : String
//    let telephone : String
//    let street : String
//    let city : String
//    init(billinginfo :[String:Any]) {
//        company = billinginfo["company"] as? String ?? ""
//        firstname = billinginfo["firstname"] as? String ?? ""
//        middlename = billinginfo["middlename"] as? String ?? ""
//        lastname = billinginfo["lastname"] as? String ?? ""
//        telephone = billinginfo["telephone"] as? String ?? ""
//        street = billinginfo["street"] as? String ?? ""
//        city = billinginfo["city"] as? String ?? ""
//    }
//}

class MyAccountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    

   
    
    @IBOutlet weak var btnorders: UIButton!
    @IBOutlet weak var btnaddress: UIButton!
    @IBOutlet weak var btnmyaccount: UIButton!
    
    @IBOutlet weak var tableviewmyaccount: UITableView!
    @IBOutlet weak var viewtoolbar: UIView!
     @IBOutlet weak var searchbar: UISearchBar!
    var accountflag=Int()
    var namearray=[String]()
    var emailarray=[String]()
    var header: UIImageView!
    var cell=AccountdetailsTableViewCell()
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
        //let btncart = UIBarButtonItem (image: cartlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.cartaction))
        let btnlogin = UIBarButtonItem (image: loginlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.loginaction))
        // let btnback = UIBarButtonItem (image: backlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.backaction))
        cartbtn.addTarget(self, action: #selector(cartaction), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [btnlogin,UIBarButtonItem(customView: cartbtn),btnsearch]
        
        
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        
        tableviewmyaccount.register(UINib(nibName: "AccountdetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountdetailsTableViewCell")
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
        servicecustomerinfobyemail()
       

        for i in 0 ... 3 {
            let button = UIButton()
            button.tag = i
            button.backgroundColor = UIColor.white
            button.setTitleColor( UIColor.black, for: .normal)
            if button.tag==0{
                button.setTitle("My Account", for: .normal)
                  button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 110, height: 30)
                //button.titleLabel?.text=UIFont(
                scrlabel.frame=CGRect(x: xOffset+10, y:statusbarheight+navigationbarheight+70, width: 100, height: 2)
                scrlabel.backgroundColor=UIColor.black
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
            }
            //button.setTitle("\(i)", for: .normal)
            button.addTarget(self, action: #selector(btnTouch), for: UIControlEvents.touchUpInside)
            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            scView.addSubview(button)
        }

        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
         self.hideKeyboardWhenTappedAround()
}
    
    
//    @IBAction func btnadrsactn(_ sender: Any) {
//        let address = self.storyboard?.instantiateViewController (withIdentifier: "AddressViewController") as! AddressViewController
//                    address.addressflag=1
//                    self.navigationController?.pushViewController(address, animated: false)
//    }
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
        else if (sender.tag==3){
            let whishlist = self.storyboard?.instantiateViewController (withIdentifier: "MywhishlistViewController") as! MywhishlistViewController
            //address.addressflag=1
            self.navigationController?.pushViewController(whishlist, animated: false)
        }else{
            
            }
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
    
    @IBAction func btnmyaccountactn(_ sender: Any) {
        
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
         return emailarray.count
        }
    
    @IBAction func btnordersactn(_ sender: Any) {
        let order = self.storyboard?.instantiateViewController (withIdentifier: "OrdersViewController") as! OrdersViewController
         order.orderflag=1
        self.navigationController?.pushViewController(order, animated: false)
       
    }
    
    @IBAction func btnadressactn(_ sender: Any) {
        let address = self.storyboard?.instantiateViewController (withIdentifier: "AddressViewController") as! AddressViewController
         address.addressflag=1
        self.navigationController?.pushViewController(address, animated: false)
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = (tableView.dequeueReusableCell(withIdentifier: "AccountdetailsTableViewCell", for: indexPath) as? AccountdetailsTableViewCell)!
            cell.Outerview.layer.cornerRadius = 5.0
        cell.lblname.text=namearray[indexPath.row]
        cell.lblemail.text=emailarray[indexPath.row]
        cell.btnchangeaprofileinfo.addTarget(self, action: #selector(btnchchangeprofileinfoaction(sender:)), for: .touchUpInside)
         cell.btnchangepassword.addTarget(self, action: #selector(btnchangepasswordaction(sender:)), for: .touchUpInside)
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 156
    }
//     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let profile = self.storyboard?.instantiateViewController (withIdentifier: "ProfileupdateViewController") as! ProfileupdateViewController
//        
//        self.navigationController?.pushViewController(profile, animated: false)
//        
//    }
//    
    @objc func btnchchangeprofileinfoaction(sender:UIButton){
        let profile = self.storyboard?.instantiateViewController (withIdentifier: "ProfileupdateViewController") as! ProfileupdateViewController
        
        self.navigationController?.pushViewController(profile, animated: false)
        
        
    }
    @objc func btnchangepasswordaction(sender:UIButton){
        let newpassword = self.storyboard?.instantiateViewController (withIdentifier: "CreatenewpasswordViewController") as! CreatenewpasswordViewController
        
        self.navigationController?.pushViewController(newpassword, animated: false)
        
        
    }
    
    
    func servicecustomerinfobyemail(){
        self.showhud()
        var urlstring:String!
        print("email",email)
       email = UserDefaults.standard.value(forKey: "email") as? String
    
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/CustomerInfo/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"+email
        
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray
                if json != nil{
                for item in json!{
                    let value : [String:Any] = item as! [String : Any]
                    let customerinfo = value["CustomerInfo"] as! NSArray
                    print("customerinfo",customerinfo)
                   // let shippinginfo = value["shippingAddress"] as! NSArray
                   // let billinginfo = value["billingAddress"] as! NSArray
                    for value in customerinfo{
                        let customerdata = CustomerInfo(customerinfo: value as! [String : Any])
                        print("customerdata",customerdata)
                        let lastname = customerdata.lastname
                        print("lastname",lastname)
                        let firstname = customerdata.firstname
                        let middlename = customerdata.middlename
                        let email = customerdata.email
                       
                        self.namearray.append(firstname + " " + middlename + " " + lastname)
                        print("namearray",self.namearray)
                        self.emailarray.append(email)
                }
//                    for value1 in shippinginfo{
//                        let shippingdata = shippingAddress(shippinginfo: value1 as! [String : Any])
//                        let lastname = shippingdata.lastname
//                        print("lastname",lastname)
//                        let firstname = shippingdata.firstname
//                        let middlename = shippingdata.middlename
//                        let company = shippingdata.company
//                        let street = shippingdata.street
//                        let city = shippingdata.city
//                        let phone=shippingdata.telephone
//                    }
//                    for value2 in billinginfo{
//                        let billingdata = billingAddress(billinginfo: value2 as! [String : Any])
//                        let lastname = billingdata.lastname
//                        print("lastname",lastname)
//                        let firstname = billingdata.firstname
//                        let middlename = billingdata.middlename
//                        let company = billingdata.company
//                        let street = billingdata.street
//                        let city = billingdata.city
//                        print("city",city)
//                        let phone = billingdata.telephone
//                    }
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.tableviewmyaccount.reloadData()
                    }
                    }
                    
                }else{
                    let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
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
