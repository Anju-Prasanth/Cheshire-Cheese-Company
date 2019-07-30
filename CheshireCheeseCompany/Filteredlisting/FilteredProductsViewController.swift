//
//  FilteredProductsViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 03/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import MBProgressHUD
import Kingfisher

struct Filteredproducts{
    let price : String
    let entity_id : String
    let name : String
    let image :String
    let sku :String
    init(filtereddata :[String:Any]) {
        price = filtereddata["price"] as? String ?? ""
        entity_id = filtereddata["entity_id"] as? String ?? ""
        name = filtereddata["name"] as? String ?? ""
        image = filtereddata["image"] as? String ?? ""
        sku = filtereddata["sku"] as? String ?? ""
    }
}


class FilteredProductsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var lblinfilteredproducts: UILabel!
    @IBOutlet weak var filterviewheight: NSLayoutConstraint!
    @IBOutlet weak var lblnoproducts: UILabel!
    @IBOutlet weak var collectionviewfilteredproducts: UICollectionView!
    @IBOutlet weak var viewnoproductfound: UIView!
    @IBOutlet weak var btnfilter: UIButton!
    @IBOutlet weak var viewfilter: UIView!
    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var viewproductname: UIView!
    var cell=filteredproductsCollectionViewCell()
    var width:Int=0
    var filterflag:Int!
    var filternamearray=[String]()
    var skuidarray=[String]()
    var filterpricearray=[Float]()
    var startprice=String()
    var endprice=String()
    var filteredprdctname=String()
    var filtercategoryid=String()
    var imagearray=[String]()
    var hud:MBProgressHUD=MBProgressHUD()
    var serachflagforfilter=Int()
    var keyword=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
      //lblproductname.text=filteredprdctname
        print("filtercategoryid",filtercategoryid)
       self.collectionviewfilteredproducts.register(UINib(nibName: "filteredproductsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filteredproductsCollectionViewCell")
       width=Int(UIScreen.main.bounds.size.width)
        let  txtfldcolor = UIColor(red: 228 / 255, green: 228 / 255, blue: 228 / 255, alpha: 1.0)
        
        viewnoproductfound.isHidden=true
        lblinfilteredproducts.layer.borderWidth=2
        lblinfilteredproducts.layer.borderColor=txtfldcolor.cgColor
//        backbtn.setBackgroundImage(UIImage(named: "back"), for: .normal)
//        backbtn.frame = CGRect(x: 0, y: 0, width:30, height: 30)
//        backbtn.backgroundColor = UIColor.clear
//        backbtn.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        backbtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
//        backbtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        if serachflagforfilter==1{
            servicefiltersearchbarlisting()
        }else{
         serviceproductlistingpricerange()
        }
          self.hideKeyboardWhenTappedAround()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
        title = filteredprdctname
        
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: 17.0)
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
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return filternamearray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filteredproductsCollectionViewCell", for: indexPath) as! filteredproductsCollectionViewCell
        let dbleprice=Double(filterpricearray[indexPath.row])
        cell.lblproductprice.text="£"+String(format:"%.2f",dbleprice ?? 0)
           // cell.lblproductprice.text = "£"+String(filterpricearray[indexPath.row])
          cell.lblproductdscrptn.text=filternamearray[indexPath.row]
        if serachflagforfilter==1{
            let url = URL(string:imagearray[indexPath.row])
            cell.imageviewproduct.kf.indicatorType = .activity
            cell.imageviewproduct.kf.setImage(with: url)
        }else{
        let imagestring="https://www.cheshirecheesecompany.co.uk/draft2/pub/media/catalog/product"
        let url = URL(string:imagestring+imagearray[indexPath.row])
        cell.imageviewproduct.kf.indicatorType = .activity
        cell.imageviewproduct.kf.setImage(with: url)
           
        }
         return cell
        }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if width == 375{
             print("CGSize",CGSize (width: (width-40)/2, height: 237))
            return CGSize (width: (width-40)/2, height: 237)
          

        }else{
            return CGSize (width:(width-40)/2, height: 237)
        }
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let productdetails = self.storyboard?.instantiateViewController (withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        productdetails.skuid=skuidarray[indexPath.row]
        print("whatsnew.....")
        self.navigationController?.pushViewController(productdetails, animated: true)
    }
    
    func serviceproductlistingpricerange(){
        self.showhud()
        var urlstring:String!
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2//rest/V1/hello/CategoriesProductPrice/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"+filtercategoryid+"/"+startprice+"/"+endprice
        print("urlstring",urlstring)
        
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let filteredproduct = value["filtered_products"] as! NSArray
                    print("product",filteredproduct)
                    if filteredproduct.count != 0 {
                    for value in filteredproduct{
                        let filtereddata = Filteredproducts(filtereddata: value as! [String : Any])
                        print("filtereddata",filtereddata)
                        let price = Float(filtereddata.price)
                        let entityid = filtereddata.entity_id
                        let name = filtereddata.name
                        let image = filtereddata.image
                        let sku=filtereddata.sku
                        self.filternamearray.append(name)
                        self.filterpricearray.append(price ?? 0)
                        self.imagearray.append(image)
                        self.skuidarray.append(sku)
                    }
                    self.filterviewheight.constant=47
                    print("filternamearray",self.filternamearray)
                    print("filterpricearray",self.filterpricearray)
                    }else{
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                        self.filterviewheight.constant=0
                        self.collectionviewfilteredproducts.isHidden=true
                        self.viewnoproductfound.isHidden=false
                        self.lblnoproducts.isHidden=false
                        self.viewfilter.isHidden=true
                        }
                    }
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.collectionviewfilteredproducts.reloadData()
                    }
            
                }
                
            }
               
            catch{
                print("Error in parsing")
            }
            
            }.resume()
        
    }
    func servicefiltersearchbarlisting(){
        self.showhud()
        var params=[String:AnyObject]()
        
        params = ["token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc" as AnyObject,"keywords" :keyword,"startprice":startprice,"endprice":endprice] as [String : AnyObject]
        print("params",params)
        
        guard let url=URL(string :"https://cheshirecheesecompany.co.uk/draft2/rest/V1/capi/Search")else{return}
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
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                    
                    for item in json{
                        let value : [String:Any] = item as! [String : Any]
                        let searchresult = value["Search result"] as! NSArray
                        if searchresult.count != 0 {
                            self.skuidarray.removeAll()
                            self.imagearray.removeAll()
                            self.filternamearray.removeAll()
                            self.filterpricearray.removeAll()
                           
                            
                            for value in searchresult{
                                let searchresultdata = Searchresult(searchresultdata: value as! [String : Any])
                                //                            print("productdata",productdata)
                                let price = Float(searchresultdata.price)
                                let entityid = searchresultdata.entity_id
                                let name = searchresultdata.name
                                let image = searchresultdata.image
                                let sku=searchresultdata.sku
                                self.filternamearray.append(name)
                                self.filterpricearray.append(price ?? 0)
                                self.imagearray.append(image)
                                self.skuidarray.append(sku)
                            }
                            self.filterviewheight.constant=47
                            print("filternamearray",self.filternamearray)
                            print("filterpricearray",self.filterpricearray)
                        }else{
                            DispatchQueue.main.async {
                                self.hud.hide(animated: true)
                                self.filterviewheight.constant=0
                                self.collectionviewfilteredproducts.isHidden=true
                                self.viewnoproductfound.isHidden=false
                                self.lblnoproducts.isHidden=false
                                self.viewfilter.isHidden=true
                            }
                        }
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            self.collectionviewfilteredproducts.reloadData()
                        }
                        
                    }
                    
                }
                    
                catch{
                    print("Error in parsing")
                }
            }
                
            }.resume()
    }
    
    @IBAction func backbtnactn(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: false, completion: nil)

        }
    }
//        let productlistingshpbyctgry = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as! ProdctlistingShopbyctgryViewController
//        let navController = UINavigationController(rootViewController: productlistingshpbyctgry)
//        productlistingshpbyctgry.filterflag=1
//        productlistingshpbyctgry.idafterfilter=filtercategoryid
//        self.present(navController,animated: true,completion: nil)
        
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
        
    
    
    @IBAction func btnfilteractn(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: false, completion: nil)
            
        }
    
}
    
}
    


