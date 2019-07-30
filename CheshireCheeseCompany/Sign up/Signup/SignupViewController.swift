//
//  SignupViewController.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 13/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

struct jsonsignup{
    let status : String
    let error : String
    
    init(registrationinfo :[String:Any]) {
        status = registrationinfo["status"] as? String ?? ""
        error = registrationinfo["error"]as? String ?? ""
    }
}

//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}

class SignupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var tableviewsignup: UITableView!
    var cell=SignupTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
       tableviewsignup.register(UINib(nibName: "SignupTableViewCell", bundle: nil), forCellReuseIdentifier: "SignupTableViewCell")
       self.hideKeyboardWhenTappedAround()
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
        cell = (tableView.dequeueReusableCell(withIdentifier: "SignupTableViewCell", for: indexPath) as? SignupTableViewCell)!
         let color = UIColor(red: 226 / 255, green: 226 / 255, blue: 226 / 255, alpha: 1.0)
        let txtfldcolor = UIColor(red: 161 / 255, green: 161 / 255, blue: 161 / 255, alpha: 1.0)
         cell.Txtfirstname.borderStyle=UITextBorderStyle.roundedRect
         cell.txtlastname.borderStyle=UITextBorderStyle.roundedRect
         cell.txtpassword.borderStyle=UITextBorderStyle.roundedRect
         cell.txtemail.borderStyle=UITextBorderStyle.roundedRect
         cell.txtcnfirmpassword.borderStyle=UITextBorderStyle.roundedRect
        
        cell.Txtfirstname.layer.borderColor = txtfldcolor.cgColor
        cell.txtlastname.layer.borderColor = txtfldcolor.cgColor
        cell.txtpassword.layer.borderColor = txtfldcolor.cgColor
        cell.txtemail.layer.borderColor = txtfldcolor.cgColor
        cell.txtcnfirmpassword.layer.borderColor = txtfldcolor.cgColor
       
        cell.Txtfirstname.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        imageView.contentMode = .bottomRight
        let image = UIImage(named:"i3")
        imageView.image = image
        cell.Txtfirstname.leftView = imageView
        cell.Txtfirstname.textColor = UIColor.black
        
        cell.txtlastname.leftViewMode = UITextFieldViewMode.always
        let imageViewlastname = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        imageViewlastname.contentMode = .bottomRight
        let imagelastname = UIImage(named:"i3")
        imageViewlastname.image = imagelastname
        cell.txtlastname.leftView = imageViewlastname
        cell.txtlastname.textColor = UIColor.black
        
        cell.txtemail.leftViewMode = UITextFieldViewMode.always
        let imageViewemail = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        imageViewemail.contentMode = .bottomRight
        let imageemail = UIImage(named:"i2")
        imageViewemail.image = imageemail
        cell.txtemail.leftView = imageViewemail
        cell.txtemail.textColor = UIColor.black
        
        cell.txtpassword.leftViewMode = UITextFieldViewMode.always
        let imageViewpassword = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        imageViewpassword.contentMode = .bottomRight
        let imagepassword = UIImage(named:"i1")
        imageViewpassword.image = imagepassword
        cell.txtpassword.leftView = imageViewpassword
        cell.txtpassword.textColor = UIColor.black
        
        cell.txtcnfirmpassword.leftViewMode = UITextFieldViewMode.always
        let imageViewcnfrmpassword = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        imageViewcnfrmpassword.contentMode = .bottomRight
        let imagecnfrmpassword = UIImage(named:"i1")
        imageViewcnfrmpassword.image = imagecnfrmpassword
        cell.txtcnfirmpassword.leftView = imageViewcnfrmpassword
        cell.txtcnfirmpassword.textColor = UIColor.black
        
        cell.Txtfirstname.layer.borderWidth = 1
        cell.Txtfirstname.layer.cornerRadius = 5
        cell.txtlastname.layer.borderWidth = 1
        cell.txtlastname.layer.cornerRadius = 5
        cell.txtpassword.layer.borderWidth = 1
        cell.txtpassword.layer.cornerRadius = 5
        cell.txtemail.layer.borderWidth = 1
        cell.txtemail.layer.cornerRadius = 5
        cell.txtcnfirmpassword.layer.borderWidth = 1
        cell.txtcnfirmpassword.layer.cornerRadius = 5
       
        cell.Outerview.layer.borderWidth = 2
        cell.Outerview.layer.borderColor = color.cgColor
        cell.Outerview.layer.cornerRadius = 5
        cell.viewalreadyamembr.layer.borderColor = color.cgColor
        cell.viewalreadyamembr.layer.cornerRadius = 1
        cell.viewalreadyamembr.layer.borderWidth = 2
        
        cell.btncontinue.layer.cornerRadius = 5
        cell.btnchckgender2.addTarget(self, action: #selector(btnchckgender2(sender:)), for: .touchUpInside)
        cell.btnchcklogin.addTarget(self, action: #selector(btnchcklogin(sender:)), for: .touchUpInside)
    
      cell.btncontinue.addTarget(self, action: #selector(btncontinue(sender:)), for: .touchUpInside)
        return cell
    }
     @objc func btncontinue(sender:UIButton){
        if(cell.Txtfirstname.text == ""){
            
            let alert = UIAlertController(title: "Incomplete field", message: "Please enter your first name.", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
            
        }
        else if (cell.txtlastname.text == ""){
            
            let alert = UIAlertController(title: "Incomplete field", message: "Please enter your last name.", preferredStyle: .alert)
            
            //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
            
        }
        else if !isPasswordValid(cell.txtpassword.text!){
            
            let alert = UIAlertController(title: "Invalid password", message: "Please enter your password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }
        else if(cell.txtpassword.text!.characters.count < 6){
            
            let alert = UIAlertController(title: "", message: "Please enter a password with at least 6 characters.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            }
            
        else if (cell.txtpassword.text != cell.txtcnfirmpassword.text){
            
            let alert = UIAlertController(title: "Password not matched", message: "Confirmed password not matched please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }
            
        else if !isValidEmail(testStr: cell.txtemail.text!){
            
            let alert = UIAlertController(title: "Invalid email id", message: "Please enter your correct email id.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }
        else{
        
       servicecustomerregistration()
        }
        
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^[A-Za-z\\d$@$#!%*?&]{1,}")
        return passwordTest.evaluate(with: password)
    }
    @objc func btnchcklogin(sender: UIButton){
        let signin = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
        //header.removeFromSuperview()
        let nc = revealViewController().frontViewController as! UINavigationController
        
        nc.pushViewController(signin, animated: false)
        revealViewController().pushFrontViewController(nc, animated: true)
    }
    @objc func backaction(sender: UIButton){
       navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc func btnchckgender2(sender: UIButton){
        if(cell.btnchckgender2.currentImage == UIImage(named:"radiobuttun01")){

    cell.btnchckgender2.setImage(UIImage(named:"radiobuttun"),for: .normal)
    cell.btnchckgender.setImage(UIImage(named:"radiobuttun01"),for: .normal)
            }
            else
            {
            cell.btnchckgender2.setImage(UIImage(named:"radiobuttun01"), for: .normal)
            cell.btnchckgender.setImage(UIImage(named:"radiobuttun"), for: .normal)
    }
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 590
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func servicecustomerregistration(){
        //"email" :"testapi@gamil.com","password" : "test@123","token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc"
        let parameters:[String:String] = ["email" :cell.txtemail.text as! String,"password" : cell.txtpassword.text as! String,"token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc","firstname" :cell.Txtfirstname.text as! String,"lastname" :cell.txtlastname.text as! String]
        guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/createCustomer")else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        print("parameters",parameters)
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
                    guard let jsonsignup = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray else{
                        return
                    }
                    for item in jsonsignup{
                        let value = item as! [String:Any]
                        let status = value["status"] as! String
                       // let error=value["error"] as! String
                        print("status",status)
                        if status=="true"{
                    
                        let alert = UIAlertController(title: "", message: "Registration successfull", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                            
                            let login = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
                            self.navigationController?.pushViewController(login, animated: false)
                            
                        }))
                        self.present(alert, animated: true)
                    
                       }else{
                            let error=value["error"] as! String
                        let alert = UIAlertController(title: "Alert", message: error, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                            
                        }))
                        self.present(alert, animated: true)
                        }
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
        
    
                        


