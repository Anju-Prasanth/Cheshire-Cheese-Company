//
//  EmptycartViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 09/05/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class EmptycartViewController: UIViewController {
    var header:UIImageView!
    var emptycartflag=Int()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let logo = UIImage(named: "logo")
//        header = UIImageView(image: logo)
//        header.contentMode = .scaleAspectFit // set imageview's content mode
//        header.frame = CGRect(x:50, y:0, width: 60, height:40)
//        self.navigationController?.navigationBar.addSubview(header)
        //searchbar.isHidden=true
       // let searchlogoimage = UIImage (named: "icon-1")
        // let cartlogoimage = UIImage (named: "shoppingcart")
        //let loginlogoimage = UIImage (named: "icon-3")
       // let btnsearch = UIBarButtonItem (image: searchlogoimage, style: .plain, target: self, action: #selector(ProductDetailsViewController.searchaction))
        // let btncart = UIBarButtonItem (image: cartlogoimage, style: .plain, target: self, action: #selector(ProductDetailsViewController.cartaction))
        //let btnlogin = UIBarButtonItem (image: loginlogoimage, style: .plain, target: self, action: #selector(ProductDetailsViewController.loginaction))
        // navigationItem.setRightBarButtonItems([btnlogin,btncart,btnsearch], animated: true)
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        
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
        if emptycartflag==1{
            let home = self.storyboard?.instantiateViewController (withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(home, animated: false)
        }else{
        self.navigationController?.popViewController(animated: true)
        }
    }

}
