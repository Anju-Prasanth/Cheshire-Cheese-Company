//
//  ForgotPasswordViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 29/06/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var btncontinue: UIButton!
    @IBOutlet weak var textemail: UITextField!
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
        let color = UIColor(red: 226 / 255, green: 226 / 255, blue: 226 / 255, alpha: 1.0)
        let txtfldcolor = UIColor(red: 161 / 255, green: 161 / 255, blue: 161 / 255, alpha: 1.0)
        textemail.borderStyle=UITextBorderStyle.roundedRect
        
        
        textemail.layer.borderColor = txtfldcolor.cgColor
        
        
        textemail.layer.borderWidth = 1
        textemail.layer.cornerRadius = 5
        
         btncontinue.layer.cornerRadius=5
        
        textemail.textColor = UIColor.black
       
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
    
    @IBAction func btncontinueaction(_ sender: UIButton) {
        if textemail.text==""{
            let alert = UIAlertController(title: "Alert", message: "Please enter your email id", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else{
            serviceresetpassword()
        }
        
    }
    func  serviceresetpassword(){
        var params=[String:AnyObject]()
        
        params = ["email" : textemail.text as AnyObject,"template" : "email_reset" as AnyObject,"websiteId" : 1 as AnyObject]
        
        
        
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
                                    print("status",status)
                                    if status=="TRUE"{
                                        let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                                            
                                            let login = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
                                            self.navigationController?.pushViewController(login, animated: false)
                                            
                                        }))
                                        
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

}
