//
//  MyBagViewController.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 12/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import MBProgressHUD

class MyBagViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var tableviewpayableamount: UITableView!
    
    @IBOutlet weak var lblmybay: UILabel!
    @IBOutlet weak var btnproceedchckout: UIButton!
    @IBOutlet var tableviewmybag: UITableView!
    var navigationBar:UINavigationBar!
    var itemdetails=ItemdetailsTableViewCell()
    var checkpincode=CheckpincodeTableViewCell()
    var promocode=PromocodeTableViewCell()
    var payableamount=PayableAmountTableViewCell()
    var namearray=[String]()
    var pricearray=[String]()
    var imagearray=[String]()
    var qtyarray=[String]()
    var subtotalarray=[Double]()
    var cartnamearray=[String]()
    var cartimagearray=[String]()
    var cartpricearray=[String]()
    var cartqtyarray=[String]()
    var newpricearray=[Double]()
    var totalpay=String()
    var paynonce:String!
    var firstname:String!
    var tempvalue=Int()
    var tempprice=String()
    var pricevalue=Int()
    var btnplusarray=[String]()
    var totalamount=Double()
    var totalarray=[Double]()
    var btnplusminusflag=Int()
    var totalquantityarray=[Int]()
    var skuidarray=[String]()
    var email:String!
    var whishlistskuid=String()
    var wishlistflag=Int()
    var productnamearray=[String]()
    var whishlistnamearray=[String]()
    var couponcodeflag=Int()
    var discountamount=String()
    var hud:MBProgressHUD=MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor(red: 243 / 255, green: 195 / 255, blue: 8 / 255, alpha: 1.0)
        
        topview.isHidden=true
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        
      
        topview.backgroundColor=color
         tableviewmybag.register(UINib(nibName: "ItemdetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemdetailsTableViewCell")
        tableviewmybag.register(UINib(nibName: "CheckpincodeTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckpincodeTableViewCell")
        tableviewmybag.register(UINib(nibName: "PromocodeTableViewCell", bundle: nil), forCellReuseIdentifier: "PromocodeTableViewCell")
    //navigationItem.title="My bag (" + String(namearray.count)+" items)"
        
//        let btnsback = backButton(imageName: "back", selector: #selector(back))
        
//        backbtn.setBackgroundImage(UIImage(named: "back"), for: .normal)
//        backbtn.frame = CGRect(x: 0, y: 0, width:30, height: 30)
//        backbtn.backgroundColor = UIColor.clear
//        backbtn.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        backbtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
//        backbtn.addTarget(self, action: #selector(back), for: .touchUpInside)
//        lblmybay.text="My bag (" + String(namearray.count)+" items)"
          self.hideKeyboardWhenTappedAround()
        
    }
    var wisharray = [Bool]()
    
    func wishlist(){
       var whislist=Bool()
        wisharray.removeAll()
        for value in self.namearray{//cart items
            
            for item in self.productnamearray{ //wishlist items
                
                if value==item{
                   whislist=true
                    break
                    
                }else {
                    whislist=false
                }
                
                
            }
            self.wisharray.append(whislist)
           
        }
        print("namearray:",namearray)
        print("productnamearray:",self.productnamearray)
        print("wisharray:",wisharray)
        
        DispatchQueue.main.async {
            self.tableviewmybag.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
    super.viewWillAppear(animated)
        
        firstname = UserDefaults.standard.value(forKey: "name") as? String
        print("firstname",firstname)
        
       

        
        namearray=UserDefaults.standard.stringArray(forKey: "cartbadge") as! [String]
        pricearray=UserDefaults.standard.stringArray(forKey: "cartprice") as! [String]
        imagearray=UserDefaults.standard.stringArray(forKey: "cartimage") as! [String]
        qtyarray=UserDefaults.standard.stringArray(forKey: "cartqty") as! [String]
        subtotalarray=UserDefaults.standard.array(forKey: "totalprice") as! [Double]
        newpricearray=UserDefaults.standard.array(forKey: "newprice") as! [Double]
        totalquantityarray=UserDefaults.standard.array(forKey: "totalquantity") as! [Int]
        skuidarray=UserDefaults.standard.array(forKey: "skuvalue") as! [String]
       
        
        
        
        
       // lblmybay.text="My bag (" + String(namearray.count)+" items)"
        print("namearray",namearray)
        print("qtyarray",qtyarray)
        print("pricearray",pricearray)
        print("imagearray",imagearray)
        print("subtotalarray",subtotalarray)
        print("newpricearray",newpricearray)
         print("totalquantityarray",totalquantityarray)
        if firstname == "Hi Guest" || firstname == nil{

        }else{
            serviceviewwhishlist()
//            wishlist()


        }
        
      
        let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
         title = "My bag (" + String(namearray.count)+" items)"
//        let titleAttributes = [
//            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 50)
//        ]
//        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
//       
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: 20.0)
        lbl.textColor = .black
        lbl.textAlignment = .center
        navigationItem.titleView=lbl
        

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
    
    func serviceviewwhishlist(){
        
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
                  
//                    self.productnamearray.removeAll()
                   
                    for item in json{
                        let value : [String:Any] = item as! [String : Any]
                        if (value["wishlistItems"]) != nil{
                            let whishlistdata = value["wishlistItems"] as! NSArray
                            print("logindata",whishlistdata as Any)
                            
                            self.productnamearray.removeAll()
                            for value in whishlistdata{
                                let whishlist=wishlistItems(wishlistdata: value as! [String : Any])
                                print("productname",whishlist)
                                let productname=whishlist.ProductName
                               
                                self.productnamearray.append(productname)
                                
                            }
                            print("wish_productnamearray",self.productnamearray)
                           
                            
                        }
                }
                     self.wishlist()
//                    DispatchQueue.main.async {
//                 self.tableviewmybag.reloadData()
//                    }
                    
                    
                }
                catch {
                    print(error)
                }
            }
            }.resume()
        }
  
    
    @IBAction func btnprcdchckout(_ sender: Any) {
        if firstname == "Hi Guest" || firstname == nil{
                        let login = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
                       login.checkoutflag=1
                        self.navigationController?.pushViewController(login, animated: false)
        }else
        if namearray.count==0{
            let emptycart = self.storyboard?.instantiateViewController (withIdentifier: "EmptycartViewController") as! EmptycartViewController
            
            self.navigationController?.pushViewController(emptycart, animated: false)
        }else{
            let ordersummary = self.storyboard?.instantiateViewController (withIdentifier: "OrdersummaryViewController") as! OrdersummaryViewController
           // ordersummary.imagearray=imagearray[]
            
            self.navigationController?.pushViewController(ordersummary, animated: false)
        }

//        self.present(ordersummary, animated: false)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "OrdersummaryViewController")
//        self.present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func backaction(_ sender: Any) {
         performSegueToReturnBack()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableView.tag==2{
            return 2
        }else{
        return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag==3{
            return 1
        }else{
        if section==0{
            return namearray.count
            
        }
//        else if section==1{
//            return 1
//        }
        else {
            return 1
        }
        }
    }
    
    @objc func btnplustapped(sender: UIButton){
        couponcodeflag=0
        btnplusminusflag=1
        tempvalue=Int(qtyarray[sender.tag])!
         print("totalquantityarray[sender.tag]",totalquantityarray[sender.tag])
        if tempvalue >= totalquantityarray[sender.tag]{
            print("totalquantityarray[sender.tag]",totalquantityarray[sender.tag])
        let alert = UIAlertController(title: "", message: "Quantity exceeds the total quantity available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else{
        tempvalue=tempvalue + 1
        qtyarray[sender.tag]=String(tempvalue)
        print("pricearray[sender.tag])",pricearray[sender.tag])
        print("tempvalue",tempvalue)
        print("qtyarray",qtyarray)
        UserDefaults.standard.set(qtyarray, forKey: "cartqty")
        

        print("pricearray",pricearray)
        print("subtotalarray",subtotalarray)
        print("newpricearray",newpricearray)
        //tempprice=pricearray[sender.tag]
        let newprice=newpricearray[sender.tag] + Double(pricearray[sender.tag])!
        print("newprice",newprice)
        pricearray[sender.tag]=String(newprice)
        subtotalarray[sender.tag]=newprice
         UserDefaults.standard.set(pricearray, forKey: "cartprice")
         UserDefaults.standard.set(subtotalarray, forKey: "totalprice")
//        pricearray=UserDefaults.standard.array(forKey: "cartprice") as! [String]
        print("pricearray",pricearray)
        print("subtotalarray",subtotalarray)
        
//        tempprice=pricearray[sender.tag]
//        print("tempprice",tempprice)
//        pricevalue=tempvalue*Int(Double(tempprice)!)
//        pricearray[sender.tag]=String(pricevalue)
//        subtotalarray.append(Double(pricevalue))
        }
        self.tableviewmybag.reloadData()
        self.tableviewpayableamount.reloadData()
    }
    
    
    
      @objc func btnminustapped(sender: UIButton){
         couponcodeflag=0
        btnplusminusflag=0
         tempvalue=Int(qtyarray[sender.tag])!
        if tempvalue==1{
            tempvalue=Int(qtyarray[sender.tag])!
            qtyarray[sender.tag]=String(tempvalue)
            
            let newprice=newpricearray[sender.tag]
            pricearray[sender.tag]=String(newprice)
            subtotalarray[sender.tag]=newprice
        }else{
            tempvalue=tempvalue-1
        qtyarray[sender.tag]=String(tempvalue)
        let newprice=Double(pricearray[sender.tag])!-newpricearray[sender.tag]
        print("newprice",newprice)
        pricearray[sender.tag]=String(newprice)
        subtotalarray[sender.tag]=newprice
        }
        UserDefaults.standard.set(qtyarray, forKey: "cartqty")
        UserDefaults.standard.set(pricearray, forKey: "cartprice")
        UserDefaults.standard.set(subtotalarray, forKey: "totalprice")
        self.tableviewmybag.reloadData()
        self.tableviewpayableamount.reloadData()
        
    }
   
    
    
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            print("couponcodeflag",couponcodeflag)
            let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
            title = "My bag (" + String(namearray.count)+" items)"
            lbl.text = title
            lbl.font = UIFont.systemFont(ofSize: 20.0)
            lbl.textColor = .black
            lbl.textAlignment = .center
            navigationItem.titleView=lbl
            
            
            if tableView.tag==2{
                if indexPath.section==0{
                    itemdetails = (tableView.dequeueReusableCell(withIdentifier: "ItemdetailsTableViewCell", for: indexPath) as? ItemdetailsTableViewCell)!
                    itemdetails.Outerview.layer.cornerRadius = 5.0
                    itemdetails.lbltitle.text=namearray[indexPath.row]
//                    let price=(Float(qtyarray[indexPath.row]) ?? 1)*(Float (pricearray[indexPath.row]) ?? 1)
                    let price=Float(pricearray[indexPath.row])
                    print("price",price)
                    itemdetails.lblprice.text="£ "+String(format:"%.2f",price!)
                   // itemdetails.lblprice.text=pricearray[indexPath.row]
                    itemdetails.txtfldqty.text=qtyarray[indexPath.row]
                    let url = URL(string:imagearray[indexPath.row])
                    itemdetails.image1.kf.indicatorType = .activity
                    itemdetails.image1.kf.setImage(with: url)
                    itemdetails.image1.contentMode = .scaleToFill
                    itemdetails.btnclose.tag=indexPath.row
                    itemdetails.btnclose.addTarget(self, action: #selector(btncloseactn(sender:)), for: .touchUpInside)
                    itemdetails.btnplus.tag=indexPath.row
                    itemdetails.btnminus.tag=indexPath.row
                    itemdetails.btnplus.addTarget(self, action: #selector(btnplustapped(sender:)), for: .touchUpInside)
                      itemdetails.btnminus.addTarget(self, action: #selector(btnminustapped(sender:)), for: .touchUpInside)
                    itemdetails.btnwishlist.tag=indexPath.row
                     itemdetails.btnwishlist.addTarget(self, action: #selector(btnwhishlisttapped(sender:)), for: .touchUpInside)
//                    var counter=0
//                    var btntagarray=[String]()
                    
                    if self.wisharray.count != 0{
                        print(wisharray[indexPath.row])
                        if self.wisharray[indexPath.row]==true{
                            self.itemdetails.btnwishlist.setImage(UIImage (named: "heart_red"), for: .normal)
                        }else{
                            self.itemdetails.btnwishlist.setImage(UIImage (named: "heart_gray"), for: .normal)
                        }
                    }
                    
                    
            
                    return itemdetails
                    
                }
//                else if indexPath.section==1{
//                    checkpincode = (tableView.dequeueReusableCell(withIdentifier: "CheckpincodeTableViewCell", for: indexPath) as? CheckpincodeTableViewCell)!
//                    checkpincode.Outerview.layer.cornerRadius = 5.0
//                    //checkpincode.isHidden=true
//                    return checkpincode
//                }
                else{
                    promocode = (tableView.dequeueReusableCell(withIdentifier: "PromocodeTableViewCell", for: indexPath) as? PromocodeTableViewCell)!
                    promocode.Outerview.layer.cornerRadius = 5.0
                    promocode.btnapply.layer.cornerRadius=5
                    promocode.btnapply.addTarget(self, action: #selector(promoapplyaction(sender:)), for: .touchUpInside)
                    //promocode.isHidden=true
                    if couponcodeflag==1{
                        promocode.txtpromo.text=""
                    }
                    return promocode
                }
            }else{
                
                payableamount = (tableView.dequeueReusableCell(withIdentifier: "PayableAmountTableViewCell", for: indexPath) as? PayableAmountTableViewCell)!
              
                
                var sum:Double=0.00
                var discount=Double()
                print("subtotalarray",subtotalarray)
                if couponcodeflag==1{
                    for value in subtotalarray{
                        sum += value
                       
                        
                    }
                    discount=sum-Double(discountamount)!
                    //let amount:Double=Double(discountamount)
                    payableamount.lbldiscountamount.text="£ "+String(format:"%.2f",Double(discountamount)!)
                    //payableamount.lbldiscountamount.text="£ "+discountamount
                    //payableamount.lblsumtot.text=pricearray[indexPath.row]
                    //payableamount.lblsumtot.text="£ "+String(format:"%.2f",discount)
                    payableamount.lbltotalpay.text="£ "+String(format:"%.2f",discount)
                    UserDefaults.standard.set(discount, forKey: "totalpay")
                    //UserDefaults.standard.set(discount, forKey: "subtotaldiscount")
                }else{
           
                for value in subtotalarray{
                    sum += value
                }
                print("sum",sum)
              payableamount.lbldiscountamount.text="£ "+"0.00"
//                totalamount = UserDefaults.standard.double(forKey: "totalpay")
                payableamount.lblsumtot.text="£ "+String(format:"%.2f",sum)
                payableamount.lbltotalpay.text="£ "+String(format:"%.2f",sum)
            
                UserDefaults.standard.set(sum, forKey: "subtotaldiscount")
                 UserDefaults.standard.set(sum, forKey: "totalpay")
                }
                
                return payableamount
            }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag==3{
            
            return 105
            
        }else{
        if indexPath.section==0{
            return 151
        }
//        else if indexPath.section==1{
//            return 120
//        }
        else {
            return 122
        }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func btnwhishlisttapped(sender: UIButton){
       //print("wisharray[sender.tag]",wisharray[sender.tag])
        if firstname == "Hi Guest" || firstname == nil{
            let login = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
            self.navigationController?.pushViewController(login, animated: false)
        }else if sender.currentImage == UIImage(named: "heart_red"){
            //itemdetails.btnwishlist.currentImage == UIImage (named: "heart_gray") {
            
          
           // sender.setImage(UIImage (named: "heart_gray"), for: .normal)
        whishlistskuid=skuidarray[sender.tag]
       servicewhishlistremove()
            
        }else if sender.currentImage == UIImage(named: "heart_gray"){
            //itemdetails.btnwishlist.currentImage == UIImage (named: "heart_red"){
            
            
            //sender.setImage(UIImage(named: "heart_red"), for: .normal)
            whishlistskuid=skuidarray[sender.tag]
            serviceaddtowhishlist()
           
             //self.tableviewmybag.reloadData()
            
        }else{
            
        }
    }
    
    @objc func btncloseactn(sender: UIButton){
        couponcodeflag=0
        print("namearray",namearray)
        print("sender.tag",sender.tag)
        print(namearray[sender.tag])
        namearray.remove(at: sender.tag)
        pricearray.remove(at: sender.tag)
        imagearray.remove(at: sender.tag)
        qtyarray.remove(at: sender.tag)
        subtotalarray.remove(at: sender.tag)
        skuidarray.remove(at: sender.tag)
        wisharray.remove(at: sender.tag)
        print("namearray",namearray)
        print("pricearray",pricearray)
        print("imagearray",imagearray)
        print("qtyarray",qtyarray)
        print("subtotalarray",subtotalarray)
        
         UserDefaults.standard.set(skuidarray, forKey: "skuvalue")
         UserDefaults.standard.set(namearray, forKey: "cartbadge")
         UserDefaults.standard.set(pricearray, forKey: "cartprice")
         UserDefaults.standard.set(imagearray, forKey: "cartimage")
         UserDefaults.standard.set(qtyarray, forKey: "cartqty")
         UserDefaults.standard.set(subtotalarray, forKey: "totalprice")
        cartnamearray=UserDefaults.standard.stringArray(forKey: "cartbadge") as! [String]
        cartpricearray=UserDefaults.standard.stringArray(forKey: "cartprice") as! [String]
        cartimagearray=UserDefaults.standard.stringArray(forKey: "cartimage") as! [String]
        cartqtyarray=UserDefaults.standard.stringArray(forKey: "cartqty") as! [String]
        subtotalarray=UserDefaults.standard.array(forKey: "totalprice") as! [Double]
        skuidarray=UserDefaults.standard.array(forKey: "skuvalue") as! [String]
         print("subtotalarray",subtotalarray)
        print("cartnamearray",cartnamearray)
         print("cartpricearray",cartpricearray)
        //subtotalarray.removeAll()
        if cartpricearray.count==0{
            let emptycart = self.storyboard?.instantiateViewController (withIdentifier: "EmptycartViewController") as! EmptycartViewController
            emptycart.emptycartflag=1
            self.navigationController?.pushViewController(emptycart, animated: false)
           // subtotalarray.append(0.00)
        }else{
//            subtotalarray.removeAll()
//        for i in 0...cartpricearray.count-1{
//            print("pricearray",pricearray)
//             print("qtyarray",qtyarray)
//            let subtotal=(Double(qtyarray[i]) ?? 1)*(Double (pricearray[i]) ?? 1)
//            subtotalarray.append(subtotal)
//            print("subtotalarray",subtotalarray)
        }

//
//
        
       // }
//        UserDefaults.standard.set(subtotalarray, forKey: "subtotal")
//        subtotalarray=UserDefaults.standard.stringArray(forKey: "subtotal") as! [Float]
        
       
        self.tableviewmybag.reloadData()
         self.tableviewpayableamount.reloadData()
        print("namearray",namearray)
    }
    
    
    
    
    
    @objc func promoapplyaction(sender: UIButton){
        if promocode.txtpromo.text==""{
            let alert = UIAlertController(title: "", message: "Please enter a discount code", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else{
            couponcodeflag=1
            servicecopouncodevalidation()
        }
    }
   

func serviceaddtowhishlist(){
    
   
    email = UserDefaults.standard.value(forKey: "email") as? String
    let parameters:[String: Any] = ["token":"33urorbe0o4fqu8jwpu25jbtowi8p5uc","email":email,"sku":whishlistskuid,"action":"add"]
    print("params",parameters)

    guard let url=URL(string : "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/addtoWishlist")else{return}
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
                                
//                                { action in
//                            let whishlist=self.storyboard?.instantiateViewController(withIdentifier: "MywhishlistViewController")as! MywhishlistViewController
//                         self.navigationController?.pushViewController(whishlist, animated: true)
//
//                                }
                           // ))
                                
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
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
    
                                                }
                             self.serviceviewwhishlist()
                            self.wishlist()
                                            }
//                        DispatchQueue.main.async {
//                       self.tableviewmybag.reloadData()
//
//                        }
                       
                    
                        
                    } catch let error as NSError {
                        print(error)
                    }
                }
                

            }
        }
        }

        .resume()
}
    func servicewhishlistremove(){
         wishlistflag=0
        print("whishlistsku",whishlistskuid)
        var params=[String:AnyObject]()
        email = UserDefaults.standard.value(forKey: "email") as? String
        params = ["email" :email as AnyObject,"token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc" as AnyObject,"sku" :whishlistskuid as AnyObject,"action" : "remove" as AnyObject]
        
        
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
                               self.serviceviewwhishlist()
                                self.wishlist()
                            }
//
//                            DispatchQueue.main.async {
////                               // self.hud.hide(animated: true)
//                                                                    self.tableviewmybag.reloadData()
//                            }
                          
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                    
                    
                }
            }
            }
            
            .resume()
    }
  
    
    
    func servicecopouncodevalidation(){
       
        var params=[String:AnyObject]()
        
            params = ["token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc" as AnyObject,"couponCode" :promocode.txtpromo.text as AnyObject]
     self.showhud()
        guard let url=URL(string :"https://cheshirecheesecompany.co.uk/draft2/rest/V1/capi/couponCodevalidation")else{return}
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
                    let jsonsignup = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                    
                    print("jsonsignup",jsonsignup)
                    
                    if (jsonsignup.value(forKey: "status") != nil) {
                        let status = jsonsignup.value(forKey: "status") as! String
                        print("test",status as Any)
                       
                       // let message=jsonsignup.value(forKey: "message") as! String
                        if status=="TRUE"{
                             let data = jsonsignup.value(forKey: "data") as! NSDictionary
                            self.discountamount=data.value(forKey: "discount_amount")as!String
                            print("discountamount",self.discountamount)
                            let alert = UIAlertController(title: "", message: "The coupon is active" , preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            
                            self.present(alert, animated: true)
                            DispatchQueue.main.async {
                                self.hud.hide(animated: true)
                                self.tableviewpayableamount.reloadData()
                            }
                        
                        }else{
                            
                             let message=jsonsignup.value(forKey: "message") as! String
                            let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                            self.present(alert, animated: true)
                            
                        }
                        
                    }else{
                        //let message=jsonsignup.value(forKey: "message") as! String
                        let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        
                    }
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.tableviewmybag.reloadData()
                    }
                    
                }
                 
                catch{
                    
                    print(error)
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




extension MyBagViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: false, completion: nil)
            
        }
    }
}

