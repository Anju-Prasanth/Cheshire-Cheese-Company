//
//  MoreViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 05/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    var header=UIImageView()
    var name=String()

    @IBOutlet weak var lblheading: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

//        let logo = UIImage(named: "logo")
//        header = UIImageView(image: logo)
//        header.contentMode = .scaleAspectFit // set imageview's content mode
//        header.frame = CGRect(x:50, y:0, width: 60, height:40)
//        self.navigationController?.navigationBar.addSubview(header)
            lblheading.text=name
        
         let searchlogoimage = UIImage (named: "icon-1")
        let cartlogoimage = UIImage (named: "shoppingcart")
        let loginlogoimage = UIImage (named: "icon-3")
        let btnsearch = UIBarButtonItem (image: searchlogoimage, style: .plain, target: self, action: #selector(MoreViewController.searchaction))
        let btncart = UIBarButtonItem (image: cartlogoimage, style: .plain, target: self, action: #selector(MoreViewController.cartaction))
        let btnlogin = UIBarButtonItem (image: loginlogoimage, style: .plain, target: self, action: #selector(MoreViewController.loginaction))
         navigationItem.setRightBarButtonItems([btnlogin,btncart,btnsearch], animated: true)
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
       // navigationItem.setRightBarButtonItems([btnlogin,btncart], animated: true)
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
    @objc func loginaction(){
        let signin = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
        //header.removeFromSuperview()
        self.navigationController?.pushViewController(signin, animated: true)
        
    }
       @objc func searchaction(){
    //        if searchbar.isHidden==true{
    //            searchbar.isHidden=false
    //        }else{
    //            searchbar.isHidden=true
    //        }
    //
        }
    @objc func cartaction(){
        let mybag = self.storyboard?.instantiateViewController (withIdentifier: "MyBagViewController") as! MyBagViewController
        //header.removeFromSuperview()
        self.navigationController?.pushViewController(mybag, animated: false)
    }
    
}
