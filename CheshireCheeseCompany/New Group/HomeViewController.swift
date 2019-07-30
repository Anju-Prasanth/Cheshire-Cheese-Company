//
//  HomeViewController.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 07/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import MBProgressHUD

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,promotioncollectionDelegate,whatsnewcollectiondelegate,topsellingcollectionviewdelegate,UISearchBarDelegate{
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet var hometableview: UITableView!
   
    var header: UIImageView!
    var navigationBar:UINavigationBar!
     var testdict:[String:AnyObject]!
    var sliderimagearray=[String]()
    
    var cellsliderimage=HomeSliderimageTableViewCell()
    var shopbyctegory=HomeShopbyCategoryTableViewCell()
    var titleshopbyctegory=HomeTitleShopbyCategoryTableViewCell()
    var whatsnew=HomeWhatsNewTableViewCell()
    var titlewhatsnew=HomeTitleWhatsNewTableViewCell()
    var topselling=HomeTopSellingTableViewCell()
    var titletopselling=HomeTitleTopSellingTableViewCell()
    var hud:MBProgressHUD=MBProgressHUD()
    var width:Int=0
    let cartbtn=SSBadgeButton()
    var cartnamearray=[String]()
    var firstname:String!
    var addedcart="0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = UIColor(red: 81 / 255, green: 155 / 255, blue: 22 / 255, alpha: 1.0)
        //self.navigationController?.navigationBar.barTintColor = UIColor.green
          searchbar.isHidden=true
//        let logo = UIImage(named: "logo")
//        header = UIImageView(image: logo)
//        header.contentMode = .scaleAspectFit // set imageview's content mode
//        header.frame = CGRect(x:70, y:5, width: 50, height:30)
//        self.navigationController?.navigationBar.addSubview(header)
        
        if let revealController = self.revealViewController() {
            revealController.panGestureRecognizer()
            revealController.tapGestureRecognizer()
        }
        //let btnlogo = UIImage (named: "logo")
        //let menu=UIImage (named: "icon-4")
        
        let searchlogoimage = UIImage (named: "icon-1")
        //let cartlogoimage = UIImage (named: "shoppingcart")
        let loginlogoimage = UIImage (named: "icon-3")
        let btnsearch = UIBarButtonItem (image: searchlogoimage, style: .plain, target: self, action: #selector(HomeViewController.searchaction))
        //let btncart = UIBarButtonItem (image: cartlogoimage, style: .plain, target: self, action: #selector(HomeViewController.cartaction))
         let btnlogin = UIBarButtonItem (image: loginlogoimage, style: .plain, target: self, action: #selector(HomeViewController.loginaction))
        // let logobutton = UIBarButtonItem (image: btnlogo, style: .plain, target: self, action: #selector(HomeViewController.logoaction))
          //var menuButton=UIBarButtonItem (image: menu, style: .plain, target: self, action: #selector(HomeViewController.menuaction))
      width=Int(UIScreen.main.bounds.width)
    
        cartbtn.addTarget(self, action: #selector(cartaction), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [btnlogin,UIBarButtonItem(customView: cartbtn),btnsearch]
         //navigationItem.setLeftBarButtonItems([menuButton,logobutton], animated: true)
        
         hometableview.register(UINib(nibName: "HomeSliderimageTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeSliderimageTableViewCell")
        hometableview.register(UINib(nibName: "HomeShopbyCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeShopbyCategoryTableViewCell")
        
        hometableview.register(UINib(nibName: "HomeTitleShopbyCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTitleShopbyCategoryTableViewCell")
        
        hometableview.register(UINib(nibName: "HomeWhatsNewTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeWhatsNewTableViewCell")
        
        hometableview.register(UINib(nibName: "HomeTitleWhatsNewTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTitleWhatsNewTableViewCell")
        
        hometableview.register(UINib(nibName: "HomeTopSellingTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTopSellingTableViewCell")
        
         hometableview.register(UINib(nibName: "HomeTitleTopSellingTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTitleTopSellingTableViewCell")
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
          self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        print("cartnamearray",cartnamearray.count)
       // addedcart=UserDefaults.standard.string(forKey: "addedcart")!
        firstname = UserDefaults.standard.value(forKey: "name") as? String
        print("firstname",firstname)
        print(UserDefaults.standard.stringArray(forKey: "cartbadge"))
//        let logo = UIImage(named: "logo")
//                header = UIImageView(image: logo)
//                header.contentMode = .scaleAspectFit 
//                header.frame = CGRect(x:50, y:0, width: 60, height:40)
//                self.navigationController?.navigationBar.addSubview(header)
        if  (UserDefaults.standard.stringArray(forKey: "cartbadge")) != nil{
             cartnamearray=UserDefaults.standard.stringArray(forKey: "cartbadge") as! [String]
        }else{
            print(UserDefaults.standard.stringArray(forKey: "cartbadge"))
        }
            if cartnamearray.count==0{
                cartbtn.badge = " "
                cartbtn.badgeBackgroundColor = UIColor.clear
            }else{
                cartnamearray=UserDefaults.standard.stringArray(forKey: "cartbadge") as! [String]
                self.cartbtn.badgeBackgroundColor = UIColor.white
                cartbtn.badge = String(cartnamearray.count)
                print("cartnamearray",cartnamearray)
            }
        
        
            
            cartbtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            cartbtn.setBackgroundImage(UIImage(named: "shoppingcart"), for: .normal)
            cartbtn.badgeEdgeInsets = UIEdgeInsets(top: 25, left: 15, bottom: 15, right: 18)
            
            searchbar.isHidden=true
        }
    
    
    
//    func servicesliderimages(){
//        let url1 = "https://www.cheshirecheesecompany.co.uk///rest/V1/hello/name/33urorbe0o4fqu8jwpu25jbtowi8p5uc"
//        Alamofire.request(url1, method: .get, parameters: nil).validate {request, response, data in
//            return .success
//            }
//            .responseJSON { response in
//                print("------ccc------")
//                self.parseData(response.data!)
//                print(response.data as Any)
//        }
//    }
//    func parseData(_ data : Data){
//        do{
//            let readableJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                        print("readableJSON : \(readableJSON)")
//            let test = Mapper<responsetest>().mapArray(JSONArray: readableJSON as! [[String : Any]])
//                        print("test",test as Any)
//            for item in test{
//                let bannerslider = item.bannerslider
////                let title = item.title
////                print("title",title)
//                print("bannerslider",bannerslider!  as NSDictionary)
//                testdict = bannerslider
//                let image=testdict["image"] as! NSString
//                print("image",image)
//                sliderimagearray.append(image as String)
//
//                //let testarray=Array(testdict.keys)
//                //                print("array",testarray)
//                //                let index=testdict["22"]as! NSDictionary
//                //                print("index",index)
//                //for value in 0...testarray.count-1{
//                    //                    let name=testdict[testarray[5]]as! NSDictionary
//                    //let sampletest=testdict![testarray[value]]as! NSDictionary
//                    //                    print("sampletest result:",sampletest)
//                    //print("**********************")
//                    //let image=sampletest["image"] as! NSString
//                   // print("image",image)
//                    //let subcat = sampletest["subCategories"]
//                    //                    print("subcat:",subcat)
////                    if subcat != nil{
////                        subdict = subcat as! [String : AnyObject]
////                        let subarray=Array(subdict!.keys)
////                        for value in 0...subarray.count-1{
////                            //                    let name=testdict[testarray[5]]as! NSDictionary
////                            let sub=subdict![subarray[value]]as! NSDictionary
////                            //                    print("sampletest result:",sampletest)
////                            print("$$$$$$$$$$$$$$$$$$$$$$$$")
////                            let subname=sub["name"] as! NSString
////                            print("subname",subname)
////
////                        }
////
////                    }
//
//
//
//                }
//                //                let name1=name["name"] as! NSString
//                //                print("name1",name1)
//            }
//
//            //            for (key,value) in testdict{
//            //            print("\(key) -> \(value)")
//            //            }
//
//
//        catch{
//            print(error)
//        }
//}
//
//
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @objc func searchaction(_ searchBar: UISearchBar){
        if searchbar.isHidden==true{
            searchbar.isHidden=false

        }else{
            searchbar.isHidden=true
        }
    }
    @objc func cartaction(){
//        if firstname == "Hi Guest"{
//            let login = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
//             self.navigationController?.pushViewController(login, animated: false)
//        }
//              else
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
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
            return 1
            
        }else if section==1{
             return 1
        }else if section==2{
            return 1
        }
        else if section==3{
            return 1
        }
        else if section==4{
            return 1
        }
        else if section==5{
            return 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section==0{
            cellsliderimage = (tableView.dequeueReusableCell(withIdentifier: "HomeSliderimageTableViewCell", for: indexPath) as? HomeSliderimageTableViewCell)!
          
            return cellsliderimage
        }else if indexPath.section==1{
            titleshopbyctegory = (tableView.dequeueReusableCell(withIdentifier: "HomeTitleShopbyCategoryTableViewCell", for: indexPath) as? HomeTitleShopbyCategoryTableViewCell)!
            
            return titleshopbyctegory
        }else if indexPath.section==2{
            shopbyctegory = (tableView.dequeueReusableCell(withIdentifier: "HomeShopbyCategoryTableViewCell", for: indexPath) as? HomeShopbyCategoryTableViewCell)!
        shopbyctegory.delegate=self
            return shopbyctegory
        }else if indexPath.section==3{
            titlewhatsnew = (tableView.dequeueReusableCell(withIdentifier: "HomeTitleWhatsNewTableViewCell", for: indexPath) as? HomeTitleWhatsNewTableViewCell)!
            return titlewhatsnew
        }else if indexPath.section==4{
            whatsnew = (tableView.dequeueReusableCell(withIdentifier: "HomeWhatsNewTableViewCell", for: indexPath) as? HomeWhatsNewTableViewCell)!
            whatsnew.delegate=self
            return whatsnew
        }else if indexPath.section==5{
            titletopselling = (tableView.dequeueReusableCell(withIdentifier: "HomeTitleTopSellingTableViewCell", for: indexPath) as? HomeTitleTopSellingTableViewCell)!
            return titletopselling
        }
        else {
            topselling = (tableView.dequeueReusableCell(withIdentifier: "HomeTopSellingTableViewCell", for: indexPath) as? HomeTopSellingTableViewCell)!
            topselling.delegate=self
            return topselling
        }
        
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0{
            return 242
        }
        else if indexPath.section==1{
            return 36
        }
        else if indexPath.section==2{
            return 210
        }
        else if indexPath.section==3{
            return 57
        }
        else if indexPath.section==4{
            return 255
        }
        else if indexPath.section==5{
            return 49
        }else{
            return 250
        }
        
    }
    
//     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProductListingViewController") as! ProductListingViewController
//
//
//        self.navigationController?.pushViewController(productlisting, animated: true)
//
//    }
    func selectedcollectioncell(id: AnyObject,categoryid: Int,categoryname: String) {
          let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as! ProdctlistingShopbyctgryViewController
        print("categoryid",categoryid)
         print("categoryname",categoryname)
         productlisting.id=categoryid
        productlisting.categoryname=categoryname
         self.navigationController?.pushViewController(productlisting, animated: true)
    }
    
    func whatsnewcellselection(value: AnyObject,sku: AnyObject)  {
        let productdetails = self.storyboard?.instantiateViewController (withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        productdetails.skuid=sku as! String
         print("whatsnew.....")
        self.navigationController?.pushViewController(productdetails, animated: true)
    }
    func topselling(value: AnyObject,productid: Int,categoryname: String)  {
        let productlisting = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as! ProdctlistingShopbyctgryViewController
        productlisting.id=productid
         productlisting.categoryname=categoryname
        print("whatsnew.....")
        self.navigationController?.pushViewController(productlisting, animated: true)
    }
   // @IBAction func searchAction(sender: UIBarButtonItem) {
//        // Create the search controller and specify that it should present its results in this same view
//        searchController = UISearchController(searchResultsController: nil)
//
//        // Set any properties (in this case, don't hide the nav bar and don't show the emoji keyboard option)
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.searchBar.keyboardType = UIKeyboardType.ASCIICapable
//
//        // Make this class the delegate and present the search
//        self.searchController.searchBar.delegate = self
//        presentViewController(searchController, animated: true, completion: nil)
//    }
    
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
    
    
    
}
