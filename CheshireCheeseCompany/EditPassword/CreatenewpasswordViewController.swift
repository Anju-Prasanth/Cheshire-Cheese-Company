//
//  CreatenewpasswordViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 10/06/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class CreatenewpasswordViewController: UIViewController {

    @IBOutlet weak var btnsavepassword: UIButton!
    @IBOutlet weak var txtfldcnfrmnewpassword: UITextField!
    @IBOutlet weak var txtfldnewpassword: UITextField!
    @IBOutlet weak var txtfldcurrentpassword: UITextField!
     var email:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        let color = UIColor(red: 226 / 255, green: 226 / 255, blue: 226 / 255, alpha: 1.0)
        let txtfldcolor = UIColor(red: 161 / 255, green: 161 / 255, blue: 161 / 255, alpha: 1.0)
        txtfldnewpassword.borderStyle=UITextBorderStyle.roundedRect
        txtfldcurrentpassword.borderStyle=UITextBorderStyle.roundedRect
        txtfldcnfrmnewpassword.borderStyle=UITextBorderStyle.roundedRect
        
           txtfldnewpassword.layer.borderColor = txtfldcolor.cgColor
           txtfldcurrentpassword.layer.borderColor = txtfldcolor.cgColor
           txtfldcnfrmnewpassword.layer.borderColor = txtfldcolor.cgColor
    
        txtfldnewpassword.layer.borderWidth = 1
        txtfldnewpassword.layer.cornerRadius = 5
        txtfldcurrentpassword.layer.borderWidth = 1
        txtfldcurrentpassword.layer.cornerRadius = 5
        txtfldcnfrmnewpassword.layer.borderWidth = 1
        txtfldcnfrmnewpassword.layer.cornerRadius = 5
        
    
        
       txtfldnewpassword.textColor = UIColor.black
        txtfldcurrentpassword.textColor = UIColor.black
       txtfldcnfrmnewpassword.textColor = UIColor.black
        btnsavepassword.layer.cornerRadius = 5
            
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
    
    
    @IBAction func btnsavepasswordaction(_ sender: Any) {
        if txtfldnewpassword.text == "" || txtfldcurrentpassword.text==""{
            let alert = UIAlertController(title: "Incomplete field", message: "Please complete the fields", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }else  if txtfldcnfrmnewpassword.text == ""{
            let alert = UIAlertController(title: "Incomplete field", message: "Please confirm your new password", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else if txtfldcnfrmnewpassword.text != txtfldnewpassword.text {
            let alert = UIAlertController(title: "Alert", message: "Password doesn't match with the new password", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else{
            servicecrteatenewpassword()
        }
    }
    
    func servicecrteatenewpassword(){
        var params=[String:AnyObject]()
        email = UserDefaults.standard.value(forKey: "email") as? String
        params = ["email" :email as AnyObject,"password" : txtfldcurrentpassword.text as AnyObject,"token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc" as AnyObject,"newpassword" :txtfldnewpassword.text as AnyObject]
        
        
        guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/hello/CustomersCreateNewPassword")else{return}
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
                        if status=="TRUE"{
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

    

}
