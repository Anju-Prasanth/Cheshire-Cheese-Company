//
//  AddadressViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 24/06/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import iOSDropDown

class AddadressViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    var addressfag=Int()
    var email:String!
    var addadrs=AddnewadrsTableViewCell()
    var stateid=String()
    var countrynamearray=[String]()
    var countryidarray=[String]()
    var statenamearray=[String]()
    var nameindex=String()
    var statename=String()
    var state=String()

    @IBOutlet weak var tableviewaddnewadrs: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        tableviewaddnewadrs.register(UINib(nibName: "AddnewadrsTableViewCell", bundle: nil), forCellReuseIdentifier: "AddnewadrsTableViewCell")
         self.hideKeyboardWhenTappedAround()
        servicecountrylist()
        
        if (UserDefaults.standard.value(forKey: "countryid") as? String) != nil{
            stateid=(UserDefaults.standard.value(forKey: "countryid") as? String)!
            servicestatelist()
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
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         addadrs = (tableView.dequeueReusableCell(withIdentifier: "AddnewadrsTableViewCell", for: indexPath) as? AddnewadrsTableViewCell)!
        if addressfag==0{
            addadrs.lblcontactinfrmtn.text="ADD BILLING ADDRESS"
        }else{
             addadrs.lblcontactinfrmtn.text="ADD SHIPPING ADDRESS"
        }
        
        addadrs.txtfldcountry.delegate=self
        addadrs.txtfldstate.delegate=self
        addadrs.txtfldcountry.optionArray=countrynamearray
        
        // The the Closure returns Selected Index and String
        
        addadrs.txtfldcountry.didSelect{(selectedText , index ,id) in
            let country = "Selected String: \(selectedText) \n index: \(index)"
            print("country",country)
            self.nameindex=self.countrynamearray[index]
            print("nameindex:",self.countrynamearray[index])
            UserDefaults.standard.set(self.nameindex, forKey: "countryname")
            
            self.stateid=self.countryidarray[index]
            UserDefaults.standard.set(self.stateid, forKey: "countryid")
            print("idindex",self.countryidarray[index])
            self.servicestatelist()
            
        }
        print(statenamearray.count)
        if statenamearray.count != 0{
            addadrs.txtfldstate.optionArray=statenamearray
            // newadrs.txtfldstate.isUserInteractionEnabled=false
        }else{
            addadrs.txtfldstate.optionArray=[""]
            //newadrs.txtfldstate.isUserInteractionEnabled=true
        }
        
        
        addadrs.txtfldstate.didSelect{(selectedText , index ,id) in
            let country = "Selected String: \(selectedText) \n index: \(index)"
            print("country",country)
            
            // if self.statenamearray[0] != "0"{
            self.state=self.statenamearray[index]
            //self.statecodevalue=self.statecodearray[index]
            //}
            
        }
        
    
        
        let color = UIColor(red: 226 / 255, green: 226 / 255, blue: 226 / 255, alpha: 1.0)
        let txtfldcolor = UIColor(red: 161 / 255, green: 161 / 255, blue: 161 / 255, alpha: 1.0)
        
        addadrs.txtfldfirstname.borderStyle=UITextBorderStyle.roundedRect
        addadrs.txtfldlastname.borderStyle=UITextBorderStyle.roundedRect
        addadrs.txtfldcountry.borderStyle=UITextBorderStyle.roundedRect
        addadrs.txtfldpostalcode.borderStyle=UITextBorderStyle.roundedRect
        addadrs.txtfldphonenumbr.borderStyle=UITextBorderStyle.roundedRect
        
       addadrs.txtfldstreetyadrs.borderStyle=UITextBorderStyle.roundedRect
        addadrs.txtfldcity.borderStyle=UITextBorderStyle.roundedRect
        addadrs.txtfldstate.borderStyle=UITextBorderStyle.roundedRect
        addadrs.txtfldmiddlename.borderStyle=UITextBorderStyle.roundedRect
        
        
        addadrs.txtfldfirstname.layer.borderColor = txtfldcolor.cgColor
        addadrs.txtfldlastname.layer.borderColor = txtfldcolor.cgColor
        addadrs.txtfldcountry.layer.borderColor = txtfldcolor.cgColor
        addadrs.txtfldpostalcode.layer.borderColor = txtfldcolor.cgColor
        addadrs.txtfldphonenumbr.layer.borderColor = txtfldcolor.cgColor
        
        addadrs.txtfldstreetyadrs.layer.borderColor = txtfldcolor.cgColor
        addadrs.txtfldcity.layer.borderColor = txtfldcolor.cgColor
        addadrs.txtfldstate.layer.borderColor = txtfldcolor.cgColor
        addadrs.txtfldmiddlename.layer.borderColor = txtfldcolor.cgColor
        
        addadrs.txtfldfirstname.layer.borderWidth = 1
        addadrs.txtfldfirstname.layer.cornerRadius = 5
        addadrs.txtfldlastname.layer.borderWidth = 1
        addadrs.txtfldlastname.layer.cornerRadius = 5
        addadrs.txtfldcountry.layer.borderWidth = 1
        addadrs.txtfldcountry.layer.cornerRadius = 5
        addadrs.txtfldpostalcode.layer.borderWidth = 1
        addadrs.txtfldpostalcode.layer.cornerRadius = 5
        addadrs.txtfldphonenumbr.layer.borderWidth = 1
        addadrs.txtfldphonenumbr.layer.cornerRadius = 5
        
        
        addadrs.txtfldstreetyadrs.layer.borderWidth = 1
        addadrs.txtfldstreetyadrs.layer.cornerRadius = 5
        addadrs.txtfldcity.layer.borderWidth = 1
        addadrs.txtfldcity.layer.cornerRadius = 5
        addadrs.txtfldstate.layer.borderWidth = 1
        addadrs.txtfldstate.layer.cornerRadius = 5
        addadrs.txtfldmiddlename.layer.borderWidth = 1
        addadrs.txtfldmiddlename.layer.cornerRadius = 5
        
        addadrs.Outerview.layer.borderWidth = 2
        addadrs.Outerview.layer.borderColor = color.cgColor
        addadrs.Outerview.layer.cornerRadius = 5
        
        
        addadrs.txtfldmiddlename.textColor = UIColor.black
        addadrs.txtfldfirstname.textColor = UIColor.black
        addadrs.txtfldlastname.textColor = UIColor.black
        addadrs.txtfldcountry.textColor = UIColor.black
        addadrs.txtfldpostalcode.textColor = UIColor.black
        addadrs.txtfldphonenumbr.textColor = UIColor.black
        //newadrs.txtfldadrs1.textColor = UIColor.black
        addadrs.txtfldstreetyadrs.textColor = UIColor.black
        addadrs.txtfldcity.textColor = UIColor.black
        addadrs.txtfldstate.textColor = UIColor.black
        addadrs.btnsaveadrs.layer.cornerRadius = 5
        
        addadrs.btnsaveadrs.addTarget(self, action: #selector(btnsaveadrsaction(sender:)), for: .touchUpInside)
        
        return addadrs
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 701
    }
    
    @objc func btnsaveadrsaction(sender:UIButton){
        if addadrs.txtfldpostalcode.text == "" {
            let alert = UIAlertController(title: "Incomplete field", message: "Please enter postal code.", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }else if (addadrs.txtfldfirstname.text == " "||addadrs.txtfldlastname.text == ""){
            let alert = UIAlertController(title: "Incomplete field", message: "Please fill the name fields", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }else if (addadrs.txtfldstreetyadrs.text == " "||addadrs.txtfldcountry.text == ""||addadrs.txtfldcity.text == ""||addadrs.txtfldstate.text == ""||addadrs.txtfldcountry.text==""){
            
            let alert = UIAlertController(title: "Incomplete field", message: "Please complete the fields", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
            
        } else if addressfag==0{
            serviceaddbillingadrs()
        }else{
        serviceaddshippingadrs()
        }
    }


    func serviceaddshippingadrs(){
        var params=[String:AnyObject]()
        email = UserDefaults.standard.value(forKey: "email") as? String
        self.state=self.addadrs.txtfldstate.text!
        params = ["token": "33urorbe0o4fqu8jwpu25jbtowi8p5uc" as AnyObject,
                  "email": email as AnyObject,
                  "firstname": addadrs.txtfldfirstname.text as AnyObject,
                  "lastname": addadrs.txtfldlastname.text as AnyObject,
                  "shippingstreet": addadrs.txtfldstreetyadrs.text as AnyObject,
                  "shippingcity": addadrs.txtfldcity.text as AnyObject,
                  "shippingpostcode": addadrs.txtfldpostalcode.text as AnyObject,
                  "shippingregion": self.state as AnyObject,
                  "shippingcountryid": self.stateid as AnyObject,
                  "shippingtelephone": addadrs.txtfldphonenumbr.text as AnyObject]
        
        
        guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/Shipaddressadd")else{return}
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
                        if status=="FALSE"{
                            let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                                
                                let myaccount = self.storyboard?.instantiateViewController (withIdentifier: "MyAccountViewController") as! MyAccountViewController
                                self.navigationController?.pushViewController(myaccount, animated: false)
                                
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
    
    
    
    func serviceaddbillingadrs(){
        var params=[String:AnyObject]()
        email = UserDefaults.standard.value(forKey: "email") as? String
         self.state=self.addadrs.txtfldstate.text!
        params = ["token": "33urorbe0o4fqu8jwpu25jbtowi8p5uc" as AnyObject,
                  "email": email as AnyObject,
                  "firstname": addadrs.txtfldfirstname.text as AnyObject,
                  "lastname": addadrs.txtfldlastname.text as AnyObject,
                  "billingstreet": addadrs.txtfldstreetyadrs.text as AnyObject,
                  "billingcity": addadrs.txtfldcity.text as AnyObject,
                  "billingpostcode": addadrs.txtfldpostalcode.text as AnyObject,
                  "billingregion": self.state as AnyObject,
                  "billingcountryid": self.stateid as AnyObject,
                  "billingtelephone": addadrs.txtfldphonenumbr.text as AnyObject]
        
        
        guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/Billingaddressadd")else{return}
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
                        if status=="FALSE"{
                            let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                                
                                let myaccount = self.storyboard?.instantiateViewController (withIdentifier: "MyAccountViewController") as! MyAccountViewController
                                self.navigationController?.pushViewController(myaccount, animated: false)
                                
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
    
    
    
    
    
    
    
    
    
    
    
    
    func servicecountrylist(){
        //  self.showhud()
        var urlstring:String!
        
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/directory/countries"
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
                    let countryname = value["full_name_english"] as! String
                    let id = value["id"] as! String
                    print("countryname",countryname)
                    self.countrynamearray.append(countryname)
                    self.countryidarray.append(id)
                }
                DispatchQueue.main.async {
                    //self.hud.hide(animated: true)
                    self.tableviewaddnewadrs.reloadData()
                }
            }
                
            catch{
                print("Error in parsing")
            }
            
            }.resume()
        
        
    }
    func servicestatelist(){
        //  self.showhud()
        var urlstring:String!
        
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/directory/countries/"+stateid
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                print("json",json)
                self.statenamearray.removeAll()
                if(json!.value(forKey: "available_regions")) != nil{
                    let availableregion = json!.value(forKey: "available_regions") as! NSArray
                    print("availableregion",availableregion)
                    for item in availableregion{
                        let value : [String:Any] = item as! [String : Any]
                        let name = value["name"]as! String
                        let code = value["code"]as! String
                        print("name",name)
                        self.statenamearray.append(name)
                       // self.statecodearray.append(code)
                        
                    }
                    }
                    else{
                    self.statenamearray.append("")
                    
                }
                DispatchQueue.main.async {
                    //self.hud.hide(animated: true)
                    self.tableviewaddnewadrs.reloadData()
                }
                
            }
                
            catch{
                print("Error in parsing")
            }
            
            }.resume()
        
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        if textField==addadrs.txtfldcountry{
            return false
        }else if textField==addadrs.txtfldstate{
            if statenamearray[0]==""{
                return true
            }else{
                return false
            }
        }else{
            return true
        }
    }
    
    
    
}
