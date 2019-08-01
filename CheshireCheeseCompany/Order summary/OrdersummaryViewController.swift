//
//  OrdersummaryViewController.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 13/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import MBProgressHUD
import Braintree
import PassKit
import Kingfisher


struct orderCustomerInfo{
    let email : String
    let firstname : String
    let middlename : String
    let lastname : String
    let default_billing : String
    let default_shipping : String
    init(customerinfo :[String:Any]) {
        email = customerinfo["email"] as? String ?? ""
        firstname = customerinfo["firstname"] as? String ?? ""
        middlename = customerinfo["middlename"] as? String ?? ""
        lastname = customerinfo["lastname"] as? String ?? ""
        default_billing = customerinfo["default_billing"] as? String ?? ""
        default_shipping = customerinfo["default_shipping"] as? String ?? ""
    }
}


struct ordershippingAddress{
    let company : String
    let firstname : String
    let middlename : String
    let lastname : String
    let telephone : String
    let street : String
    let city : String
    let postcode : String
    let region : String
    let country_id : String
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
        country_id = shippinginfo["country_id"] as? String ?? ""
    }
}

struct orderbillingAddress{
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
    }
}


class OrdersummaryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,PKPaymentAuthorizationViewControllerDelegate {
    
    var name=PKContact()
    var braintreeClient: BTAPIClient?
    let tokenizationKey="sandbox_v25wgx2t_bkrn3b56nfnkh582"
    var height=0
    var width=0
    var paynonce:String!
    var navigationBar:UINavigationBar!
    @IBOutlet weak var viewordersummary: UIView!
    @IBOutlet weak var btbback: UIButton!
    @IBOutlet weak var tableviewordersummary: UITableView!
    var orderaddress=OrderAddressTableViewCell()
    var ordersummary=OrdersummaryTableViewCell()
    
    @IBOutlet weak var btnconfirmpay: UIButton!
    @IBOutlet weak var lblsubtotal: UILabel!
    @IBOutlet weak var lblstringpayamunt: UILabel!
    @IBOutlet weak var lblstringshpngchrge: UILabel!
    @IBOutlet weak var lblpayamount: UILabel!
    @IBOutlet weak var lblfree: UILabel!
    @IBOutlet weak var lblstringsubtotal: UILabel!
    @IBOutlet weak var Outerview: UIView!
    
    var defaultshipping=String()
    var defaultbilling=String()
    
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
    
     var hud:MBProgressHUD=MBProgressHUD()
    var email:String!
    var namearray=[String]()
    var pricearray=[String]()
    var imagearray=[String]()
    var qtyarray=[String]()
    var totalpay:Double!
    var password:String!
    var skuidarray=[String]()
     var newarray=[String:Any]()
    var totalarray=[[String:Any]]()
    var customerfirstname=String()
    var customerlastname=String()
    var customernamearray=[String]()
    
    var billingregion=String()
    var billingcity=String()
    var billingstreet=String()
    var billingpostcode=String()
    var billingcountryid=String()
    var billingtelephone=String()
    
    var shippingregion=String()
    var shippingcity=String()
    var shippingstreet=String()
    var shippingpostcode=String()
    var shippingcountryid=String()
    var shippingtelephone=String()
    
    var shippingmethod=String()
    var paymentmethod=String()
    var subtotaldiscount=Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        height=Int(UIScreen.main.bounds.size.height)
        width=Int(UIScreen.main.bounds.size.width)
        servicecustomerinfobyemail()
        self.btnconfirmpay.isHidden=true
        viewordersummary.isHidden=true
       
        email = UserDefaults.standard.value(forKey: "email") as? String
        
        
        self.navigationItem.hidesBackButton = true
        navigationItem.title="Order Summary"

        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback

        tableviewordersummary.register(UINib(nibName: "OrderAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderAddressTableViewCell")
        tableviewordersummary.register(UINib(nibName: "OrdersummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "OrdersummaryTableViewCell")
        
//        btbback.setBackgroundImage(UIImage(named: "back"), for: .normal)
//        btbback.frame = CGRect(x: 0, y: 0, width:30, height: 30)
//        btbback.backgroundColor = UIColor.clear
//        btbback.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        btbback.heightAnchor.constraint(equalToConstant: 25).isActive = true
//        btbback.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        braintreeClient = BTAPIClient(authorization: tokenizationKey )
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex, PKPaymentNetwork.discover]) {
            PKPaymentNetwork.init(rawValue:  "4761 1200 1000 0492")
            let button = self.applePayButton()
            button.frame = CGRect(x:0, y:height-50, width: width, height:50)
            self.view.addSubview(button)
        }else {
            print(false)
        }
    
       
       
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.btnconfirmpay.isHidden=true
        namearray=UserDefaults.standard.stringArray(forKey: "cartbadge") as! [String]
        pricearray=UserDefaults.standard.stringArray(forKey: "cartprice") as! [String]
        
        imagearray=UserDefaults.standard.stringArray(forKey: "cartimage") as! [String]
        qtyarray=UserDefaults.standard.stringArray(forKey: "cartqty") as! [String]
        subtotaldiscount=UserDefaults.standard.double(forKey: "subtotaldiscount")
        
        totalpay=UserDefaults.standard.double(forKey: "totalpay")
        print("subtotaldiscount",subtotaldiscount)
         lblsubtotal.text="£ " + String(format:"%.2f",subtotaldiscount)
        lblpayamount.text="£ " + String(format:"%.2f",totalpay)
        
       
        skuidarray=UserDefaults.standard.array(forKey: "skuvalue") as! [String]
        
        
        
        
        let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
        var title = "Order Summary"
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
        
        print("qtyarray",qtyarray)
        print("pricearray",pricearray)
        print("skuidarray",skuidarray)
        var counter=0
        for value in 0...qtyarray.count-1{
            let qnty=value
            print("qnty",qnty)
            let data:[String:Any]=["qty":qtyarray[value],"sku":skuidarray[value],"price":pricearray[value]]
            print("data",data)
            //var totalarray=[[String:Any]]()
            totalarray.append(["qty":qtyarray[value],"sku":skuidarray[value],"price":pricearray[value]])
           
            
            
        }
       
        for values in 0...totalarray.count-1{
            
            let sku="sku\(counter+1)"
            newarray["sku\(counter+1)"] = totalarray[values]
           
            counter+=1
            
        }
         print("newarray",newarray)
        
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
    
    func applePayButton() -> UIButton {
        var button: UIButton?
        
        if #available(iOS 8.3, *) { // Available in iOS 8.3+
            button = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        } else {
            // TODO: Create and return your own apple pay button
            // button = ...
        }
        
        button?.addTarget(self, action: #selector(tappedApplePay), for: UIControlEvents.touchUpInside)
        
        return button!
    }
    
    func setupPaymentRequest(completion: @escaping (PKPaymentRequest?, Error?) -> Void) {
        let applePayClient = BTApplePayClient(apiClient: self.braintreeClient!)
        // You can use the following helper method to create a PKPaymentRequest which will set the `countryCode`,
        // `currencyCode`, `merchantIdentifier`, and `supportedNetworks` properties.
        // You can also create the PKPaymentRequest manually. Be aware that you'll need to keep these in
        // sync with the gateway settings if you go this route.
        applePayClient.paymentRequest { (paymentRequest, error) in
            guard let paymentRequest = paymentRequest else {
                completion(nil, error)
                return
            }
            
            var contact = PKContact()
            //            var phonenumber=CNPhoneNumber()
            
            var name = PersonNameComponents()
            name.givenName = self.shpngnamearray[0]
            //name.familyName = "santia"
            contact.name = name
            
            var address = CNMutablePostalAddress()
            address.street = self.shpngstreetarray[0]
            address.city =  self.shpngcityarray[0]
            address.state = "UK"
            address.postalCode = self.shpngpostcodearray[0]
            contact.phoneNumber=CNPhoneNumber(stringValue: self.shpngtelephoneearray[0])
            contact.emailAddress=self.email
            contact.postalAddress = address
            
            
            paymentRequest.countryCode="GB"
           // paymentRequest.currencyCode="GBP"
            paymentRequest.merchantIdentifier="merchant.com.websight"
            paymentRequest.shippingContact = contact
           
    
        
            let shippingMethod = PKShippingMethod()
            shippingMethod.label="COD"
            //shippingMethod.amount=NSDecimalNumber(string: String(format:"%.2f",totalpay)
            shippingMethod.amount=NSDecimalNumber(string: String(self.totalpay))
            shippingMethod.identifier = "COD"
            shippingMethod.detail = "Delivery within 24hrs"
            paymentRequest.shippingMethods = [shippingMethod]
            
            
            paymentRequest.requiredShippingAddressFields=PKAddressField.all
            paymentRequest.merchantCapabilities = .capability3DS
            paymentRequest.paymentSummaryItems =
                [
                    PKPaymentSummaryItem(label: "SUBTOTAl", amount: NSDecimalNumber(string: String(self.subtotaldiscount))),
                    PKPaymentSummaryItem(label: "AMOUNT", amount: NSDecimalNumber(string: String(self.totalpay))),
            ]
            completion(paymentRequest, nil)
        }
        
    }
    
    @objc func tappedApplePay(){
        if(orderaddress.btnchckbox.currentImage == UIImage (named: "checkbox2")){
            let alert = UIAlertController(title: "", message: "Confirm your address details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.orderaddress.btnchckbox.setImage(UIImage (named: "checkbox1"), for: .normal)
            }))
            self.present(alert, animated: true)
        }else{
        self.setupPaymentRequest { (paymentRequest, error) in
            guard error == nil else {
                return
            }
            if let vc=PKPaymentAuthorizationViewController(paymentRequest: paymentRequest!) as PKPaymentAuthorizationViewController?
            {
                vc.delegate = self
                self.present(vc, animated: true, completion: nil)
            } else {
                print("Error: Payment request is invalid.")
            }
        }
        }
    }
    
    @available(iOS 11.0, *)
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void){
        
        // Example: Tokenize the Apple Pay payment
        let applePayClient = BTApplePayClient(apiClient: braintreeClient!)
        applePayClient.tokenizeApplePay(payment) {
            (tokenizedApplePayPayment, error) in
            guard let tokenizedApplePayPayment = tokenizedApplePayPayment else {
                
                //  completion(PKPaymentAuthorizationStatus.failure)
                if #available(iOS 11.0, *) {
                    let result = PKPaymentAuthorizationResult(status: .failure,
                                                              errors: [])
                    completion(result)
                } else {
                    // Fallback on earlier versions
                }
                
                print("failure......")
                return
            }
            print("nonce = \(tokenizedApplePayPayment.nonce)")
           
            //  print("billingPostalCode = \(payment.billingContact?.postalAddress?.postalCode)")
            print("billingPostalCode = \(payment.shippingContact?.postalAddress?.postalCode)")
            let result = PKPaymentAuthorizationResult(status: .success,
                                                      errors: [])
            
            // Then indicate success or failure via the completion callback, e.g.
            completion(result)
            print("success....")
        }
    }

    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
       

        //dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: gohome)
    }
    func gohome(){
        servicecreateorder()
//        UserDefaults.standard.removeObject(forKey: "cartbadge")
//        let home = self.storyboard?.instantiateViewController (withIdentifier: "HomeViewController") as! HomeViewController
//
//        self.navigationController?.pushViewController(home, animated: false)
    }
    
    
    
    
    @IBAction func btnbackaction(_ sender: Any) {
        performSegueToReturnBack()  
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int
    {
       return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section==0{
                if self.defaultshipping != ""{
                return shpngnamearray.count
                }else{
                    return 0
                }
            }else{
               return namearray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  indexPath.section==0{
           
           // if self.defaultshipping != ""{
                orderaddress = (tableView.dequeueReusableCell(withIdentifier: "OrderAddressTableViewCell", for: indexPath) as? OrderAddressTableViewCell)!
                orderaddress.Outerview.layer.cornerRadius = 5.0
            orderaddress.lblname.text=shpngnamearray[indexPath.row]
            orderaddress.lbladdress.text=shippingstreet  + ", " + shippingcity + ", " + shippingregion + ", " + shippingpostcode
            orderaddress.lblphnenum.text=shippingtelephone
            orderaddress.lblgmail.text=email
             orderaddress.btnchangaadres.addTarget(self, action: #selector(btnchngeadractn(sender:)), for: .touchUpInside)
             orderaddress.btnchckbox.addTarget(self, action: #selector(btnchckboxaction(sender:)), for: .touchUpInside)
           
            return orderaddress
//            }else{
//                return orderaddress
//            }
        }else{
           
                ordersummary = (tableView.dequeueReusableCell(withIdentifier: "OrdersummaryTableViewCell", for: indexPath) as? OrdersummaryTableViewCell)!
                
                ordersummary.Outerview.layer.cornerRadius = 5.0
               ordersummary.lblname.text=namearray[indexPath.row]
            ordersummary.lblqty.text="Qty: "+qtyarray[indexPath.row]
            let url = URL(string:imagearray[indexPath.row])
            ordersummary.imageviewproduct.kf.indicatorType = .activity
            ordersummary.imageviewproduct.kf.setImage(with: url)
            ordersummary.imageviewproduct.contentMode = .scaleToFill
            ordersummary.lblname.text=namearray[indexPath.row]
            //ordersummary.imageviewproduct.image=
                return ordersummary
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            if indexPath.section==0{
                if self.defaultshipping != ""{
                     return 245
                }else{
                    return 0
                }
               
            }else{
                 return 152
        }
        }
    @objc func btnchngeadractn(sender: UIButton){
        let newadrs=self.storyboard?.instantiateViewController (withIdentifier: "NewaddressViewController") as! NewaddressViewController
        
        self.navigationController?.pushViewController(newadrs, animated: false)
        
    }
    
    @objc func btnchckboxaction(sender:UIButton){
        if(orderaddress.btnchckbox.currentImage == UIImage (named: "checkbox2"))
        {
            self.orderaddress.btnchckbox.setImage(UIImage (named: "checkbox1"), for: .normal)
        }
        else{
            self.orderaddress.btnchckbox.setImage(UIImage (named: "checkbox2"), for: .normal)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


func servicecustomerinfobyemail(){
    self.showhud()
    var urlstring:String!
    email = UserDefaults.standard.value(forKey: "email") as? String
    print("email",email)
    urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/CustomerInfo/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"+email
    
    guard let url = URL(string: urlstring) else {
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        
        guard let data = data else {return}
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
            
            for item in json{
                let value : [String:Any] = item as! [String : Any]
                let customerinfo = value["CustomerInfo"] as! NSArray
        
                for value in customerinfo{
                    let customerdata = orderCustomerInfo(customerinfo: value as! [String : Any])
                    print("customerdata",customerdata)
                    self.customerlastname = customerdata.lastname
                    print("lastname",self.customerlastname)
                    self.customerfirstname = customerdata.firstname
                    let middlename = customerdata.middlename
                    let email = customerdata.email
                    self.defaultshipping=customerdata.default_shipping
                    self.defaultbilling=customerdata.default_billing
                  
                }
                if self.defaultshipping==""{
                    let alert = UIAlertController(title: "Alert", message: "Please Enter Your Shipping Address" , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                        
                        let addadrs = self.storyboard?.instantiateViewController (withIdentifier: "AddadressViewController") as! AddadressViewController
                        
                         addadrs.addressfag=1
                        self.navigationController?.pushViewController(addadrs, animated: false)
                        
                    }))
                    
                    self.present(alert, animated: true)
                }else{
                let shippinginfo = value["shippingAddress"] as! NSArray
                    print("shippinginfo",shippinginfo)
                for value1 in shippinginfo{
                    
                    let shippingdata = ordershippingAddress(shippinginfo: value1 as! [String : Any])
                    let lastname = shippingdata.lastname
                    print("lastname",lastname)
                    let firstname = shippingdata.firstname
                    let middlename = shippingdata.middlename
                    let company = shippingdata.company
                 
                    self.shippingregion=shippingdata.region
                    self.shippingstreet = shippingdata.street
                    self.shippingcity = shippingdata.city
                    self.shippingtelephone=shippingdata.telephone
                    self.shippingpostcode=shippingdata.postcode
                    self.shippingcountryid=shippingdata.country_id
                    print("shippingregion",self.shippingregion)
                     print("shippingstreet",self.shippingstreet)
                     print("shippingcity",self.shippingcity)
                     print("shippingtelephone",self.shippingtelephone)
                     print("shippingpostcode",self.shippingpostcode)
                     print("shippingcountryid",self.shippingcountryid)
//                    if firstname == "" || middlename == "" || self.shippingregion == "" || self.shippingstreet == "" || self.shippingcity == "" || self.shippingpostcode == ""{
//                        let alert = UIAlertController(title: "Alert", message: "Please enter your address" , preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
//
//                            let newadress = self.storyboard?.instantiateViewController (withIdentifier: "NewaddressViewController") as! NewaddressViewController
//                        self.navigationController?.pushViewController(newadress, animated: false)
//
//                        }))
//
//                        self.present(alert, animated: true)
//                    }else{
                self.shpngnamearray.append(firstname+""+middlename+""+lastname)
                    self.shpngstreetarray.append(self.shippingstreet)
                    self.shpngcompanyarray.append(company)
                    self.shpngcityarray.append(self.shippingcity)
                    self.shpngpostcodearray.append(self.shippingpostcode)
                    self.shpngtelephoneearray.append( self.shippingtelephone)
                    self.shpngregionarray.append(self.shippingregion)
                    //self.shpngidarray.append(id)
                    self.shpngfirstnamearray.append(firstname)
                    self.shpnglastnamearray.append(lastname)
                    self.shpngcountryidarray.append(self.shippingcountryid)
                    self.shpngmiddlenamearray.append(middlename)
                    //}
                  
                   
                }
                    print("shpngcountryidarray",self.shpngcountryidarray)
                    print("shpngfirstnamearray",self.shpngfirstnamearray)
                    print("shpngstreetarray",self.shpngstreetarray)
                    print("shpngpostcodearray",self.shpngpostcodearray)
                }
                 if self.defaultbilling==""{
                    let alert = UIAlertController(title: "Alert", message: "Please Enter Your Billing Address" , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                        
                        let addadrs = self.storyboard?.instantiateViewController (withIdentifier: "AddadressViewController") as! AddadressViewController
                        
                        addadrs.addressfag=0
                        self.navigationController?.pushViewController(addadrs, animated: false)
                        
                    }))
                    
                    self.present(alert, animated: true)
                 }else{
                 let billinginfo = value["billingAddress"] as! NSArray
                for value2 in billinginfo{
                    let billingdata = orderbillingAddress(billinginfo: value2 as! [String : Any])
                    let lastname = billingdata.lastname
                    print("lastname",lastname)
                    let firstname = billingdata.firstname
                    let middlename = billingdata.middlename
                    let company = billingdata.company
                    self.billingstreet = billingdata.street
                    self.billingcity = billingdata.city
                    self.billingtelephone = billingdata.telephone
                    self.billingpostcode=billingdata.postcode
                    self.billingregion=billingdata.region
                    self.billingcountryid=billingdata.country_id
                    print("billingstreet",self.billingstreet)
                    print("billingcity",self.billingcity)
                    print("billingtelephone",self.billingtelephone)
                    print("billingpostcode",self.billingpostcode)
                    print("billingregion",self.billingregion)
                    print("billingcountryid",self.billingcountryid)
//                    if firstname == "" || middlename == "" || self.billingregion == "" || self.billingstreet == "" || self.billingcity == "" || self.billingpostcode == ""{
//                        let alert = UIAlertController(title: "Alert", message: "Please enter your address" , preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
//
//                            let newadress = self.storyboard?.instantiateViewController (withIdentifier: "NewaddressViewController") as! NewaddressViewController
//                            self.navigationController?.pushViewController(newadress, animated: false)
//
//                        }))
//
//                        self.present(alert, animated: true)
//                    }else{
                    self.billingnamearray.append(firstname+" "+middlename+" "+lastname)
                    self.billingstreetarray.append(self.billingstreet)
                    self.billingmiddlenamearray.append(middlename)
                    print("billingstreetarray",self.billingstreetarray)
                    print("billingstreetarray.count",self.billingstreetarray.count)
                    self.billingcompanyarray.append(company)
                    self.billingcityarray.append(self.billingcity)
                    self.billingpostcodearray.append(self.billingpostcode)
                    self.billingregionarray.append(self.billingregion)
                    self.billingphonearray.append( self.billingtelephone)
                    //self.billingidarray.append(id)
                    self.billingfirstnamearray.append(firstname)
                    self.billinglastnamearray.append(lastname)
                    self.billingcountryidarray.append(self.billingcountryid)

                   // }
                    }
                }
                
                
                DispatchQueue.main.async {
                    self.hud.hide(animated: true)
                    self.tableviewordersummary.reloadData()
                }
            }
            
        }
        
        catch{
            print("Error in parsing")
        }
        
        }.resume()
    
    //servicecreateorder()
}
    func servicecreateorder(){
        
        
        email = UserDefaults.standard.value(forKey: "email") as? String
        password=UserDefaults.standard.value(forKey: "password") as? String
        print("email",email)
        print("password",password)
        let parameters : [String: Any] = ["email": email,"password": password,"firstname": customerfirstname,"lastname": customerlastname,"token":"33urorbe0o4fqu8jwpu25jbtowi8p5uc","currencyid": "GBP","products":newarray,"billingregion":billingregion,"billingcity": billingcity,"billingstreet": billingstreet,"billingpostcode": billingpostcode,"billingcountryid":billingcountryid,"billingtelephone": billingtelephone,"shippingregion": shippingregion,"shippingcity": shippingcity,"shippingstreet": shippingstreet,"shippingpostcode": shippingpostcode,"shippingcountryid": shippingcountryid,"shippingtelephone": shippingtelephone,"shippingmethod": "flatrate_flatrate","paymentmethod": "cashondelivery"]
        print("parameters",parameters)
        
        guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/createcustomeOrder")else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
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
                    let jsonsignup = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                    
                    print("jsonsignup",jsonsignup)
                    
                    if (jsonsignup.value(forKey: "status") != nil) {
                        let status = jsonsignup.value(forKey: "status") as! String
                        print("test",status as Any)
                        let message=jsonsignup.value(forKey: "message") as! String
                        if status=="TRUE"{
                            let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                                UserDefaults.standard.removeObject(forKey: "skuvalue")
                                UserDefaults.standard.removeObject(forKey: "cartbadge")
                                UserDefaults.standard.removeObject(forKey: "cartprice")
                                UserDefaults.standard.removeObject(forKey:  "cartimage")
                                UserDefaults.standard.removeObject(forKey: "cartqty")
                                UserDefaults.standard.removeObject(forKey: "totalprice")
                                UserDefaults.standard.removeObject(forKey: "newprice")
                                UserDefaults.standard.removeObject(forKey: "totalquantity")
                                let home = self.storyboard?.instantiateViewController (withIdentifier: "HomeViewController") as! HomeViewController
                                self.navigationController?.pushViewController(home, animated: false)
                                
                            }))
                            
                            self.present(alert, animated: true)
                        }else{
                            let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                            self.present(alert, animated: true)
                        }
                        
                    }else{
                        let message=jsonsignup.value(forKey: "message") as! String
                        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        
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
    
   
    @IBAction func payaction(_ sender: Any) {
            let checkout = self.storyboard?.instantiateViewController (withIdentifier: "CheckoutViewController") as! CheckoutViewController
        
              self.navigationController?.pushViewController(checkout, animated: false)
        
        
        }
    
    
}

extension OrdersummaryViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: false, completion: nil)
           
        }
    }
}
