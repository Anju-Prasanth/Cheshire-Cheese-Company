//
//  ItemdetailsViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 22/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import MBProgressHUD

struct json{
    let item_id : String
    let order_id : String
    let name : String
    let qty_invoiced : String
    let qty_ordered : String
    let qty_refunded : String
    let qty_shipped : String
    let price : String
    let qty_canceled : String
    let tax_amount : String
    let image : String
    let sku : String
    init(orderinfo :[String:Any]) {
        item_id = orderinfo["item_id"] as? String ?? ""
        order_id = orderinfo["order_id"] as? String ?? ""
         name = orderinfo["name"] as? String ?? ""
         qty_invoiced = orderinfo["qty_invoiced"] as? String ?? ""
         qty_ordered = orderinfo["qty_ordered"] as? String ?? ""
         qty_refunded = orderinfo["qty_refunded"] as? String ?? ""
         qty_shipped = orderinfo["qty_shipped"] as? String ?? ""
         price = orderinfo["price"] as? String ?? ""
         qty_canceled = orderinfo["qty_canceled"] as? String ?? ""
         tax_amount = orderinfo["tax_amount"] as? String ?? ""
        image = orderinfo["image"] as? String ?? ""
        sku = orderinfo["sku"] as? String ?? ""
    }
}
struct shippingAddress1{
    let company : String
    let firstname : String
    let middlename : String
    let lastname : String
    let telephone : String
    let street : String
    let city : String
    let postcode : String
    init(shippinginfo :[String:Any]) {
        company = shippinginfo["company"] as? String ?? ""
        firstname = shippinginfo["firstname"] as? String ?? ""
        lastname = shippinginfo["lastname"] as? String ?? ""
        middlename = shippinginfo["middlename"] as? String ?? ""
        telephone = shippinginfo["telephone"] as? String ?? ""
        street = shippinginfo["street"] as? String ?? ""
        city = shippinginfo["city"] as? String ?? ""
        postcode = shippinginfo["postcode"] as? String ?? ""
    }
}

struct billingAddress1{
    let company : String
    let firstname : String
    let middlename : String
    let lastname : String
    let telephone : String
    let street : String
    let city : String
    let postcode : String
    init(billinginfo :[String:Any]) {
        company = billinginfo["company"] as? String ?? ""
        firstname = billinginfo["firstname"] as? String ?? ""
        middlename = billinginfo["middlename"] as? String ?? ""
        lastname = billinginfo["lastname"] as? String ?? ""
        telephone = billinginfo["telephone"] as? String ?? ""
        street = billinginfo["street"] as? String ?? ""
        city = billinginfo["city"] as? String ?? ""
        postcode = billinginfo["postcode"] as? String ?? ""
    }
}


class ItemdetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate  {
   var header:UIImageView!
    var orderinfo=OrderinformationTableViewCell()
     var itemstataus=OrderstatusTableViewCell()
     var itemname=OrdernameTableViewCell()
     var itemprice=OrderpriceTableViewCell()
     var hud:MBProgressHUD=MBProgressHUD()
    
    var informtn=InformationTableViewCell()
    var shpngadrs=InfrmtnshpngadrsTableViewCell()
    var billingadrs=InfrmtnadrsTableViewCell()
    var shpngmethod=InfrmtnshpnngmethodTableViewCell()
    var orederinformationflag=Int()
    
    
    
    var status=String()
    var created = String()
    var shipngmethod = String()
    var shipingamnt = String()
    var taxamnt = String()
    var grndtotal = String()
    var subtotal = String()
    var incrementid = String()
    var discountamnt = String()
    
    var namearray=[String]()
    var qty_invoicedarray=[Int]()
    var qty_orderedarray=[Int]()
    var qty_refundedarray=[Int]()
    var qty_shippedarray=[Int]()
    var pricearray=[String]()
    var qty_canceledarray=[Int]()
    var tax_amountarray=[String]()
    var imagearray=[String]()
    var seperatedqtyordrd=[String]()
    var name=String()
    var informationorderflag=String()
    var skuarray=[String]()

    
    
    var shpngnamearray=[String]()
    var shpngstreetarray=[String]()
    var shpngcityarray=[String]()
    var shpngcompanyarray=[String]()
    var shpngpostcodearray=[String]()
    var billingnamearray=[String]()
    var billingstreetarray=[String]()
    var billingcityarray=[String]()
    var billingcompanyarray=[String]()
    var billingpostcodearray=[String]()
    var infrmtnorderincrementid=String()
    let cartbtn=SSBadgeButton()
    var cartnamearray=[String]()
    var firstname:String!
    var email:String!
    
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var tableviewitemdetails: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         print("status",status)
        print("created",created)
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
       // navigationItem.setRightBarButtonItems([btnlogin,btncart,btnsearch], animated: true)
        
        
        cartbtn.addTarget(self, action: #selector(cartaction), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [btnlogin,UIBarButtonItem(customView: cartbtn),btnsearch]
        
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        
    
        tableviewitemdetails.register(UINib(nibName: "OrderinformationTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderinformationTableViewCell")
        tableviewitemdetails.register(UINib(nibName: "OrderstatusTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderstatusTableViewCell")
         tableviewitemdetails.register(UINib(nibName: "OrdernameTableViewCell", bundle: nil), forCellReuseIdentifier: "OrdernameTableViewCell")
         tableviewitemdetails.register(UINib(nibName: "OrderpriceTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderpriceTableViewCell")
        tableviewitemdetails.register(UINib(nibName: "InformationTableViewCell", bundle: nil), forCellReuseIdentifier: "InformationTableViewCell")
        tableviewitemdetails.register(UINib(nibName: "InfrmtnshpngadrsTableViewCell", bundle: nil), forCellReuseIdentifier: "InfrmtnshpngadrsTableViewCell")
        tableviewitemdetails.register(UINib(nibName: "InfrmtnadrsTableViewCell", bundle: nil), forCellReuseIdentifier: "InfrmtnadrsTableViewCell")
        tableviewitemdetails.register(UINib(nibName: "InfrmtnshpnngmethodTableViewCell", bundle: nil), forCellReuseIdentifier: "InfrmtnshpnngmethodTableViewCell")
//        viewtoolbar.layer.cornerRadius=5
        searchbar.isHidden=true
        serviceitemdetails()
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
         @objc func btnorderinfrmtn(sender:UIButton){
//            let infrmtnorder = self.storyboard?.instantiateViewController (withIdentifier: "OrderinfrmtnViewController") as! OrderinfrmtnViewController
//            infrmtnorder.shipingmethod=shpngdscrtn
//            infrmtnorder.infrmtnorderincrementid=incrementid
//            self.navigationController?.pushViewController(infrmtnorder, animated: true)
            orederinformationflag=1
            servicecustomerinfobyemail()
    
        }
    
    @objc func btninvoice(sender:UIButton){
        let invoice = self.storyboard?.instantiateViewController (withIdentifier: "InvoicedetailsViewController") as! InvoicedetailsViewController
        invoice.itemname=namearray[sender.tag]
        invoice.price=String(pricearray[sender.tag])
        invoice.incrementidnumber=incrementid
        invoice.invoicenamearray=namearray
        invoice.invoicestatus=status
        invoice.datecreated=created
        invoice.invoicesku=skuarray[sender.tag]
        self.navigationController?.pushViewController(invoice, animated: true)
        
    }
    @objc func btnitemordered(sender:UIButton){
        
        orederinformationflag=0
        serviceitemdetails()
        
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
        if orederinformationflag==1{
              return 4
        }else{
        return 4
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if orederinformationflag==1{
            if section==0{
                return 1
            }else if section==1{
                return shpngnamearray.count
            } else if section==2{
                return billingnamearray.count
            }else{
                return 1
            }
        }else
            {
        if section==0{
            return 1
        }else if section==1{
            return 1
        } else if section==2{
            return namearray.count
        }else{
           return 1
        }
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if orederinformationflag==1{
            if indexPath.section==0{
                informtn = (tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as? InformationTableViewCell)!
                informtn.Outerview.layer.cornerRadius = 5.0
                informtn.btnitemordered.addTarget(self, action: #selector(btnitemordered(sender:)), for: .touchUpInside)
                return informtn
            }else  if indexPath.section==1{
                shpngadrs = (tableView.dequeueReusableCell(withIdentifier: "InfrmtnshpngadrsTableViewCell", for: indexPath) as? InfrmtnshpngadrsTableViewCell)!
                shpngadrs.Outerview.layer.cornerRadius = 5.0
                shpngadrs.lblname.text=shpngnamearray[indexPath.row]
                shpngadrs.lbladrs1.text=shpngstreetarray[indexPath.row]
                shpngadrs.lbladrs2.text=shpngcityarray[indexPath.row]
                shpngadrs.lbladrs3.text=shpngpostcodearray[indexPath.row]
                return shpngadrs
            }else  if indexPath.section==2{
                billingadrs = (tableView.dequeueReusableCell(withIdentifier: "InfrmtnadrsTableViewCell", for: indexPath) as? InfrmtnadrsTableViewCell)!
                billingadrs.Outerview.layer.cornerRadius = 5.0
                billingadrs.lblname.text=billingnamearray[indexPath.row]
                billingadrs.lbladrs1.text=billingstreetarray[indexPath.row]
                billingadrs.lbladrts2.text=billingcityarray[indexPath.row]
                billingadrs.lbladrs3.text=billingpostcodearray[indexPath.row]
                return billingadrs
            }else{
                shpngmethod = (tableView.dequeueReusableCell(withIdentifier: "InfrmtnshpnngmethodTableViewCell", for: indexPath) as? InfrmtnshpnngmethodTableViewCell)!
                shpngmethod.Outerview.layer.cornerRadius = 5.0
                shpngmethod.lblshpngmethod.text=shipngmethod
                return shpngmethod
            }
        }else{
        if indexPath.section==0{
            orderinfo = (tableView.dequeueReusableCell(withIdentifier: "OrderinformationTableViewCell", for: indexPath) as? OrderinformationTableViewCell)!
            orderinfo.Outerview.layer.cornerRadius = 5.0
            orderinfo.btnorderinfrmtn.addTarget(self, action: #selector(btnorderinfrmtn(sender:)), for: .touchUpInside)
            return orderinfo
        }else if indexPath.section==1{
            itemstataus = (tableView.dequeueReusableCell(withIdentifier: "OrderstatusTableViewCell", for: indexPath) as? OrderstatusTableViewCell)!
            itemstataus.Outerview.layer.cornerRadius = 5.0
            print("created",created)
            if self.status=="pending"||self.status=="processing"{
                let redcolor=UIColor(red: 210/255, green:  66/255, blue: 82/255, alpha: 1.0)
                self.itemstataus.lblstatus.backgroundColor=redcolor
            }else{
                let greencolor=UIColor(red: 93/255, green:  166/255, blue: 41/255, alpha: 1.0)
                self.itemstataus.lblstatus.backgroundColor=greencolor
            }
            itemstataus.lbldate.text=created
            itemstataus.lblstatus.text=status.uppercased()
            itemstataus.lblorderid.text="#"+incrementid
            if self.status=="pending"||self.status=="processing"{
                let redcolor=UIColor(red: 210/255, green:  66/255, blue: 82/255, alpha: 1.0)
                self.itemstataus.lblstatus.backgroundColor=redcolor
            }else{
                let greencolor=UIColor(red: 93/255, green:  166/255, blue: 41/255, alpha: 1.0)
                self.itemstataus.lblstatus.backgroundColor=greencolor
            }
            itemstataus.btninvoice.tag=indexPath.row
            itemstataus.btninvoice.addTarget(self, action: #selector(btninvoice(sender:)), for: .touchUpInside)
            return itemstataus
        }else if indexPath.section==2{
            itemname = (tableView.dequeueReusableCell(withIdentifier: "OrdernameTableViewCell", for: indexPath) as? OrdernameTableViewCell)!
            itemname.Outerview.layer.cornerRadius = 5.0
            print("qty_orderedarray...........",self.qty_orderedarray)
            print("namearray.........",self.namearray)
            
         // let delimiter="."
//            seperatedqtyordrd = qty_orderedarray[indexPath.row].components(separatedBy: delimiter)
//            print("seperatedqtyordrd.........",seperatedqtyordrd)
            itemname.lblitemsordered.text=String(qty_orderedarray[indexPath.row])+" Item(s) Ordered"
               itemname.lblitemname.text=namearray[indexPath.row]
            
    itemname.lblordered.text="Ordered: " + String(qty_orderedarray[indexPath.row])
            //let qtyrefunded=qty_refundedarray[indexPath.row].components(separatedBy: delimiter)
            itemname.lblrefunded.text="Refunded: " +  String(qty_refundedarray[indexPath.row])
            // let qtyshipped=qty_shippedarray[indexPath.row].components(separatedBy: delimiter)
               itemname.lblshipped.text="Shipped: " +  String(qty_shippedarray[indexPath.row])
           // let qtycancelled=qty_canceledarray[indexPath.row].components(separatedBy: delimiter)
               itemname.lblcancld.text="Cancelled: " +  String(qty_canceledarray[indexPath.row])
            let dbleprice=Double(pricearray[indexPath.row])
            itemname.lblprice.text="£"+String(format:"%.2f",dbleprice ?? 0)
            let dblesubtotal=Double(subtotal)
           // itemname.lblsubtotal.text="£"+String(format:"%.2f",dblesubtotal ?? 0)
            let url = URL(string:imagearray[indexPath.row])
            itemname.imageviewitem.kf.indicatorType = .activity
            itemname.imageviewitem.kf.setImage(with: url)
            itemname.imageviewitem.contentMode = .scaleToFill
            return itemname
        }else{
            itemprice = (tableView.dequeueReusableCell(withIdentifier: "OrderpriceTableViewCell", for: indexPath) as? OrderpriceTableViewCell)!
            itemprice.Outerview.layer.cornerRadius = 5.0
            let dblesubtotal=Double(subtotal)
            itemprice.lblsubtotal.text="£"+String(format:"%.2f",dblesubtotal ?? 0)
            let dblegrandtotal=Double(grndtotal)
             itemprice.lblgrandtotal.text="£"+String(format:"%.2f",dblegrandtotal ?? 0)
            let dbleshpmntamnt=Double(shipingamnt)
             itemprice.lblshpnghndlng.text="£"+String(format:"%.2f",dbleshpmntamnt ?? 0)
             let dblediscntamnt=Double(discountamnt)
            itemprice.lbldiscount.text="£"+String(format:"%.2f",dblediscntamnt ?? 0)
            let dbletaxamnt=Double(taxamnt)
            itemprice.lbltax.text="£"+String(format:"%.2f",dbletaxamnt ?? 0)
            return itemprice
        }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if orederinformationflag==1{
            if indexPath.section==0{
                return 83
            }else if indexPath.section==1{
                return 174
            }else if indexPath.section==2{
                return 174
            }else{
                return 126
            }
        }else{
        if indexPath.section==0{
            return 83
        }else if indexPath.section==1{
            return 145
        }else if indexPath.section==2{
            return 253
        }else{
            return 228
        }
        }
    }
    
    func serviceitemdetails(){
       self.showhud()
        var urlstring:String!
        
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/OrderedItems/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"+incrementid
        
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                print("json",json)
                self.namearray.removeAll()
                self.qty_orderedarray.removeAll()
                self.qty_invoicedarray.removeAll()
                self.qty_refundedarray.removeAll()
                self.qty_shippedarray.removeAll()
               // self.pricearray.append(price as! String)
                self.qty_canceledarray.removeAll()
                self.tax_amountarray.removeAll()
                self.imagearray.removeAll()
                for item in json{
                    let value: [String:Any] = item as! [String:Any]
                    let id = value["item_id"] as Any
                    self.name = value["name"] as! String
                    let qty_invoiced = value["qty_invoiced"] as! String
                    let qty_ordered = value["qty_ordered"] as! String
                    let qty_refunded = value["qty_refunded"] as! String
                    let qty_shipped = value["qty_shipped"] as! String
                    let price = value["price"]
                    let qty_canceled = value["qty_canceled"] as! String
                    let tax_amount = value["tax_amount"]
                    let image = value["image"]
                    let sku=value["sku"]
                    self.namearray.append(self.name )
                    self.skuarray.append(sku as! String)
                    
        
                    
                    self.qty_orderedarray.append(Int(Float(qty_ordered) ?? 0))
                    
                    
                    self.qty_invoicedarray.append(Int(Float(qty_invoiced) ?? 0))
                    self.qty_refundedarray.append(Int(Float(qty_refunded) ?? 0))
                    self.qty_shippedarray.append(Int(Float(qty_shipped) ?? 0))
                    self.pricearray.append(price as! String)
                    self.qty_canceledarray.append(Int(Float(qty_canceled) ?? 0))
                    self.tax_amountarray.append(tax_amount as! String)
                    self.imagearray.append(image as! String)
                    print("tax_amountarray",self.tax_amountarray)
                    print("qty_orderedarray",self.qty_orderedarray)
                    print("namearray",self.namearray)
                    print("refunded",self.qty_refundedarray)
                    
                    
                }
                DispatchQueue.main.async {
                    self.hud.hide(animated: true)
                    self.tableviewitemdetails.reloadData()
                }
                
            } catch{
                print("Error in parsing")
            }
           
            
            }.resume()
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
                self.shpngnamearray.removeAll()
                self.shpngstreetarray.removeAll()
                self.shpngcompanyarray.removeAll()
                self.shpngcityarray.removeAll()
                self.shpngpostcodearray.removeAll()
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let shippinginfo = value["shippingAddress"] as! NSArray
                    let billinginfo = value["billingAddress"] as! NSArray
                    for value1 in shippinginfo{
                        let shippingdata = shippingAddress1(shippinginfo: value1 as! [String : Any])
                        let lastname = shippingdata.lastname
                        print("lastname",lastname)
                        let firstname = shippingdata.firstname
                        let middlename = shippingdata.middlename
                        let company = shippingdata.company
                        let street = shippingdata.street
                        let city = shippingdata.city
                        let phone=shippingdata.telephone
                        let postcode=shippingdata.postcode
                        self.shpngnamearray.append(firstname+" "+middlename+" "+lastname)
                        self.shpngstreetarray.append(street)
                        self.shpngcompanyarray.append(company)
                        self.shpngcityarray.append(city)
                        self.shpngpostcodearray.append(postcode)
                        
                    }
                    self.billingnamearray.removeAll()
                    self.billingstreetarray.removeAll()
                    self.billingcompanyarray.removeAll()
                    self.billingcityarray.removeAll()
                    self.billingpostcodearray.removeAll()
                    for value2 in billinginfo{
                        let billingdata = billingAddress1(billinginfo: value2 as! [String : Any])
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
                        self.billingnamearray.append(firstname+" "+middlename+" "+lastname)
                        self.billingstreetarray.append(street)
                        self.billingcompanyarray.append(company)
                        self.billingcityarray.append(city)
                        self.billingpostcodearray.append(postcode)
                    }
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.tableviewitemdetails.reloadData()
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
