//
//  InvoicedetailsViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 20/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import MBProgressHUD

struct invoices{
    let entity_id : String
    let subtotal : String
    let order_id : String
    let increment_id : String
    let tax_amount : String
    let grand_total : String
    let shipping_amount : String
    let total_qty : String
    let discount_amount : String
    init(invoiceinfo :[String:Any]) {
        entity_id = invoiceinfo["entity_id"] as? String ?? ""
        subtotal = invoiceinfo["subtotal"] as? String ?? ""
        order_id = invoiceinfo["order_id"] as? String ?? ""
        increment_id = invoiceinfo["increment_id"] as? String ?? ""
        tax_amount = invoiceinfo["tax_amount"] as? String ?? ""
        grand_total = invoiceinfo["grand_total"] as? String ?? ""
        shipping_amount = invoiceinfo["shipping_amount"] as? String ?? ""
        total_qty = invoiceinfo["total_qty"] as? String ?? ""
        discount_amount = invoiceinfo["discount_amount"] as? String ?? ""
    }
}
struct shipments{
    let increment_id : String
    let total_qty : String
    init(shipmentinfo :[String:Any]) {
        increment_id = shipmentinfo["increment_id"] as? String ?? ""
        total_qty = shipmentinfo["total_qty"] as? String ?? ""
        
    }
}

class InvoicedetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
     var hud:MBProgressHUD=MBProgressHUD()
     var header:UIImageView!
     var itemname=String()
     var price=String()
    
    var invoiceshipment=Invoice_shipmentTableViewCell()
     var invoice=InvoiceTableViewCell()
     var taxamounarray=[Float]()
     var subtotalarray=[Float]()
     var grandtotalarray=[Float]()
     var shippingamountlarray=[Float]()
     var totalqtyarray=[Int]()
     var discountarray=[Float]()
    var incrementidnumber=String()
    var invoicenamearray=[String]()
    var shipmentflag=Int()
    
    var shipmentdetais=ShipmentdetailsTableViewCell()
    var shipmentstatus=ShipmentstatusTableViewCell()
    var allshipments=AllshipmentTableViewCell()
    var shipmentincrmtidarray=[String]()
     var shipmenttotalqtyarray=[Int]()
    var invoicestatus=String()
    var datecreated=String()
    var invoicesku=String()
    let cartbtn=SSBadgeButton()
    var cartnamearray=[String]()
    var firstname:String!
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var viewtoolbarheight: NSLayoutConstraint!
    @IBOutlet weak var viewtoolbar: UIView!
    @IBOutlet weak var tableviewinvoice: UITableView!
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
        //let btncart = UIBarButtonItem (image: cartlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.cartaction))
        let btnlogin = UIBarButtonItem (image: loginlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.loginaction))
        // let btnback = UIBarButtonItem (image: backlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.backaction))
        //navigationItem.setRightBarButtonItems([btnlogin,btncart,btnsearch], animated: true)
        cartbtn.addTarget(self, action: #selector(cartaction), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [btnlogin,UIBarButtonItem(customView: cartbtn),btnsearch]
       
        
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
       
        
        tableviewinvoice.register(UINib(nibName: "InvoiceTableViewCell", bundle: nil), forCellReuseIdentifier: "InvoiceTableViewCell")
         tableviewinvoice.register(UINib(nibName: "ShipmentdetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "ShipmentdetailsTableViewCell")
         tableviewinvoice.register(UINib(nibName: "ShipmentstatusTableViewCell", bundle: nil), forCellReuseIdentifier: "ShipmentstatusTableViewCell")
         tableviewinvoice.register(UINib(nibName: "AllshipmentTableViewCell", bundle: nil), forCellReuseIdentifier: "AllshipmentTableViewCell")
         tableviewinvoice.register(UINib(nibName: "Invoice_shipmentTableViewCell", bundle: nil), forCellReuseIdentifier: "Invoice_shipmentTableViewCell")
       
        searchbar.isHidden=true

      serviceinvoices()
        
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
        if shipmentflag==1{
        return 3
         }else{
        return 2
        }
    }
    
//    @IBAction func btnshipmentaction(_ sender: Any) {
//        shipmentflag=1
//        viewtoolbarheight.constant=0
//        serviceshipment()
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shipmentflag==1{
            if section==0{
                return 1
            }else if section==1{
                return 1
            } else{
                return shipmentincrmtidarray.count
        }
        }else{
            if section==0{
                return 1
            }else{
        return taxamounarray.count
            }
        }
    }
      
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if shipmentflag==1{
            if indexPath.section==0{
             shipmentdetais = (tableView.dequeueReusableCell(withIdentifier: "ShipmentdetailsTableViewCell", for: indexPath) as? ShipmentdetailsTableViewCell)!
                shipmentdetais.shpmntbtninvoice.addTarget(self, action: #selector(btninvoice(sender:)), for: .touchUpInside)
             return shipmentdetais
            }else if indexPath.section==1{
                shipmentstatus = (tableView.dequeueReusableCell(withIdentifier: "ShipmentstatusTableViewCell", for: indexPath) as? ShipmentstatusTableViewCell)!
                if self.invoicestatus=="pending"||self.invoicestatus=="processing"{
                    let redcolor=UIColor(red: 210/255, green:  66/255, blue: 82/255, alpha: 1.0)
                    self.shipmentstatus.lblstatus.backgroundColor=redcolor
                }else{
                    let greencolor=UIColor(red: 93/255, green:  166/255, blue: 41/255, alpha: 1.0)
                    self.shipmentstatus.lblstatus.backgroundColor=greencolor
                }
                shipmentstatus.lblorderid.text="#"+incrementidnumber
                shipmentstatus.lbldate.text=datecreated
                shipmentstatus.lblstatus.text=invoicestatus.uppercased()
                 return shipmentstatus
            }else{
                allshipments = (tableView.dequeueReusableCell(withIdentifier: "AllshipmentTableViewCell", for: indexPath) as? AllshipmentTableViewCell)!
                //allshipments.lblsku.text="SKU: "+invoicesku
             allshipments.lblorderid.text="Shipment #"+shipmentincrmtidarray[indexPath.row]
                allshipments.lblqtyshipped.text="QTY SHIPPED: "+String(shipmenttotalqtyarray[indexPath.row])
                return allshipments
            }
        }else{
            if indexPath.section==0{
                invoiceshipment = (tableView.dequeueReusableCell(withIdentifier: "Invoice_shipmentTableViewCell", for: indexPath) as? Invoice_shipmentTableViewCell)!
                 invoiceshipment.btnordershipmnt.addTarget(self, action: #selector(shipmentbtninvoice(sender:)), for: .touchUpInside)
                return invoiceshipment
            }else{
        invoice = (tableView.dequeueReusableCell(withIdentifier: "InvoiceTableViewCell", for: indexPath) as? InvoiceTableViewCell)!
        invoice.Outerview.layer.cornerRadius = 5
        //invoice.lbltax.text="£"+String(format: "%.2f",taxamounarray[indexPath.row])
        invoice.lblqty.text=String(totalqtyarray[indexPath.row])
        let dbleprice=Double(price)
        invoice.lblprice.text="£"+String(format:"%.2f",dbleprice ?? 0)
        invoice.lbldscnt.text="£"+String(format: "%.2f",discountarray[indexPath.row])
        invoice.lblshipping.text="£"+String(format: "%.2f",shippingamountlarray[indexPath.row])
        invoice.lblsubtotal.text="£"+String(format: "%.2f",subtotalarray[indexPath.row])
        invoice.lblgrandtotal.text="£"+String(format: "%.2f",grandtotalarray[indexPath.row])
                invoice.lblordername.text="# "+incrementidnumber
                invoice.lbltax.text="£"+String(format: "%.2f",taxamounarray[indexPath.row])
       // invoice.lblordername.text=invoicenamearray[indexPath.row]
        return invoice
        }
    }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if shipmentflag==1{
           if indexPath.section==0{
            return 83
           }else if indexPath.section==1{
            return 145
           }else{
            return 111
           }
        }else{
            if indexPath.section==0{
        return 83
        }else{
            return 273
        }
        }
    }
        
    @objc func btninvoice(sender: UIButton){
        shipmentflag=0
        serviceinvoices()
    }
    @objc func shipmentbtninvoice(sender: UIButton){
            shipmentflag=1
            serviceshipment()
        }
    
    
    
    func serviceinvoices(){
        self.showhud()
        var urlstring:String!
        
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/getinvoice/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"+incrementidnumber
        
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let invoiceinfo = value["invoices"] as! NSArray
                    if invoiceinfo.count != 0{
                        self.taxamounarray.removeAll()
                        self.subtotalarray.removeAll()
                        self.grandtotalarray.removeAll()
                        self.shippingamountlarray.removeAll()
                        self.totalqtyarray.removeAll()
                        self.discountarray.removeAll()
                        for value in invoiceinfo{
                            let invoicedata = invoices(invoiceinfo: value as! [String : Any])
                            print("invoiceinfo",invoiceinfo)
                            let entityid=invoicedata.entity_id
                            let incrementid=invoicedata.increment_id
                            let subtotal=Float(invoicedata.subtotal)
                            let taxamount=Float(invoicedata.tax_amount)
                            let grandtotal=Float(invoicedata.grand_total)
                            let shippingamount=Float(invoicedata.shipping_amount)
                            let totalqty=Float(invoicedata.total_qty)
                            let inttotalqty=Int(totalqty ?? 0)
                            let discount=Float(invoicedata.discount_amount)
                            self.taxamounarray.append(taxamount ?? 0)
                            self.subtotalarray.append(subtotal ?? 0)
                            self.grandtotalarray.append(grandtotal ?? 0)
                            self.shippingamountlarray.append(shippingamount ?? 0)
                            self.totalqtyarray.append(inttotalqty)
                            self.discountarray.append(discount ?? 0)
                        }
                        DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                       self.tableviewinvoice.reloadData()
                    }
                    }else{
                        let alert = UIAlertController(title: "Alert", message: "No invoice details found", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                            print("Invalidlogin")
                        }))
                        self.present(alert, animated: true)
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            
                        }
                    }
            }
            }
            catch{
                print("Error in parsing")
                let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                    print("Invalidlogin")
                }))
                self.present(alert, animated: true)
                DispatchQueue.main.async {
                    self.hud.hide(animated: true)
                    self.tableviewinvoice.reloadData()
                }
            }
            
            
            }.resume()
    
    }
    
    func serviceshipment(){
        self.showhud()
        var urlstring:String!
        
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/getshipment/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"+incrementidnumber
        
        
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let shipmentinfo = value["shipments"] as! NSArray
                    if shipmentinfo.count != 0{
                        self.shipmentincrmtidarray.removeAll()
                        self.shipmenttotalqtyarray.removeAll()
                        for value in shipmentinfo{
                            let shipmentdata = shipments(shipmentinfo: value as! [String : Any])
                           
                            let incrementid=shipmentdata.increment_id
            
                            let totalqty=shipmentdata.total_qty
                           
                           self.shipmentincrmtidarray.append(incrementid)
                            self.shipmenttotalqtyarray.append(Int(Float(totalqty) ?? 0))
                            
                        }
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            self.tableviewinvoice.reloadData()
                        }
                    }else{
                        let alert = UIAlertController(title: "Alert", message: "No shipment details found", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                            print("Invalidlogin")
                        }))
                        self.present(alert, animated: true)
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        }
                    }
                }
            }
            catch{
                print("Error in parsing")
//                DispatchQueue.main.async {
//                    self.hud.hide(animated: true)
//                }
            }
            
            
            }.resume()
        
    }
                
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }

}
