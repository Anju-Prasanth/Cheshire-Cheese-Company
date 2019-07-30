//
//  SigninViewController.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 14/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher

struct Logindata {
    let website_id : String
    let entity_id : String
    let firstname : String
    let email : String
    let middlename : String
    let lastname : String
    let default_billing : String
    let default_shipping : String
    
    //let alttext: String
    init(customerdata :[String:Any]) {
        website_id = customerdata["website_id"] as? String ?? ""
        entity_id = customerdata["entity_id"] as? String ?? ""
        firstname = customerdata["firstname"] as? String ?? ""
        email = customerdata["email"] as? String ?? ""
        middlename = customerdata["middlename"] as? String ?? ""
        lastname = customerdata["lastname"] as? String ?? ""
        default_billing = customerdata["default_billing"] as? String ?? ""
        default_shipping = customerdata["default_shipping"] as? String ?? ""
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


class SigninViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableviewsignin: UITableView!
    var cell=SigninTableViewCell()
    var testdict:[String:AnyObject]!
    var loginflag:Int!
    var firstname:String!
    var email:String!
    var fullname:String!
    var checkoutflag=Int()
    var entityid=String()
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let backlogoimage=UIImage (named: "back")
//        let btnback = UIBarButtonItem (image: backlogoimage, style: .plain, target: self, action: #selector(SigninViewController.backaction))
//        navigationItem.setLeftBarButton(btnback, animated: true)
//        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
         tableviewsignin.register(UINib(nibName: "SigninTableViewCell", bundle: nil), forCellReuseIdentifier: "SigninTableViewCell")
        self.hideKeyboardWhenTappedAround()
       // entityid=UserDefaults.standard.value(forKey: "entityid") as! String
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
        return 1
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = (tableView.dequeueReusableCell(withIdentifier: "SigninTableViewCell", for: indexPath) as? SigninTableViewCell)!
        cell.Outerview.layer.borderWidth = 2
         let color = UIColor(red: 226 / 255, green: 226 / 255, blue: 226 / 255, alpha: 1.0)
        cell.Outerview.layer.borderColor = color.cgColor
        cell.Outerview.layer.cornerRadius = 5
        cell.Outerview.layer.borderWidth = 2
        cell.viewcreateaccount.layer.borderColor = color.cgColor
        cell.viewcreateaccount.layer.cornerRadius = 1
        cell.viewcreateaccount.layer.borderWidth = 2
        cell.btnlogin.layer.cornerRadius = 5
      cell.btnchckcreateacount.addTarget(self, action: #selector(btnchckcreateacount(sender:)), for: .touchUpInside)
        cell.btnlogin.addTarget(self, action: #selector(btnlogin(sender:)), for: .touchUpInside)
        cell.btnforgotpassword.addTarget(self, action: #selector(btnforgotpasswordaction(sender:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 374
    }
    @objc func btnchckcreateacount(sender:UIButton){

        let signup = self.storyboard?.instantiateViewController (withIdentifier: "SignupViewController") as! SignupViewController
        //header.removeFromSuperview()
         self.navigationController?.pushViewController(signup, animated: true)
    }
    @objc func btnlogin(sender:UIButton){
        serviceuserlogin()
        
//      let myaccount = self.storyboard?.instantiateViewController (withIdentifier: "MyAccountViewController") as! MyAccountViewController
//
//       self.navigationController?.pushViewController(myaccount, animated: true)
    }
    
    @objc func btnforgotpasswordaction(sender:UIButton){
        let forgotpassword = self.storyboard?.instantiateViewController (withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        //header.removeFromSuperview()
        self.navigationController?.pushViewController(forgotpassword, animated: true)
    }
    
    @objc func backaction(sender:UIButton){
        
      navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func  serviceresetpassword(){
        var params=[String:AnyObject]()
        
        params = ["email" : cell.txtemail.text as AnyObject,"template" : "email_reset" as AnyObject,"websiteId" : 1 as AnyObject]
        
        
        
        guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/customers/password")else{return}
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
                                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                            
                                            self.present(alert, animated: true)
                                        }else{
                                            let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                                            self.present(alert, animated: true)
                                        }
                                        
                                    }
                                }
                                
                                }
                                
                             catch let error as NSError {
                                print(error)
                            }
                        }
                        
                        
                    }
                }
            }
            
            .resume()
        }
    


    func serviceuserlogin(){
    //"email" :"testapi@gamil.com","password" : "test@123","token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc"
        let parameters:[String:Any] = ["email" :cell.txtemail.text as Any,"password" : cell.txtpassword.text as Any,"token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc"]
        guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/hello/customersAuthentication")else{return}
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
        for item in json{
            let value : [String:Any] = item as! [String : Any]
            let logindata = value["CustomerData"]
            print("logindata",logindata as Any)
            let customerdata = Logindata(customerdata: logindata as! [String : Any])
            print("customerdata",customerdata)
            let identity = customerdata.entity_id
            UserDefaults.standard.set(identity, forKey: "entityid")
            self.entityid=UserDefaults.standard.value(forKey: "entityid") as! String
            print("entityid",identity)
            let firstname = customerdata.firstname
            let middlename=customerdata.middlename
            let lastname=customerdata.lastname
            let defaultshipping=customerdata.default_shipping
            let defaultbilling=customerdata.default_billing
            var email = customerdata.email
              print("firstname",firstname)
//            UserDefaults.standard.set(firstname, forKey: "name")
//            UserDefaults.standard.set(email, forKey: "email")
            let fullname=firstname + " " + middlename + " " + lastname
            UserDefaults.standard.set(fullname, forKey: "fullname")
            UserDefaults.standard.set(firstname, forKey: "name")
            UserDefaults.standard.set(email, forKey: "email")
            email = (UserDefaults.standard.value(forKey: "email") as? String)!
            print("email",email)
             print("fullname",fullname)
            let testname=UserDefaults.standard.value(forKey: "name")
            print("testname:",testname as Any)
            print("firstname",firstname)
            
        }
        let alert = UIAlertController(title: "", message: "Logged in successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            UserDefaults.standard.set(self.cell.txtpassword.text, forKey: "password")
            if self.checkoutflag==1{
                let mybag = self.storyboard?.instantiateViewController (withIdentifier: "MyBagViewController") as! MyBagViewController
                self.navigationController?.pushViewController(mybag, animated: false)
                
            }else{
            let home = self.storyboard?.instantiateViewController (withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(home, animated: false)
            }
            
        }))
        self.present(alert, animated: true)
    } catch {
        let alert = UIAlertController(title: "Alert", message: "Invalid login details ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
           print("Invalidlogin")
        }))
        self.present(alert, animated: true)
    print(error)
        
    }
    }
    }.resume()

}
}
