//
//  OrderhistoryViewController.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 14/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class OrderhistoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {

    @IBOutlet weak var menubutton: UIBarButtonItem!
    @IBOutlet weak var lblorders: UILabel!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tablevieworderhistory: UITableView!
    var orderhistory=OrderDetailsTableViewCell()
    var orderdelivered=OrderdeliveredTableViewCell()
    var header: UIImageView!
    let cartbtn=SSBadgeButton()
    var cartnamearray=[String]()
    var firstname:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchbar.isHidden=true
        let searchlogoimage = UIImage (named: "icon-1")
       // let cartlogoimage = UIImage (named: "shoppingcart")
        let loginlogoimage = UIImage (named: "icon-3")
        let btnsearch = UIBarButtonItem (image: searchlogoimage, style: .plain, target: self, action: #selector(OrderhistoryViewController.searchaction))
       // let btncart = UIBarButtonItem (image: cartlogoimage, style: .plain, target: self, action: #selector(OrderhistoryViewController.cartaction))
        let btnlogin = UIBarButtonItem (image: loginlogoimage, style: .plain, target: self, action: #selector(OrderhistoryViewController.loginaction))
//        let backlogoimage=UIImage (named: "back")
//        let btnback = UIBarButtonItem (image: backlogoimage, style: .plain, target: self, action: #selector(OrderhistoryViewController.backaction))
//        navigationItem.setLeftBarButton(btnback, animated: true)
//
//        self.navigationItem.setHidesBackButton(true, animated:true)
//       // navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        self.navigationItem.backBarButtonItem?.title=""
//         self.navigationItem.hidesBackButton=true
//
    
        cartbtn.addTarget(self, action: #selector(cartaction), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [btnlogin,UIBarButtonItem(customView: cartbtn),btnsearch]
        
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        
       
       tablevieworderhistory.register(UINib(nibName: "OrderDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderDetailsTableViewCell")
        tablevieworderhistory.register(UINib(nibName: "OrderdeliveredTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderdeliveredTableViewCell")
         self.hideKeyboardWhenTappedAround()
        
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
//        let logo = UIImage(named: "logo")
//        header = UIImageView(image: logo)
//        header.contentMode = .scaleAspectFit // set imageview's content mode
//        header.frame = CGRect(x:50, y:0, width: 60, height:40)
//        self.navigationController?.navigationBar.addSubview(header)
        firstname = UserDefaults.standard.value(forKey: "name") as? String
        print("firstname",firstname)
        cartnamearray=UserDefaults.standard.stringArray(forKey: "cartbadge") as! [String]
        if cartnamearray.count==0{
            cartbtn.badge = " "
            cartbtn.badgeBackgroundColor = UIColor.clear
        }else{
            //cartnamearray=UserDefaults.standard.stringArray(forKey: "cartbadge") as! [String]
            self.cartbtn.badgeBackgroundColor = UIColor.white
            cartbtn.badge = String(cartnamearray.count)
            print("cartnamearray",cartnamearray)
        }
        
        
        
        cartbtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        cartbtn.setBackgroundImage(UIImage(named: "shoppingcart"), for: .normal)
        cartbtn.badgeEdgeInsets = UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 18)
        searchbar.isHidden=true
        
        
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
        if firstname != nil && firstname != "Hi Guest"{
            let myaccount = self.storyboard?.instantiateViewController (withIdentifier: "MyAccountViewController") as! MyAccountViewController
            //header.removeFromSuperview()
            self.navigationController?.pushViewController(myaccount, animated: true)
        }else{
            let signin = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
            //header.removeFromSuperview()
            self.navigationController?.pushViewController(signin, animated: true)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchbar.text == ""{
            print("no search")
        }
        else{
            print("yes search")
            let searchstring = searchbar.text
            searchbar.text = ""
            let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as! ProdctlistingShopbyctgryViewController
            productlisting.searchflag = 1
            productlisting.keyword = searchstring!
            self.navigationController?.pushViewController(productlisting, animated: true)
            
            
        }
    }
    
    
    
    
    @objc func searchaction(){
        if searchbar.isHidden==true{
            searchbar.isHidden=false
        }else{
            searchbar.isHidden=true
        }
        
    }
    @objc func backaction(){
       
      navigationController?.popViewController(animated: true)
    }
    @objc func cartaction(){
        if cartnamearray.count==0{
            let emptycart = self.storyboard?.instantiateViewController (withIdentifier: "EmptycartViewController") as! EmptycartViewController
            
            self.navigationController?.pushViewController(emptycart, animated: false)
        }else{
            let mybag = self.storyboard?.instantiateViewController (withIdentifier: "MyBagViewController") as! MyBagViewController
            
            self.navigationController?.pushViewController(mybag, animated: false)
        }
    }
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
            return 1
        }else{
            return 2
    }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if  indexPath.section==0{
        orderhistory = (tableView.dequeueReusableCell(withIdentifier: "OrderDetailsTableViewCell", for: indexPath) as? OrderDetailsTableViewCell)!
        orderhistory.Outerview.layer.cornerRadius = 5.0
       // orderhistory.Outerview.layer.shadowColor = UIColor.gray.cgColor
//        orderhistory.Outerview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        orderhistory.Outerview.layer.shadowRadius = 12.0
//        orderhistory.Outerview.layer.shadowOpacity = 0.7
        return orderhistory
         }else{
            orderdelivered = (tableView.dequeueReusableCell(withIdentifier: "OrderdeliveredTableViewCell", for: indexPath) as? OrderdeliveredTableViewCell)!
            orderdelivered.Outerview.layer.cornerRadius = 5.0
           // orderdelivered.Outerview.layer.shadowColor = UIColor.gray.cgColor
//            orderdelivered.Outerview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//            orderdelivered.Outerview.layer.shadowRadius = 12.0
//            orderdelivered.Outerview.layer.shadowOpacity = 0.7
            return orderdelivered
        }
        }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0{
            return 169
        }else{
            return 167
        
    }
        }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
