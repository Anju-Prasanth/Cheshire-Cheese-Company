//
//  ProductListingViewController.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 09/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher

//struct Products {
//    let price : String
//    let entity_id : String
//    //let alttext: String
//    init(productdata :[String:Any]) {
//        price = productdata["price"] as? String ?? ""
//        entity_id = productdata["entity_id"] as? String ?? ""
//    }
//}

class ProductListingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var productlistingcollectionview: UICollectionView!
    
    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var viewlabelproductname: UIView!
    var header: UIImageView!
    var navigationBar:UINavigationBar!
    var cell=searchproductlistingCollectionViewCell()
    var width:Int=0
    var testdict:[String:AnyObject]!
    let cartbtn=SSBadgeButton()
    var cartnamearray=[String]()
    var firstname:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let logo = UIImage(named: "logo")
//        header = UIImageView(image: logo)
//        header.contentMode = .scaleAspectFit // set imageview's content mode
//        header.frame = CGRect(x:50, y:0, width: 60, height:40)
//        self.navigationController?.navigationBar.addSubview(header)
       // let backlogoimage=UIImage (named: "back")
        let searchlogoimage = UIImage (named: "icon-1")
        let cartlogoimage = UIImage (named: "shoppingcart")
        let loginlogoimage = UIImage (named: "icon-3")
        let btnsearch = UIBarButtonItem (image: searchlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.searchaction))
        let btncart = UIBarButtonItem (image: cartlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.cartaction))
        let btnlogin = UIBarButtonItem (image: loginlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.loginaction))
        // let btnback = UIBarButtonItem (image: backlogoimage, style: .plain, target: self, action: #selector(ProductListingViewController.backaction))
        cartbtn.addTarget(self, action: #selector(cartaction), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [btnlogin,UIBarButtonItem(customView: cartbtn),btnsearch]
        
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        
        
       // navigationItem.setLeftBarButton(btnback, animated: true)
        //self.navigationItem.setHidesBackButton(true, animated:true)
        width=Int(UIScreen.main.bounds.size.width)
        productlistingcollectionview.delegate=self
        productlistingcollectionview.dataSource=self
        self.productlistingcollectionview.register(UINib(nibName: "searchproductlistingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "searchproductlistingCollectionViewCell")
        searchbar.isHidden=true
  self.hideKeyboardWhenTappedAround()
       // serviceproductlisting()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        
        
        firstname = UserDefaults.standard.value(forKey: "name") as? String
        print("firstname",firstname)
        
//        let logo = UIImage(named: "logo")
//        header = UIImageView(image: logo)
//        header.contentMode = .scaleAspectFit // set imageview's content mode
//        header.frame = CGRect(x:50, y:0, width: 60, height:40)
//        self.navigationController?.navigationBar.addSubview(header)
        if (UserDefaults.standard.stringArray(forKey: "cartbadge")) != nil{
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
    @objc func searchaction(){
        if searchbar.isHidden==true{
            searchbar.isHidden=false
        }else{
            searchbar.isHidden=true
        }
        
    }
    @objc func cartaction(){
//        if firstname == "Hi Guest"{
//            let login = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
//            self.navigationController?.pushViewController(login, animated: false)
//        }
       // else
        if cartnamearray.count==0{
            let emptycart = self.storyboard?.instantiateViewController (withIdentifier: "EmptycartViewController") as! EmptycartViewController
            
            self.navigationController?.pushViewController(emptycart, animated: false)
        }else{
            let mybag = self.storyboard?.instantiateViewController (withIdentifier: "MyBagViewController") as! MyBagViewController
            
            self.navigationController?.pushViewController(mybag, animated: false)
        }
    }
    @objc func backaction(){
        
        navigationController?.popViewController(animated: true)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchproductlistingCollectionViewCell", for: indexPath) as! searchproductlistingCollectionViewCell
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if width == 375{
            return CGSize (width: (width-40)/2, height: 240)
        }else{
            return CGSize (width:(width-40)/2, height: 240)
            
            
        }
        
    }
//     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 253
//    }
     public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
//        let productdetails = self.storyboard?.instantiateViewController (withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
//        
//        self.navigationController?.pushViewController(productdetails, animated: true)
//        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func serviceproductlistbycategory(){
        let url1 = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/hello/CategoriesProduct/33urorbe0o4fqu8jwpu25jbtowi8p5uc/23"
        Alamofire.request(url1, method: .get, parameters: nil).validate {request, response, data in
            return .success
            }
            .responseJSON { response in
                print("------ccc------")
                self.parseData(response.data!)
                print(response.data as Any)
        }
    }
    
    func parseData(_ data : Data){
        do{
            let readableJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            print("readableJSON : \(readableJSON)")
            let test = Mapper<productlisting>().mapArray(JSONArray: readableJSON as! [[String : Any]])
            print("test",test as Any)
            for item in test{
                let products = item.products
                //                let title = item.title
                //                print("title",title)
                print("products",products as Any)
               
              //  let name=testdict["name"] as! NSString
                //print("name",name)
                //sliderimagearray.append(image as String)
                
                //let testarray=Array(testdict.keys)
                //                print("array",testarray)
                //                let index=testdict["22"]as! NSDictionary
                //                print("index",index)
                //for value in 0...testarray.count-1{
                //                    let name=testdict[testarray[5]]as! NSDictionary
                //let sampletest=testdict![testarray[value]]as! NSDictionary
                //                    print("sampletest result:",sampletest)
                //print("**********************")
                //let image=sampletest["image"] as! NSString
                // print("image",image)
                //let subcat = sampletest["subCategories"]
                //                    print("subcat:",subcat)
                //                    if subcat != nil{
                //                        subdict = subcat as! [String : AnyObject]
                //                        let subarray=Array(subdict!.keys)
                //                        for value in 0...subarray.count-1{
                //                            //                    let name=testdict[testarray[5]]as! NSDictionary
                //                            let sub=subdict![subarray[value]]as! NSDictionary
                //                            //                    print("sampletest result:",sampletest)
                //                            print("$$$$$$$$$$$$$$$$$$$$$$$$")
                //                            let subname=sub["name"] as! NSString
                //                            print("subname",subname)
                //
                //                        }
                //
                //                    }
                
                
                
            }
            //                let name1=name["name"] as! NSString
            //                print("name1",name1)
        }
            
            //            for (key,value) in testdict{
            //            print("\(key) -> \(value)")
            //            }
            
            
        catch{
            print(error)
        }
    }
    
    
//    func serviceproductlisting(){
//        let urlstring = "https://www.cheshirecheesecompany.co.uk//rest/V1/hello/CategoriesProduct/33urorbe0o4fqu8jwpu25jbtowi8p5uc/23"
//        guard let url = URL(string: urlstring) else {
//            return
//        }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            guard let data = data else {return}
//            do{
//                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
//                for item in json{
//                    let value : [String:Any] = item as! [String : Any]
//                    let product = value["products"] as! NSArray
//                    for value in product{
//                    let productdata = Products(productdata: value as! [String : Any])
//                    let price = productdata.price
//                    let entity_id = productdata.entity_id
//                    
//                    print("price:",price)
//                    print("entity_id:",entity_id)
//                    //print("alttext:",alttext)
//                    }
//                }
//            }
//            catch{
//                print("Error in parsing")
//            }
//            //self.collectionviewsliderimage.reloadData()
//            }.resume()
//        
//    }
//
//    
    

}
