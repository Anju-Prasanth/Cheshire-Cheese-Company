//
//  ProfileupdateViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 28/05/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import MBProgressHUD

struct Customeraddress{
    let email : String
    let firstname : String
    let middlename : String
    let lastname : String
    let dob : String
    let taxvat : String
    init(customerinfo :[String:Any]) {
        email = customerinfo["email"] as? String ?? ""
        firstname = customerinfo["firstname"] as? String ?? ""
        middlename = customerinfo["middlename"] as? String ?? ""
        lastname = customerinfo["lastname"] as? String ?? ""
        dob = customerinfo["dob"] as? String ?? ""
        taxvat = customerinfo["taxvat"] as? String ?? ""
    }
}


class ProfileupdateViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableviewupdateprofile: UITableView!
    var updateprofile=profileupdateTableViewCell()
    var email:String!
    var firstnamearray=[String]()
     var lastnamearray=[String]()
     var middlenamearray=[String]()
     var emailarray=[String]()
     var dobarray=[String]()
     var taxvatarray=[String]()
     var hud:MBProgressHUD=MBProgressHUD()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        tableviewupdateprofile.register(UINib(nibName: "profileupdateTableViewCell", bundle: nil), forCellReuseIdentifier: "profileupdateTableViewCell")
         self.hideKeyboardWhenTappedAround()
        servicecustomerinfobyemail()
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
        return firstnamearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        updateprofile = (tableView.dequeueReusableCell(withIdentifier: "profileupdateTableViewCell", for: indexPath) as? profileupdateTableViewCell)!
        let color = UIColor(red: 226 / 255, green: 226 / 255, blue: 226 / 255, alpha: 1.0)
        let txtfldcolor = UIColor(red: 161 / 255, green: 161 / 255, blue: 161 / 255, alpha: 1.0)
        
        updateprofile.txtfldfirstname.borderStyle=UITextBorderStyle.roundedRect
        updateprofile.txtfldlastname.borderStyle=UITextBorderStyle.roundedRect
        updateprofile.txtfldmiddlename.borderStyle=UITextBorderStyle.roundedRect
        updateprofile.txtflddob.borderStyle=UITextBorderStyle.roundedRect
        updateprofile.txtfldemail.borderStyle=UITextBorderStyle.roundedRect
        updateprofile.txtfldtaxvat
            .borderStyle=UITextBorderStyle.roundedRect
       // updateprofile.txtfldupdateemail
            //.borderStyle=UITextBorderStyle.roundedRect
        
       updateprofile.txtfldfirstname.layer.borderColor = txtfldcolor.cgColor
        updateprofile.txtfldlastname.layer.borderColor = txtfldcolor.cgColor
       updateprofile.txtfldmiddlename.layer.borderColor = txtfldcolor.cgColor
        updateprofile.txtflddob.layer.borderColor = txtfldcolor.cgColor
        updateprofile.txtfldemail.layer.borderColor = txtfldcolor.cgColor
        updateprofile.txtfldtaxvat.layer.borderColor = txtfldcolor.cgColor
        //updateprofile.txtfldupdateemail.layer.borderColor = txtfldcolor.cgColor
        
        
        updateprofile.txtfldfirstname.layer.borderWidth = 1
        updateprofile.txtfldfirstname.layer.cornerRadius = 5
        updateprofile.txtfldlastname.layer.borderWidth = 1
        updateprofile.txtfldlastname.layer.cornerRadius = 5
        updateprofile.txtfldmiddlename.layer.borderWidth = 1
        updateprofile.txtfldmiddlename.layer.cornerRadius = 5
        updateprofile.txtfldemail.layer.borderWidth = 1
        updateprofile.txtfldemail.layer.cornerRadius = 5
        updateprofile.txtflddob.layer.borderWidth = 1
        updateprofile.txtflddob.layer.cornerRadius = 5
        updateprofile.txtfldtaxvat.layer.borderWidth = 1
        updateprofile.txtfldtaxvat.layer.cornerRadius = 5
       // updateprofile.txtfldupdateemail.layer.borderWidth = 1
       // updateprofile.txtfldupdateemail.layer.cornerRadius = 5
       
        
        updateprofile.Outerview.layer.borderWidth = 2
        updateprofile.Outerview.layer.borderColor = color.cgColor
        updateprofile.Outerview.layer.cornerRadius = 5
        
        updateprofile.txtfldfirstname.textColor = UIColor.black
        updateprofile.txtfldlastname.textColor = UIColor.black
        updateprofile.txtfldmiddlename.textColor = UIColor.black
        updateprofile.txtfldemail.textColor = UIColor.black
        updateprofile.txtflddob.textColor = UIColor.black
        updateprofile.txtfldtaxvat.textColor = UIColor.black
        //updateprofile.txtfldupdateemail.textColor = UIColor.black
        
        updateprofile.btnupdate.layer.cornerRadius = 5
        
        
        updateprofile.txtfldfirstname.text=firstnamearray[indexPath.row]
        updateprofile.txtfldlastname.text=lastnamearray[indexPath.row]
        updateprofile.txtfldmiddlename.text=middlenamearray[indexPath.row]
        updateprofile.txtfldemail.text=emailarray[indexPath.row]
        updateprofile.txtflddob.text=dobarray[indexPath.row]
        updateprofile.txtfldtaxvat.text=taxvatarray[indexPath.row]
        
        updateprofile.btnupdate.addTarget(self, action: #selector(btnupdateaction(sender:)), for: .touchUpInside)
        
        
        return updateprofile
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 449
    }

    @objc func btnupdateaction(sender: UIButton){
        if (updateprofile.txtfldemail.text == ""){
            
            let alert = UIAlertController(title: "Incomplete field", message: "Please enter a valid email id", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }else if !isValidEmail(testStr: updateprofile.txtfldemail.text!){
            
            let alert = UIAlertController(title: "Invalid email id", message: "Please enter your correct email id.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }else{
         serviceupdateprofile()
    }
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func serviceupdateprofile(){
        var params=[String:AnyObject]()
        let fullname=updateprofile.txtfldfirstname.text! + " " + updateprofile.txtfldmiddlename.text! + " " + updateprofile.txtfldlastname.text!
        email = UserDefaults.standard.value(forKey: "email") as? String
        params = ["token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc" as AnyObject,"fname" :updateprofile.txtfldfirstname.text as AnyObject,"mname" :updateprofile.txtfldmiddlename.text as AnyObject,"lname" :updateprofile.txtfldlastname.text as AnyObject,"DOB" :updateprofile.txtflddob.text as AnyObject,"email" :email as AnyObject,"update_email" :updateprofile.txtfldemail
            .text as AnyObject,"taxvat" :updateprofile.txtfldtaxvat.text as AnyObject]
        print("params",params)
        
        guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/updateprofile/")else{return}
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
                    let message=jsonsignup.value(forKey: "message") as! String
                    let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                        UserDefaults.standard.set(self.updateprofile.txtfldemail.text, forKey: "email")
                        UserDefaults.standard.set(fullname, forKey: "fullname")
                       
                        let home = self.storyboard?.instantiateViewController (withIdentifier: "HomeViewController") as! HomeViewController
                        self.navigationController?.pushViewController(home, animated: false)
                        
                    }))
                    self.present(alert, animated: true)
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
                
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let customerinfo = value["CustomerInfo"] as! NSArray
//                    let shippinginfo = value["shippingAddress"] as! NSArray
//                    let billinginfo = value["billingAddress"] as! NSArray
                    for value in customerinfo{
                        let customerdata = Customeraddress(customerinfo: value as! [String : Any])
                        print("customerdata",customerdata)
                        let lastname = customerdata.lastname
                        print("lastname",lastname)
                        let firstname = customerdata.firstname
                        let middlename = customerdata.middlename
                        let email = customerdata.email
                        let dob=customerdata.dob
                        let taxvat=customerdata.taxvat
                        //self.namearray.append(firstname + " " + lastname + " " + middlename)
                        //print("namearray",self.namearray)
                        self.emailarray.append(email)
                        self.firstnamearray.append(firstname)
                         self.lastnamearray.append(lastname)
                         self.middlenamearray.append(middlename)
                         self.dobarray.append(dob)
                        self.taxvatarray.append(taxvat)
                        
                    }
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.tableviewupdateprofile.reloadData()
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
