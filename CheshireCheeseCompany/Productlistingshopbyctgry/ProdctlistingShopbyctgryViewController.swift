//
//  ProdctlistingShopbyctgryViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 28/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD
import WARangeSlider

struct Products{
    let price : String
    let entity_id : String
    let name : String
    let image : String
    let sku : String
    init(productdata :[String:Any]) {
        price = productdata["price"] as? String ?? ""
        entity_id = productdata["entity_id"] as? String ?? ""
        name = productdata["name"] as? String ?? ""
        image = productdata["image"] as? String ?? ""
        sku = productdata["sku"] as? String ?? ""
    }
}
struct Searchresult{
    let price : String
    let entity_id : String
    let name : String
    let image : String
    let sku : String
    init(searchresultdata :[String:Any]) {
        price = searchresultdata["price"] as? String ?? ""
        entity_id = searchresultdata["entity_id"] as? String ?? ""
        name = searchresultdata["name"] as? String ?? ""
        image = searchresultdata["image"] as? String ?? ""
        sku = searchresultdata["sku"] as? String ?? ""
    }
}


class ProdctlistingShopbyctgryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    var id:Int!
    @IBOutlet weak var filterviewheight: NSLayoutConstraint!
    var childid1:Int!
    @IBOutlet weak var viewfilter: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
 
    @IBOutlet weak var btnapply: UIButton!
    @IBOutlet weak var lblmaxprice: UILabel!
    @IBOutlet weak var lblminprice: UILabel!
    @IBOutlet weak var viewrange: UIView!
    @IBOutlet weak var noproductsview: UIView!
    @IBOutlet weak var filterbutton: UIButton!
    
    @IBOutlet weak var prdctshopbyctgrycollectionview: UICollectionView!
    @IBOutlet weak var lblproductname: UILabel!
    @IBOutlet weak var viewlabelproductname: UIView!
    var header: UIImageView!
    @IBOutlet weak var lblnoproductfound: UILabel!
    var navigationBar:UINavigationBar!
    var cell=prdctlistinghopbyctgrycollectionviewcell()
    @IBOutlet weak var lblproductlstngshpbyctgry: UILabel!
    var width:Int=0
    var testdict:[String:AnyObject]!
    var prodctnamearray=[String]()
    var pricearray=[Float]()
    var intpricearray=[Int]()
    var skuarray=[String]()
    var maxvalue=String()
    var lowprice=Int()
    var categoryname=String()
    var filterid:Int!
    var filterflag=Int()
    var idafterfilter=String()
    var productimagearray=[String]()
    var hud:MBProgressHUD=MBProgressHUD()
    var image=String()
    let cartbtn=SSBadgeButton()
    var cartnamearray=[String]()
    var firstname:String!
    
    var upperprice=String()
    var lowerprice=Int()
    let rangeSlider1 = RangeSlider(frame: CGRect.zero)
    let rangeSlider2 = RangeSlider(frame: CGRect.zero)
    var searchflag=Int()
    var keyword=String()
    var btnsearch=UIBarButtonItem()
    
    @IBOutlet weak var viewlabelproductnameheight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        lblproductname.text=categoryname
//        let logo = UIImage(named: "logo")
//        header = UIImageView(image: logo)
//        header.contentMode = .scaleAspectFit // set imageview's content mode
//        header.frame = CGRect(x:50, y:0, width: 60, height:40)
//        self.navigationController?.navigationBar.addSubview(header)
        noproductsview.isHidden=true
     
        let searchlogoimage = UIImage (named: "icon-1")
        //let cartlogoimage = UIImage (named: "shoppingcart")
        let loginlogoimage = UIImage (named: "icon-3")
         btnsearch = UIBarButtonItem (image: searchlogoimage, style: .plain, target: self, action: #selector(ProdctlistingShopbyctgryViewController.searchaction))
       // let btncart = UIBarButtonItem (image: cartlogoimage, style: .plain, target: self, action: #selector(ProdctlistingShopbyctgryViewController.cartaction))
        let btnlogin = UIBarButtonItem (image: loginlogoimage, style: .plain, target: self, action: #selector(ProdctlistingShopbyctgryViewController.loginaction))
       // navigationItem.setRightBarButtonItems([btnlogin,btncart,btnsearch], animated: true)
        
        cartbtn.addTarget(self, action: #selector(cartaction), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [btnlogin,UIBarButtonItem(customView: cartbtn),btnsearch]
        
        
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        //navigationItem.setRightBarButtonItems([btnlogin,btncart], animated: true)
        width=Int(UIScreen.main.bounds.size.width)
        prdctshopbyctgrycollectionview.delegate=self
        prdctshopbyctgrycollectionview.dataSource=self
        self.prdctshopbyctgrycollectionview.register(UINib(nibName: "prdctlistinghopbyctgrycollectionviewcell", bundle: nil), forCellWithReuseIdentifier: "prdctlistinghopbyctgrycollectionviewcell")
       //viewrange.isHidden=true
       
       // self.filterviewheight.constant=0
        //viewfilter.isHidden=true
        print(UserDefaults.standard.stringArray(forKey: "cartbadge"))
      
        //        let yourBackImage = UIImage(named: "back")
        //        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        //        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        viewrange.isHidden=true
    
        view.addSubview(viewrange)
         let  txtfldcolor1 = UIColor(red: 228 / 255, green: 228 / 255, blue: 228 / 255, alpha: 1.0)
       lblproductlstngshpbyctgry.layer.borderWidth=2
        lblproductlstngshpbyctgry.layer.borderColor=txtfldcolor1.cgColor
        btnapply.layer.cornerRadius=5
       // btnapply.layer.borderWidth=1
        if searchflag==1{
            viewlabelproductnameheight.constant=0
             lblproductname.text=""
            servicesearchbarlisting()
        }else{
        viewlabelproductnameheight.constant=46
         serviceproductlisting()
        }
        
         searchbar.isHidden=true
          self.hideKeyboardWhenTappedAround()
        self.btnsearch.isEnabled=true
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        
        firstname = UserDefaults.standard.value(forKey: "name") as? String
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
        viewrange.isHidden=true
//          self.viewfilter.isHidden=true
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
            keyword = searchbar.text!
            searchbar.text = ""
            viewlabelproductnameheight.constant=0
             lblproductname.text=""
            searchbar.isHidden=true
            self.searchbar.endEditing(true)
            searchflag=1
           servicesearchbarlisting()
            
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
        if cartnamearray.count==0{
            let emptycart = self.storyboard?.instantiateViewController (withIdentifier: "EmptycartViewController") as! EmptycartViewController
            
            self.navigationController?.pushViewController(emptycart, animated: false)
        }else{
            let mybag = self.storyboard?.instantiateViewController (withIdentifier: "MyBagViewController") as! MyBagViewController
            
            self.navigationController?.pushViewController(mybag, animated: false)
        }
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
             return prodctnamearray.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prdctlistinghopbyctgrycollectionviewcell", for: indexPath) as! prdctlistinghopbyctgrycollectionviewcell
        let dbleprice=Double(pricearray[indexPath.row])
        cell.lblproductprice.text="£"+String(format:"%.2f",dbleprice ?? 0)
        //cell.lblproductprice.text = "£"+String(pricearray[indexPath.row])
        cell.lblproductdescriptn.text=prodctnamearray[indexPath.row]
        if image != "NULL"{
        let url = URL(string:productimagearray[indexPath.row])
        cell.imageviewproduct.kf.indicatorType = .activity
        cell.imageviewproduct.kf.setImage(with: url)
        }else{
            cell.imageviewproduct.image=UIImage(named: "jamaican-jerk-sauce-spicy-cheddar-200g-wax")
        }
//        DispatchQueue.main.async {
//            self.hud.hide(animated: true)
//        }
        return cell
        
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if width == 375{
            return CGSize (width: (width-40)/2, height: 237)
        }else{
            return CGSize (width:(width-40)/2, height: 237)
            
            
        }
        
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let productdetails = self.storyboard?.instantiateViewController (withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        productdetails.skuid=skuarray[indexPath.row]
        self.navigationController?.pushViewController(productdetails, animated: true)
        
    }
    func serviceproductlisting(){
        print("serviceproductlisting")
        self.showhud()
        var urlstring:String!
        if id != nil{
         urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/hello/CategoriesProduct/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"+String(id)
            filterid=id
           // else if filterflag == 1{
//            urlstring = "https://www.cheshirecheesecompany.co.uk//rest/V1/hello/CategoriesProduct/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"+idafterfilter
//
//
            
        }else{
            urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/hello/CategoriesProduct/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"+String(childid1)
            filterid=childid1
        }
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
           
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
               
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let product = value["products"] as! NSArray
                    if product.count != 0 {
//                        print("product",product)
                        //self.viewfilter.isHidden=false
                        for value in product{
                            let productdata = Products(productdata: value as! [String : Any])
//                            print("productdata",productdata)
                            let price = Float(productdata.price)
                            let intprice = Int(price ?? 0)
                            let entity_id = productdata.entity_id
                            let name = productdata.name
                            let sku = productdata.sku
                            self.skuarray.append(sku)
                            self.image = productdata.image
                            self.productimagearray.append(self.image)
                           
//                            print("price:",price)
                            if name != nil || name != ""{
                                self.prodctnamearray.append(name)
                                self.pricearray.append(price ?? 0)
                                self.intpricearray.append(intprice)
                                print("entity_id:",entity_id)
                                
                            }
//                            print("pricearray:",self.pricearray)
//                            print("intpricearray:",self.intpricearray)
                            self.lowprice=self.intpricearray.min()!
//                            print("lowprice",self.lowprice)
                            let highprice=self.intpricearray.max()
//                            print("highprice",highprice)
                            if highprice! <= 50 {
                                 self.maxvalue="50"
                            }
                            else if highprice! > 50 && highprice! <= 100 {
                                self.maxvalue="100"
                            }else if highprice! > 100 && highprice! <=  500 {
                                self.maxvalue="500"
                            }else if highprice! > 500 && highprice! <=  1000{
                                self.maxvalue="1000"

                            }else if highprice! > 1000 && highprice! <=  1500{
                                self.maxvalue="1500"
                            }else{
                                 self.maxvalue="5000"
                            }
                           
                        }
//                        print("self.categoryname",self.categoryname)
                        if self.categoryname=="Gift Vouchers"||self.categoryname=="Gift Card & Vouchers"{
                            self.filterviewheight.constant=0
                            self.viewfilter.isHidden=true
                        }else{
                            self.filterviewheight.constant=56
                            //self.viewfilter.isHidden=false
                        }
//                        self.lblproductname.isHidden=false
//                        self.lblproductname.text=self.categoryname
                    }else{
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            self.filterviewheight.constant=0
                            self.prdctshopbyctgrycollectionview.isHidden=true
                            self.noproductsview.isHidden=false
                            self.lblnoproductfound.isHidden=false
                             self.lblproductname.isHidden=true
                             self.lblproductname.text=" "
                            self.viewfilter.isHidden=true
                            self.btnsearch.isEnabled=false
                         self.btnsearch.tintColor = UIColor.clear
                            
                        }
                        
                    }
                    print("finished.........")
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.prdctshopbyctgrycollectionview.reloadData()
                    }
                }
            }
            catch{
                print("Error in parsing")
            }
            
//            self.prdctshopbyctgrycollectionview.reloadData()
           
            }.resume()
        
    }
    
    
    func servicesearchbarlisting(){
        self.showhud()
        var params=[String:AnyObject]()
      
        params = ["token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc" as AnyObject,"keywords" :keyword,"startprice":"","endprice":""] as [String : AnyObject]
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
                         self.skuarray.removeAll()
                        self.productimagearray.removeAll()
                        self.prodctnamearray.removeAll()
                        self.pricearray.removeAll()
                        self.intpricearray.removeAll()
                        
                        for value in searchresult{
                            let searchresultdata = Searchresult(searchresultdata: value as! [String : Any])
                            //                            print("productdata",productdata)
                            let price = Float(searchresultdata.price)
                            let intprice = Int(price ?? 0)
                            let entity_id = searchresultdata.entity_id
                            let name = searchresultdata.name
                            let sku = searchresultdata.sku
                            self.skuarray.append(sku)
                            self.image = searchresultdata.image
                            self.productimagearray.append(self.image)
                            
                            //                            print("price:",price)
                            if name != nil || name != ""{
                                self.prodctnamearray.append(name)
                                self.pricearray.append(price ?? 0)
                                self.intpricearray.append(intprice)
                                print("entity_id:",entity_id)
                                
                            }
                            //                            print("pricearray:",self.pricearray)
                            //                            print("intpricearray:",self.intpricearray)
                            self.lowprice=self.intpricearray.min()!
                            //                            print("lowprice",self.lowprice)
                            let highprice=self.intpricearray.max()
                            //                            print("highprice",highprice)
                            if highprice! <= 50 {
                                self.maxvalue="50"
                            }
                            else if highprice! > 50 && highprice! <= 100 {
                                self.maxvalue="100"
                            }else if highprice! > 100 && highprice! <=  500 {
                                self.maxvalue="500"
                            }else if highprice! > 500 && highprice! <=  1000{
                                self.maxvalue="1000"
                                
                            }else if highprice! > 1000 && highprice! <=  1500{
                                self.maxvalue="1500"
                            }else{
                                self.maxvalue="5000"
                            }
                            
                        }
                        //                        print("self.categoryname",self.categoryname)
//                        if self.categoryname=="Gift Vouchers"||self.categoryname=="Gift Card & Vouchers"{
//                            self.filterviewheight.constant=0
//                            self.viewfilter.isHidden=true
//                        }else{
//                            self.filterviewheight.constant=47
//                            self.viewfilter.isHidden=false
//                        }
                        //                        self.lblproductname.isHidden=false
                        //                        self.lblproductname.text=self.categoryname
                    }else{
                        DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            self.filterviewheight.constant=0
                            self.prdctshopbyctgrycollectionview.isHidden=true
                            self.noproductsview.isHidden=false
                            self.lblnoproductfound.isHidden=false
                            self.lblproductname.isHidden=true
                            self.lblproductname.text=" "
                            self.viewfilter.isHidden=true
                            self.btnsearch.isEnabled=false
                            self.btnsearch.tintColor = UIColor.clear
                        }
                        
                    }
                   
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                         print("finished.........")
                        self.prdctshopbyctgrycollectionview.reloadData()
                        
                    }
                }
            }
            catch{
                print("Error in parsing")
            }
            }
            
            
            }.resume()
        
    }
    
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 30.0
        let width = viewrange.bounds.width - 2.0 * margin
        rangeSlider1.frame = CGRect(x: margin, y: margin + topLayoutGuide.length + 10,
                                    width: width, height: 15.0)
        //rangeSlider2.frame = CGRect(x: margin + 20, y: 5 * margin + topLayoutGuide.length + 100,width: width - 40, height: 40)
    }
    
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        lblminprice.text="£"+String(rangeSlider1.lowerValue)
        lblmaxprice.text="£"+String(rangeSlider1.upperValue)
        print("Range slider value changed: (\(rangeSlider.lowerValue) , \(rangeSlider.upperValue))")

    }

    
    @IBAction func btnapplyaction(_ sender: Any) {
        let filteredproducts = self.storyboard?.instantiateViewController (withIdentifier: "FilteredProductsViewController") as! FilteredProductsViewController
        filteredproducts.startprice=String(rangeSlider1.lowerValue)
        filteredproducts.endprice=String(rangeSlider1.upperValue)
        if searchflag==1{
            filteredproducts.filteredprdctname=""
            filteredproducts.serachflagforfilter=1
            filteredproducts.keyword=keyword
        }else{
        filteredproducts.filteredprdctname=categoryname
        filteredproducts.filtercategoryid=String(filterid)
        }
    self.navigationController?.pushViewController(filteredproducts,animated: false)


    }
    func rangeslider(){
        rangeSlider1.lowerValue=lowerprice
                rangeSlider1.minimumValue=lowerprice
        rangeSlider1.maximumValue=Int(maxvalue)!
                rangeSlider1.upperValue=Int(maxvalue)!
         rangeSlider1.addTarget(self, action: #selector(ProdctlistingShopbyctgryViewController.rangeSliderValueChanged(_:)), for: .valueChanged)
    }
    
    @IBAction func filterbtnactn(_ sender: Any) {
        if  (viewrange.isHidden==true){
            viewrange.isHidden=false
             let txtfldcolor = UIColor(red: 225 / 255, green: 227 / 255, blue: 230 / 255, alpha: 1.0)
           viewrange.layer.cornerRadius=5
            viewrange.layer.borderWidth=1
            viewrange.layer.borderColor=txtfldcolor.cgColor
            self.lblminprice.text =
                "£"+String(lowprice)
            self.lblmaxprice.text="£"+String(maxvalue)
             viewrange.addSubview(rangeSlider1)
            rangeslider()
        }else{
            viewrange.isHidden=true
           
        }
//       // let filter = self.storyboard?.instantiateViewController (withIdentifier: "FilterpageViewController") as! FilterpageViewController
//        //header.removeFromSuperview()
//        print("maxvalue",maxvalue)
//        self.lblminprice.text=String(lowprice)
//        self.lblmaxprice.text=String(maxvalue)
//        viewrange.addSubview(rangeSlider1)
//        rangeSlider1.lowerValue=lowerprice
//        rangeSlider1.minimumValue=lowerprice
//        rangeSlider1.maximumValue=Int(upperprice)!
//        rangeSlider1.upperValue=Int(upperprice)!
//        lblmaxprice.text="£"+upperprice
//         rangeSlider1.addTarget(self, action: #selector(FilterpageViewController.rangeSliderValueChanged(_:)), for: .valueChanged)
//        
    }
//
    
}
