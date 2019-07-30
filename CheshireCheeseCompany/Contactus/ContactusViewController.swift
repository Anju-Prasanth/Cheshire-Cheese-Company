//
//  ContactusViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 28/05/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import Kingfisher
import MBProgressHUD




struct contactus{
    let status : String
    let message : String
    
    init(registrationinfo :[String:Any]) {
        status = registrationinfo["status"] as? String ?? ""
        message = registrationinfo["message"]as? String ?? ""
    }
}


class ContactusViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate{

    @IBOutlet weak var tableviewcotactus: UITableView!
    var contactus=contactusTableViewCell()
    var placeholderLabel=UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        tableviewcotactus.register(UINib(nibName: "contactusTableViewCell", bundle: nil), forCellReuseIdentifier: "contactusTableViewCell")
         self.hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
        title = "Contact Us"
        
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
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        contactus = (tableView.dequeueReusableCell(withIdentifier: "contactusTableViewCell", for: indexPath) as? contactusTableViewCell)!
        let color = UIColor(red: 226 / 255, green: 226 / 255, blue: 226 / 255, alpha: 1.0)
        let txtfldcolor = UIColor(red: 161 / 255, green: 161 / 255, blue: 161 / 255, alpha: 1.0)
        contactus.txtviewmessage.delegate=self
        
        placeholderLabel.text = "Message"
//        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (textView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        contactus.txtviewmessage.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (contactus.txtviewmessage.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !contactus.txtviewmessage.text.isEmpty
        
        
        
        
        contactus.txtfldname.borderStyle=UITextBorderStyle.roundedRect
        contactus.txtfldemail.borderStyle=UITextBorderStyle.roundedRect
        contactus.txtfldphnenumbr.borderStyle=UITextBorderStyle.roundedRect
        contactus.txtviewmessage.layer.cornerRadius=5
        
        contactus.txtfldname.layer.borderColor = txtfldcolor.cgColor
        contactus.txtfldemail.layer.borderColor = txtfldcolor.cgColor
        contactus.txtfldphnenumbr.layer.borderColor = txtfldcolor.cgColor
        contactus.txtviewmessage.layer.borderColor = txtfldcolor.cgColor
       
        
        
        contactus.txtfldname.layer.borderWidth = 1
        contactus.txtfldname.layer.cornerRadius = 5
        contactus.txtfldemail.layer.borderWidth = 1
        contactus.txtfldemail.layer.cornerRadius = 5
        contactus.txtfldphnenumbr.layer.borderWidth = 1
        contactus.txtfldphnenumbr.layer.cornerRadius = 5
        contactus.txtviewmessage.layer.borderWidth = 1
       
        
        
        contactus.Outerview.layer.borderWidth = 2
        contactus.Outerview.layer.borderColor = color.cgColor
        contactus.Outerview.layer.cornerRadius = 5
        
        contactus.txtfldphnenumbr.textColor = UIColor.black
        contactus.txtfldname.textColor = UIColor.black
        contactus.txtviewmessage.textColor = UIColor.black
        contactus.txtfldemail.textColor = UIColor.black
        
        contactus.btnsend.layer.cornerRadius = 5
        contactus.btnsend.addTarget(self, action: #selector(btnsendaction(sender:)), for: .touchUpInside)
        return contactus
        
    }
    @objc func btnsendaction(sender:UIButton){
        if(contactus.txtfldname.text == "")||contactus.txtfldphnenumbr.text == ""||contactus.txtfldemail.text == ""{
            
            let alert = UIAlertController(title: "Incomplete field", message: "Please complete the fields.", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }else if !isValidEmail(testStr: contactus.txtfldemail.text!){
            
            let alert = UIAlertController(title: "Invalid email id", message: "Please enter your correct email id.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else{
                servicecontactus()
            }
            
        }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 500
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !contactus.txtviewmessage.text.isEmpty
    }
        func servicecontactus(){
            var contactmessage=String()
            var params=[String:AnyObject]()
            if contactus.txtviewmessage.text==""{
                contactmessage=""
                 params = ["email" :contactus.txtfldemail.text as AnyObject,"name" : contactus.txtfldname.text as AnyObject,"token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc" as AnyObject,"phone" :contactus.txtfldphnenumbr.text as AnyObject,"message" :contactmessage as AnyObject]
                
            }else{
                contactmessage=contactus.txtviewmessage.text
                 params = ["email" :contactus.txtfldemail.text as AnyObject,"name" : contactus.txtfldname.text as AnyObject,"token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc" as AnyObject,"phone" :contactus.txtfldphnenumbr.text as AnyObject,"message" :contactmessage as AnyObject]
            }
            
            
            guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/contactus/")else{return}
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
                            if status=="true"{
                                let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                                    
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
                            let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .alert)
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
    
    
}
