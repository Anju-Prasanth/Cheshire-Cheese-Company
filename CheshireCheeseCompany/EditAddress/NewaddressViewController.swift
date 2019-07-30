//
//  NewaddressViewController.swift
//  
//
//  Created by apple on 23/05/19.
//

import UIKit
import iOSDropDown



class NewaddressViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextDropDelegate {
   

    @IBOutlet weak var tableviewnewaddress: UITableView!
    var newadrs=UpdateadrsTableViewCell()
    
    var adressid=String()
    var postalcode=String()
    var city=String()
    var phonenum=String()
    var street=String()
    var region=String()
    var countryid=String()
    var firstname=String()
    var lastname=String()
    var middlename=String()
    var shippingflag=Int()
    var countrynamearray=[String]()
    var countryidarray=[String]()
    var statenamearray=[String]()
    var id=String()
    var dropdown:DropDown!
    var valuelabel=UILabel()
    var stateid=String()
    var nameindex=String()
    var statename=String()
    var state=String()
    var addressfag=Int()
    var statecodearray=[String]()
    var statecodevalue=String()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
   tableviewnewaddress.register(UINib(nibName: "UpdateadrsTableViewCell", bundle: nil), forCellReuseIdentifier: "UpdateadrsTableViewCell")
         self.hideKeyboardWhenTappedAround()
        servicecountrylist()
        dropdown = DropDown(frame: CGRect(x: 10, y: 140, width: 200, height: 200))
        
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
    
        newadrs = (tableView.dequeueReusableCell(withIdentifier: "UpdateadrsTableViewCell", for: indexPath) as? UpdateadrsTableViewCell)!
        
         let color = UIColor(red: 226 / 255, green: 226 / 255, blue: 226 / 255, alpha: 1.0)
        let txtfldcolor = UIColor(red: 161 / 255, green: 161 / 255, blue: 161 / 255, alpha: 1.0)
         newadrs.txtfldcountry.delegate=self
         newadrs.txtfldstate.delegate=self
         newadrs.txtfldcountry.optionArray=countrynamearray
        
        // The the Closure returns Selected Index and String
        
        newadrs.txtfldcountry.didSelect{(selectedText , index ,id) in
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
        //self.newadrs.txtfldstate.placeholder="Select"
        print(statenamearray.count)
        if statenamearray.count != 0{
        newadrs.txtfldstate.optionArray=statenamearray
            // newadrs.txtfldstate.isUserInteractionEnabled=false
        }else{
            newadrs.txtfldstate.optionArray=[""]
         //newadrs.txtfldstate.isUserInteractionEnabled=true
        }
        
        
        newadrs.txtfldstate.didSelect{(selectedText , index ,id) in
            let country = "Selected String: \(selectedText) \n index: \(index)"
            print("country",country)
           
           // if self.statenamearray[0] != "0"{
                self.state=self.statenamearray[index]
                self.statecodevalue=self.statecodearray[index]
            //}

        }
        
        newadrs.txtfldfirstname.borderStyle=UITextBorderStyle.roundedRect
        newadrs.txtfldlastname.borderStyle=UITextBorderStyle.roundedRect
        newadrs.txtfldcountry.borderStyle=UITextBorderStyle.roundedRect
        newadrs.txtfldpostalcode.borderStyle=UITextBorderStyle.roundedRect
        newadrs.txtfldphonenumbr.borderStyle=UITextBorderStyle.roundedRect
       
        newadrs.txtfldstreetyadrs.borderStyle=UITextBorderStyle.roundedRect
        newadrs.txtfldcity.borderStyle=UITextBorderStyle.roundedRect
        newadrs.txtfldstate.borderStyle=UITextBorderStyle.roundedRect
        newadrs.txtfldmiddlename.borderStyle=UITextBorderStyle.roundedRect
       
        
        newadrs.txtfldfirstname.layer.borderColor = txtfldcolor.cgColor
        newadrs.txtfldlastname.layer.borderColor = txtfldcolor.cgColor
        newadrs.txtfldcountry.layer.borderColor = txtfldcolor.cgColor
        newadrs.txtfldpostalcode.layer.borderColor = txtfldcolor.cgColor
        newadrs.txtfldphonenumbr.layer.borderColor = txtfldcolor.cgColor
      
        newadrs.txtfldstreetyadrs.layer.borderColor = txtfldcolor.cgColor
        newadrs.txtfldcity.layer.borderColor = txtfldcolor.cgColor
        newadrs.txtfldstate.layer.borderColor = txtfldcolor.cgColor
        newadrs.txtfldmiddlename.layer.borderColor = txtfldcolor.cgColor
        
         newadrs.txtfldfirstname.layer.borderWidth = 1
        newadrs.txtfldfirstname.layer.cornerRadius = 5
        newadrs.txtfldlastname.layer.borderWidth = 1
        newadrs.txtfldlastname.layer.cornerRadius = 5
        newadrs.txtfldcountry.layer.borderWidth = 1
        newadrs.txtfldcountry.layer.cornerRadius = 5
        newadrs.txtfldpostalcode.layer.borderWidth = 1
        newadrs.txtfldpostalcode.layer.cornerRadius = 5
        newadrs.txtfldphonenumbr.layer.borderWidth = 1
        newadrs.txtfldphonenumbr.layer.cornerRadius = 5
        
     
        newadrs.txtfldstreetyadrs.layer.borderWidth = 1
        newadrs.txtfldstreetyadrs.layer.cornerRadius = 5
        newadrs.txtfldcity.layer.borderWidth = 1
        newadrs.txtfldcity.layer.cornerRadius = 5
        newadrs.txtfldstate.layer.borderWidth = 1
        newadrs.txtfldstate.layer.cornerRadius = 5
        newadrs.txtfldmiddlename.layer.borderWidth = 1
        newadrs.txtfldmiddlename.layer.cornerRadius = 5
        
        newadrs.Outerview.layer.borderWidth = 2
        newadrs.Outerview.layer.borderColor = color.cgColor
        newadrs.Outerview.layer.cornerRadius = 5
        
        
        newadrs.txtfldmiddlename.textColor = UIColor.black
        newadrs.txtfldfirstname.textColor = UIColor.black
        newadrs.txtfldlastname.textColor = UIColor.black
        newadrs.txtfldcountry.textColor = UIColor.black
        newadrs.txtfldpostalcode.textColor = UIColor.black
        newadrs.txtfldphonenumbr.textColor = UIColor.black
        //newadrs.txtfldadrs1.textColor = UIColor.black
        newadrs.txtfldstreetyadrs.textColor = UIColor.black
        newadrs.txtfldcity.textColor = UIColor.black
        newadrs.txtfldstate.textColor = UIColor.black
        newadrs.btnsaveadrs.layer.cornerRadius = 5
        if adressid != nil{
            newadrs.txtfldcity.text=city
            newadrs.txtfldphonenumbr.text=phonenum
            newadrs.txtfldpostalcode.text=postalcode
            newadrs.txtfldstreetyadrs.text=street
             newadrs.txtfldstate.text=region
             newadrs.txtfldfirstname.text=firstname
             newadrs.txtfldlastname.text=lastname
             newadrs.txtfldmiddlename.text=middlename
            
            if (UserDefaults.standard.value(forKey: "countryname") as? String) != nil{
                 newadrs.txtfldcountry.text=(UserDefaults.standard.value(forKey: "countryname") as? String)
            }else{
            newadrs.txtfldcountry.text="United Kingdom"
            }
            
        }
            else{
            newadrs.txtfldcity.text=""
            newadrs.txtfldphonenumbr.text=""
            newadrs.txtfldpostalcode.text=""
            newadrs.txtfldstreetyadrs.text=""
            newadrs.txtfldstate.text=""
            newadrs.txtfldfirstname.text=""
            newadrs.txtfldlastname.text=""
            newadrs.txtfldmiddlename.text=""
            newadrs.txtfldcountry.text=""
            }
        newadrs.btnsaveadrs.addTarget(self, action: #selector(btnsaveadrsaction(sender:)), for: .touchUpInside)
        
        return newadrs
       
            }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 701
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        id=countryidarray[indexPath.row]
//       // servicestatelist()
//    }
    
    @objc func btnsaveadrsaction(sender:UIButton){
        if newadrs.txtfldpostalcode.text == "" {
            let alert = UIAlertController(title: "Incomplete field", message: "Please enter postal code.", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }else if (newadrs.txtfldfirstname.text == " "||newadrs.txtfldmiddlename.text == ""||newadrs.txtfldlastname.text == ""){
            let alert = UIAlertController(title: "Incomplete field", message: "Please fill the name fields", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }else if (newadrs.txtfldstreetyadrs.text == " "||newadrs.txtfldcountry.text == ""||newadrs.txtfldcity.text == ""||newadrs.txtfldstate.text == ""||newadrs.txtfldcountry.text==""){
        
            let alert = UIAlertController(title: "Incomplete field", message: "Please complete the fields", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        
        } else{
        serviceupdatecustomeraddress()
    }
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
                    self.tableviewnewaddress.reloadData()
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
                    print("name",name)
                    let code = value["code"]as! String
                    self.statecodearray.append(code)
                    self.statenamearray.append(name)
                }
                }else{
                    self.statenamearray.append("")
                     //self.statecodearray.append("0")
                }
                DispatchQueue.main.async {
                    //self.hud.hide(animated: true)
                    self.tableviewnewaddress.reloadData()
                }
                
            }
            
            catch{
                print("Error in parsing")
            }
            
            }.resume()
        
        
    }
       
    func serviceupdatecustomeraddress(){
        var params=[String:AnyObject]()

        self.state=self.newadrs.txtfldstate.text!
        
        print("state",state)
        params = ["addressid" :adressid as AnyObject,"firstname" : newadrs.txtfldfirstname.text as AnyObject,"token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc" as AnyObject,"middlename" :newadrs.txtfldmiddlename.text as AnyObject,"lastname" :newadrs.txtfldlastname.text as AnyObject,"regionid" :self.statecodevalue as AnyObject,"city" :newadrs.txtfldcity.text as AnyObject,"street" :newadrs.txtfldstreetyadrs.text as AnyObject,"postcode" :newadrs.txtfldpostalcode.text as AnyObject,"countryid" :self.stateid as AnyObject,"telephone" :newadrs.txtfldphonenumbr.text as AnyObject,"state":self.state as AnyObject]
        print("stateparams:",params)
    
        guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/updatecustomeraddress/")else{return}
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        if textField==newadrs.txtfldcountry{
            return false
        }else if textField==newadrs.txtfldstate{
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
//extension NewaddressViewController: DropDown{
//
//    class txtfldcntry: UITextField {
//
//        override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//            if action == #selector(UIResponderStandardEditActions.paste(_:)) || action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.select(_:)) || action == #selector(UIResponderStandardEditActions.selectAll(_:)){
//                return false
//            }
//
//            return super.canPerformAction(action, withSender: sender)
//   
//    }

//}
