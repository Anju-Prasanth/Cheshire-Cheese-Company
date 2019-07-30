//
//  ProductDetailsViewController.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 11/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD


struct productInfo {
    let name : String
    let image : String
    let quantity_and_stock_status: String
    let price: String
    let description: String
    let estimated_delivery_text: String
    let meta_description: String
    let qty:Int
    let sku:String
    let meta_title:String
    let entity_id:String
    init(productdetaildata :[String:Any]) {
        name = productdetaildata["name"] as? String ?? ""
        image = productdetaildata["image"] as? String ?? ""
        quantity_and_stock_status = productdetaildata["quantity_and_stock_status"] as? String ?? ""
        price = productdetaildata["price"] as? String ?? ""
        description = productdetaildata["description"] as? String ?? ""
        estimated_delivery_text = productdetaildata["estimated_delivery_text"] as? String ?? ""
         meta_description = productdetaildata["meta_description"] as? String ?? ""
        qty = productdetaildata["qty"] as! Int
        sku = productdetaildata["sku"]  as? String ?? ""
        meta_title = productdetaildata["meta_title"] as? String ?? ""
         entity_id = productdetaildata["entity_id"] as? String ?? ""
    }
}


class ProductDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UISearchBarDelegate{
    
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var btnaddtocart: UIButton!
    @IBOutlet weak var tableviewproductdetails: UITableView!
    
    
    var header: UIImageView!
    var navigationBar:UINavigationBar!
    
    
    var productimage=ProductImageTableViewCell()
    var productdescription=ProductDescriptionTableViewCell()
    var productstock=ProductstockavailableTableViewCell()
    var productreview=ProductReviewsTableViewCell()
    var customerreview=CustomerreviewsTableViewCell()
    var productdetail=ProductdetailTableViewCell()
    var seeallreviews=SeeallreviewsTableViewCell()
    var submitreview=SubmitreviewTableViewCell()
    
    
    var name=String()
    var image=String()
    var quantity=Int()
    var price=String()
    var sku=String()
    
    var valuecartarray=[String]()
    var namearray=[String]()
    var imagearray=[String]()
    var pricearray=[String]()
    var descriptionarray=[String]()
    var metadescriptionarray=[String]()
    var qtyandstckarray=[String]()
    var deliverytextarray=[String]()
    var titlearray=[String]()
    var nicknamearray=[String]()
    var detailarray=[String]()
    var ratingcodearray=[String]()
    var ratingvaluearray=[Double]()
    var datearray=[String]()
     var truedatearray=[String]()
    var ratingcode=String()

    var quantityarray=[Int]()
    var skuid=String()
    var hud:MBProgressHUD=MBProgressHUD()
    
    var btnreadmoreflag=0
    var btndeliveryreadmoreflag=0
    var btndetailsreadmoreflag=0
    var btnreviewreadmoreflag=0
    var btndetailsflag=0
    var btnreviewflag=0
    var btndeliveryflag=0
    
    var cartnamearray=[String]()
    var cartimagearray=[String]()
    var cartqtyarray=[String]()
    var cartpricearray=[String]()
    var cartsubtotalarray=[Double]()
    var cartnewpricearray=[Double]()
    let cartbtn=SSBadgeButton()
    var firstname:String!
    var totalquantityarray=[Int]()
    var skuidarray=[String]()
    var txtfldcolor = UIColor()
     var tempvalue=1
    var placeholderLabel=UILabel()
     var isLabelAtMaxHeight = false
    var  detailLabelAtMaxHeight = false
    var  deliveryLabelAtMaxHeight = false
    var reviewLabelAtMaxHeight = false
    var btnwriteareviewflag=0
    
    var ratingData=String()
    var ratingarray=[[NSDictionary]]()
    var qualityrating=String()
    var ratingrating=String()
    var pricerating=String()
    var valuerating=String()
    var entityid=String()
   // var dictone=[String:Any]()
   // var dicttwo=[String:Any]()
    var dict1=[String:Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
print("btnwriteareviewflag",btnwriteareviewflag)
        searchbar.isHidden=true
        let searchlogoimage = UIImage (named: "icon-1")
       // let cartlogoimage = UIImage (named: "shoppingcart")
        let loginlogoimage = UIImage (named: "icon-3")
        let btnsearch = UIBarButtonItem (image: searchlogoimage, style: .plain, target: self, action: #selector(ProductDetailsViewController.searchaction))
      
        let btnlogin = UIBarButtonItem (image: loginlogoimage, style: .plain, target: self, action: #selector(ProductDetailsViewController.loginaction))
      
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        cartbtn.addTarget(self, action: #selector(cartaction), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [btnlogin,UIBarButtonItem(customView: cartbtn),btnsearch]
   
        
        txtfldcolor = UIColor(red: 228 / 255, green: 228 / 255, blue: 228 / 255, alpha: 1.0)
        
        tableviewproductdetails.register(UINib(nibName: "ProductImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductImageTableViewCell")
        tableviewproductdetails.register(UINib(nibName: "ProductDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDescriptionTableViewCell")
         tableviewproductdetails.register(UINib(nibName: "ProductdetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductdetailTableViewCell")
        
        tableviewproductdetails.register(UINib(nibName: "ProductstockavailableTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductstockavailableTableViewCell")
        tableviewproductdetails.register(UINib(nibName: "CustomerreviewsTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomerreviewsTableViewCell")
        
         tableviewproductdetails.register(UINib(nibName: "ProductReviewsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductReviewsTableViewCell")
        
        
        tableviewproductdetails.register(UINib(nibName: "SeeallreviewsTableViewCell", bundle: nil), forCellReuseIdentifier: "SeeallreviewsTableViewCell")
        tableviewproductdetails.register(UINib(nibName: "SubmitreviewTableViewCell", bundle: nil), forCellReuseIdentifier: "SubmitreviewTableViewCell")
        
        self.hideKeyboardWhenTappedAround()
    
        
        serviceproductinfosku()
        serviceproductreview()

       // test()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        firstname = UserDefaults.standard.value(forKey: "name") as? String
        print("firstname",firstname)
        
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
        
            cartpricearray=UserDefaults.standard.stringArray(forKey: "cartprice") as! [String]
             print("cartpricearray",cartpricearray)
            cartimagearray=UserDefaults.standard.stringArray(forKey: "cartimage") as! [String]
            cartqtyarray=UserDefaults.standard.stringArray(forKey: "cartqty") as! [String]
            cartsubtotalarray=UserDefaults.standard.array(forKey: "totalprice") as! [Double]
            cartnewpricearray=UserDefaults.standard.array(forKey: "newprice") as! [Double]
            totalquantityarray=UserDefaults.standard.array(forKey: "totalquantity") as! [Int]
            skuidarray=UserDefaults.standard.array(forKey: "skuvalue") as! [String]

        print("cartnamearray",cartnamearray)
        print("cartpricearray",cartpricearray)
        print("cartimagearray",cartimagearray)
        print("cartqtyarray",cartqtyarray)
        }
        if (UserDefaults.standard.value(forKey: "entityid")) != nil{
        entityid=UserDefaults.standard.value(forKey: "entityid") as! String
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
        if btnreviewflag==0{
            return 3
        }else if btnwriteareviewflag==1{
            return 4
        }else{
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if btnreviewflag==0{
            if section==0{
                return namearray.count
            }else if section==1{
                return 1
            }else {
                if btndetailsflag==0{
                    return metadescriptionarray.count
                }else if btndeliveryflag==1{
                    return deliverytextarray.count
                }else{
                    return 0
                }
            }
            
        }else {
            if section==0{
                return namearray.count
            }else if section==1{
                return 1
            }else if section==2{
                return 1
                
            }else if section==3{
                if btnwriteareviewflag==1{
                    return 1
                }else{
                if titlearray.count<=2{
                    return titlearray.count
                }else{
                return 2
                }
            }
            }
            else{
                return 1
            }
            
        }
        
    }
        
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//        pagecontroller?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//    }
//
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//
//        pagecontroller?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//    }
//
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("btnwriteareviewflag",btnwriteareviewflag)
        if btnreviewflag==0{
            if indexPath.section==0{
                productimage = (tableView.dequeueReusableCell(withIdentifier: "ProductImageTableViewCell", for: indexPath) as? ProductImageTableViewCell)!
                productimage.Outerview.layer.cornerRadius = 5.0
                productimage.Outerview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                
                productimage.viewqntyproductimage.layer.borderWidth=1
                  productimage.viewqntyproductimage.layer.borderColor=txtfldcolor.cgColor
                
                productimage.lblquantity.text=String(tempvalue)
                productimage.lblname.text=namearray[indexPath.row]
                let url = URL(string:imagearray[indexPath.row])
                productimage.imageviewproduct.kf.indicatorType = .activity
                productimage.imageviewproduct.kf.setImage(with: url)
                productimage.imageviewproduct.contentMode = .scaleToFill
                let dbleprice=Double(pricearray[indexPath.row])
                productimage.lblprice.text="£"+String(format:"%.2f",dbleprice ?? 0)
                productimage.pagecontrol.numberOfPages=imagearray
                    .count
                if ratingvaluearray.count != 0{
                    var sum=0.0
                    for value in ratingvaluearray{
                        sum+=value
                    }
                    let averagerating=Int(sum)/titlearray.count
                    productimage.ratingview.rating=Double(averagerating)
                }
                else{
                    productimage.ratingview.rating=0
                }
                
              
                
                productimage.btnreadmore.tag=indexPath.row
                print("productimage.lblprdctdescrption.text?.count",productimage.lblprdctdescrption.text?.count as Any)
                
                
                productimage.btnreadmore.addTarget(self, action: #selector(btnreadmoreactiom(sender:)), for: .touchUpInside)
                
                productimage.btnwritereview.addTarget(self, action: #selector(btnwritewareviewaction(sender:)), for: .touchUpInside)
                productimage.lblprdctdescrption.text=descriptionarray[indexPath.row]
                
                if btnreadmoreflag==1{
                   
                    //productimage.btnreadmore.isHidden=true.
                }else{
                    
                    if (productimage.lblprdctdescrption.text?.count)! > 157{
                        
                        productimage.btnreadmore.isHidden=false
                        
                        
                        
                        if isLabelAtMaxHeight == true {
                            productimage.lblprdctdescrption.numberOfLines = 0
                            productimage.lblprdctdescrption.lineBreakMode = NSLineBreakMode.byWordWrapping
                        }
                        else {
                            productimage.lblprdctdescrption.numberOfLines = 4
                            productimage.lblprdctdescrption.lineBreakMode = NSLineBreakMode.byWordWrapping
                            
                        }
                    }else{
                        productimage.btnreadmore.isHidden=true
                    }
                }
                
                productimage.btnminus.addTarget(self, action: #selector(btnminustapped(sender:)), for: .touchUpInside)
                productimage.btnplus.addTarget(self, action: #selector(btnplustapped(sender:)), for: .touchUpInside)
                
                return productimage
            }
            else if indexPath.section==1{
                if namearray.count == 0{
                productdescription = (tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionTableViewCell", for: indexPath) as? ProductDescriptionTableViewCell)!
                    productdescription.isHidden=true
                return productdescription
                }else{
                    
                productdescription = (tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionTableViewCell", for: indexPath) as? ProductDescriptionTableViewCell)!
                    productdescription.txtfldouter.layer.borderColor=txtfldcolor.cgColor
                productdescription.txtfldouter.layer.borderWidth=1
               // productdescription.txtfldouter.layer.cornerRadius=2
                
                if btndetailsflag==0{
                    productdescription.btndetails.backgroundColor=UIColor.white
                    
                    
                }else {
                    productdescription.btnreviews.backgroundColor=txtfldcolor
                }

                productdescription.btndetails.addTarget(self, action: #selector(btndetailsactiom(sender:)), for: .touchUpInside)
                productdescription.btndelivery.addTarget(self, action: #selector(btndeliveryactiom(sender:)), for: .touchUpInside)
                productdescription.btnreviews.addTarget(self, action: #selector(btnreviewsactiom(sender:)), for: .touchUpInside)
                //        productdescription.lblproductdetails.text=descriptionarray[indexPath.row]
                return productdescription
                }
            }else{
                if btndetailsflag==0{
                    
                    productdetail = (tableView.dequeueReusableCell(withIdentifier: "ProductdetailTableViewCell", for: indexPath) as? ProductdetailTableViewCell)!
                    productdetail.Outerview.layer.cornerRadius=5
                    productdetail.Outerview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                   productdetail.viewouterproductdetail.layer.borderWidth=1
                    productdetail.viewouterproductdetail.layer.borderColor=txtfldcolor.cgColor
                    
                    
                    
                    let encodedData = metadescriptionarray[indexPath.row].data(using: String.Encoding.utf8)!
                    var attributedString: NSAttributedString
                    
                    do {
                        attributedString = try NSAttributedString(data: encodedData, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
                        let content=attributedString.string
                       productdetail.lbldetail.text=content
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    } catch {
                        print("error")
                    }
                    
                    productdetail.btndetailreadmore.addTarget(self, action: #selector(btndetailreadmore(sender:)), for: .touchUpInside)
                    if btndetailsreadmoreflag==1{
                       // productdetail.btndetailreadmore.isHidden=true
                    }else{
                        
                        if (productdetail.lbldetail.text?.count)! > 157{
                            
                            productdetail.btndetailreadmore.isHidden=false
                            
                            
                            
                            if detailLabelAtMaxHeight == true {
                                productdetail.lbldetail.numberOfLines = 0
                               productdetail.lbldetail.lineBreakMode = NSLineBreakMode.byWordWrapping
                            }
                            else {
                               productdetail.lbldetail.numberOfLines = 4
                               productdetail.lbldetail.lineBreakMode = NSLineBreakMode.byWordWrapping
                                
                            }
                        }else{
                             productdetail.btndetailreadmore.isHidden=true
                        }
                    }
                    return productdetail
                }else{
//                    if btndeliveryflag==1{
                    productstock = (tableView.dequeueReusableCell(withIdentifier: "ProductstockavailableTableViewCell", for: indexPath) as? ProductstockavailableTableViewCell)!
                    productstock.Outerview.layer.cornerRadius=5
                     productstock.Outerview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                    productstock.viewouterproductstock.layer.borderWidth=1
                    productstock.viewouterproductstock.layer.borderColor=txtfldcolor.cgColor
                    
                    
                    //productstock.Outerview.layer.cornerRadius = 5.0
//                  let str = deliverytextarray[indexPath.row]
//
//                    let  str2 = str.replacingOccurrences(of: "<p>", with: "")
//
//                    productstock.lbldscrptn.text=str2
                    let encodedData = deliverytextarray[indexPath.row].data(using: String.Encoding.utf8)!
                    var attributedString: NSAttributedString
                    
                    do {
                        attributedString = try NSAttributedString(data: encodedData, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
                        let content=attributedString.string
                        productstock.lbldscrptn.text=content
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    } catch {
                        print("error")
                    }
                    
                    
                     productstock.btndeliveryreadmore.addTarget(self, action: #selector(btndeliveryreadmoreaction(sender:)), for: .touchUpInside)
                    
                    if btndeliveryreadmoreflag==1{
                       // productstock.btndeliveryreadmore.isHidden=true
                    }else{
                        if (productstock.lbldscrptn.text?.count)! > 400{
                            
                            productstock.btndeliveryreadmore.isHidden=false
                            
                            
                            
                            if deliveryLabelAtMaxHeight == true {
                                productstock.lbldscrptn.numberOfLines = 0
                                productstock.lbldscrptn.lineBreakMode = NSLineBreakMode.byWordWrapping
                            }
                            else {
                                productstock.lbldscrptn.numberOfLines = 6
                                productstock.lbldscrptn.lineBreakMode = NSLineBreakMode.byWordWrapping
                                
                            }
                        }else{
                            productstock.btndeliveryreadmore.isHidden=true
                        }
                    }
                    
                    return productstock
                    
                }
                
            }
            
        }else{
            
            if indexPath.section==0{
                
                productimage = (tableView.dequeueReusableCell(withIdentifier: "ProductImageTableViewCell", for: indexPath) as? ProductImageTableViewCell)!
                productimage.Outerview.layer.cornerRadius = 5.0
                productimage.Outerview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                
                
                productimage.viewqntyproductimage.layer.borderWidth=1
                productimage.viewqntyproductimage.layer.borderColor=txtfldcolor.cgColor
                
               
                 productimage.lblquantity.text=String(tempvalue)
                productimage.lblname.text=namearray[indexPath.row]
                let url = URL(string:imagearray[indexPath.row])
                productimage.imageviewproduct.kf.indicatorType = .activity
                productimage.imageviewproduct.kf.setImage(with: url)
                productimage.imageviewproduct.contentMode = .scaleToFill
                let dbleprice=Double(pricearray[indexPath.row])
                productimage.lblprice.text="£"+String(format:"%.2f",dbleprice ?? 0)
                productimage.pagecontrol.numberOfPages=imagearray
                    .count
                if ratingvaluearray.count != 0{
                    var sum=0.0
                    for value in ratingvaluearray{
                        sum+=value
                    }
                    let averagerating=Int(sum)/titlearray.count
                    productimage.ratingview.rating=Double(averagerating)
                }
                else{
                    productimage.ratingview.rating=0
                }
                
                
            productimage.lblprdctdescrption.text=descriptionarray[indexPath.row]
                
                productimage.btnreadmore.tag=indexPath.row
                print("productimage.lblprdctdescrption.text?.count",productimage.lblprdctdescrption.text?.count as Any)
                productimage.btnwritereview.addTarget(self, action: #selector(btnwritewareviewaction(sender:)), for: .touchUpInside)
                productimage.btnreadmore.addTarget(self, action: #selector(btnreadmoreactiom(sender:)), for: .touchUpInside)
                if btnreviewreadmoreflag==1||btnreadmoreflag==1{
                   // productimage.btnreadmore.isHidden=true
                }else{
                    if (productimage.lblprdctdescrption.text?.count)! > 157{
                        
                        productimage.btnreadmore.isHidden=false
                        
                        
                        
                        if isLabelAtMaxHeight == true {
                            productimage.lblprdctdescrption.numberOfLines = 0
                            productimage.lblprdctdescrption.lineBreakMode = NSLineBreakMode.byWordWrapping
                        }
                        else {
                            productimage.lblprdctdescrption.numberOfLines = 4
                            productimage.lblprdctdescrption.lineBreakMode = NSLineBreakMode.byWordWrapping
                            
                        }
                    }else{
                        productimage.btnreadmore.isHidden=true
                    }
                }
                 productimage.btnminus.addTarget(self, action: #selector(btnminustapped(sender:)), for: .touchUpInside)
                productimage.btnplus.addTarget(self, action: #selector(btnplustapped(sender:)), for: .touchUpInside)
                
                
                return productimage
            }else if indexPath.section==1{
                productdescription = (tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionTableViewCell", for: indexPath) as? ProductDescriptionTableViewCell)!
                
                //let txtfldcolor = UIColor(red: 161 / 255, green: 161 / 255, blue: 161 / 255, alpha: 1.0)
                productdescription.txtfldouter.layer.borderColor=txtfldcolor.cgColor
                productdescription.txtfldouter.layer.borderWidth=1
               
//                }
                productdescription.btndetails.addTarget(self, action: #selector(btndetailsactiom(sender:)), for: .touchUpInside)
                productdescription.btndelivery.addTarget(self, action: #selector(btndeliveryactiom(sender:)), for: .touchUpInside)
                productdescription.btnreviews.addTarget(self, action: #selector(btnreviewsactiom(sender:)), for: .touchUpInside)
                //        productdescription.lblproductdetails.text=descriptionarray[indexPath.row]
                return productdescription
            }else if indexPath.section==2{
                customerreview = (tableView.dequeueReusableCell(withIdentifier: "CustomerreviewsTableViewCell", for: indexPath) as? CustomerreviewsTableViewCell)!
                if titlearray.count==0{
                   customerreview.lblcustomerreviews.text="Write Your Review"
                }else if btnwriteareviewflag==1{
                   customerreview.lblcustomerreviews.text="Write Your Review"
                }
                
                
                else{
                customerreview.lblcustomerreviews.text="Customer Reviews"
                }
                
                 productimage.btnreadmore.addTarget(self, action: #selector(btnreadmoreactiom(sender:)), for: .touchUpInside)
                productimage.btnwritereview.addTarget(self, action: #selector(btnwritewareviewaction(sender:)), for: .touchUpInside)
                if btnreadmoreflag==1{
                    //productimage.btnreadmore.isHidden=true
                }else{
                    
                    if (productimage.lblprdctdescrption.text?.count)! > 157{
                        
                        productimage.btnreadmore.isHidden=false
                        
                        
                        
                        if isLabelAtMaxHeight == true {
                            productimage.lblprdctdescrption.numberOfLines = 0
                            productimage.lblprdctdescrption.lineBreakMode = NSLineBreakMode.byWordWrapping
                        }
                        else {
                            productimage.lblprdctdescrption.numberOfLines = 4
                            productimage.lblprdctdescrption.lineBreakMode = NSLineBreakMode.byWordWrapping
                            
                        }
                    }else{
                        productimage.btnreadmore.isHidden=true
                    }
                }
                return customerreview
            }else if indexPath.section==3{
                if btnwriteareviewflag==1{
                    submitreview=(tableView.dequeueReusableCell(withIdentifier: "SubmitreviewTableViewCell", for: indexPath) as? SubmitreviewTableViewCell)!
                    submitreview.lblproductname.text=namearray[indexPath.row]
                    productimage.btnreadmore.addTarget(self, action: #selector(btnreadmoreactiom(sender:)), for: .touchUpInside)
                    productimage.btnwritereview.addTarget(self, action: #selector(btnwritewareviewaction(sender:)), for: .touchUpInside)
                    if btnreadmoreflag==1{
                        // productimage.btnreadmore.isHidden=true
                    }else{
                        
                        if (productimage.lblprdctdescrption.text?.count)! > 157{
                            
                            productimage.btnreadmore.isHidden=false
                            
                            
                            
                            if isLabelAtMaxHeight == true {
                                productimage.lblprdctdescrption.numberOfLines = 0
                                productimage.lblprdctdescrption.lineBreakMode = NSLineBreakMode.byWordWrapping
                            }
                            else {
                                productimage.lblprdctdescrption.numberOfLines = 4
                                productimage.lblprdctdescrption.lineBreakMode = NSLineBreakMode.byWordWrapping
                                
                            }
                        }else{
                            productimage.btnreadmore.isHidden=true
                        }
                    }
                    
                    submitreview.viewoutersubmitreview.layer.borderWidth=1

                    submitreview.viewoutersubmitreview.layer.borderColor=txtfldcolor.cgColor
                    
                    
                    submitreview.txtviewreview.delegate=self
                    
                    submitreview.txtviewreview.layer.cornerRadius=5
                    submitreview.Outerview.layer.cornerRadius=5
                    submitreview.Outerview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                    
                    submitreview.txtviewreview.layer.borderColor = txtfldcolor.cgColor
                    
                    
                    submitreview.txtviewreview.layer.borderWidth = 1
                    
                    
                    submitreview.txtviewreview.textColor = UIColor.black
                     submitreview.btnsubmit.addTarget(self, action: #selector(btnsubmitreviewaction(sender:)), for: .touchUpInside)
                    
                    return submitreview
                    
                  
                    
                }else{
                productreview=(tableView.dequeueReusableCell(withIdentifier: "ProductReviewsTableViewCell", for: indexPath) as? ProductReviewsTableViewCell)!
                    print("datearray",datearray)
                //productreview.Outerview.layer.cornerRadius=5
                   
                productreview.lbltitle.text=titlearray[indexPath.row]
                    
                productreview.lbldetail.text=detailarray[indexPath.row]
                productreview.btnprdctreviewreadmore.tag=indexPath.row
                    if self.datearray.count != 0{
                        let firstdate = self.datearray[0]
                        let dateFormatter = DateFormatter()
                        
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let dateFromString : NSDate = dateFormatter.date(from: firstdate)! as NSDate
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        let datenew = dateFormatter.string(from: dateFromString as Date)
                         if self.datearray.count > 1 {
                        let seconddate=self.datearray[1]
                        
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let dateFromString1 : NSDate = dateFormatter.date(from: seconddate)! as NSDate
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        let datenew1 = dateFormatter.string(from: dateFromString1 as Date)
                            self.truedatearray.append(datenew1)
                        }
                        
                        
                        
                        self.truedatearray.append(datenew)
                       
                    }else{
                        
                    }
                     productreview.lbldate.text=truedatearray[indexPath.row]
                    
                productreview.lblname.text=nicknamearray[indexPath.row]
                
                
                if ratingcodearray[indexPath.row]=="Quality"{
                    
                    productreview.ratingquality.rating=ratingvaluearray[indexPath.row]
                    
                }else if ratingcodearray[indexPath.row]=="Rating"{
                
            productreview.ratingrtng.rating=ratingvaluearray[indexPath.row]
                    
                }else if ratingcodearray[indexPath.row]=="Price"{
                    
                    productreview.ratingprice.rating=ratingvaluearray[indexPath.row]
                }else if ratingcodearray[indexPath.row]=="Value"{
                    productreview.ratingvalue.rating=ratingvaluearray[indexPath.row]
                }
                else{
                    
                    
                }
                
                // productreview.btnprdctreviewreadmore.addTarget(self, action: #selector(btnprdctreviewreadmoreaction(sender:)), for: .touchUpInside)
//                if btnreadmoreflag==1{
//                    //productreview.btnprdctreviewreadmore.isHidden=true
//                }else{
//
//                    if (productreview.lbldetail.text?.count)! > 160{
//
//                        productreview.btnprdctreviewreadmore.isHidden=false
//
//
//
//                        if reviewLabelAtMaxHeight == true {
//                            productreview.lbldetail.numberOfLines = 0
//                            productreview.lbldetail.lineBreakMode = NSLineBreakMode.byWordWrapping
//                        }
//                        else {
//                            productreview.lbldetail.numberOfLines = 6
//                            productreview.lbldetail.lineBreakMode = NSLineBreakMode.byWordWrapping
//
//                        }
//                    }else{
//                        productreview.btnprdctreviewreadmore.isHidden=true
//                    }
//                }
               // }
                return productreview
                }
                
                
            }else{
                if titlearray.count==0 {
                    submitreview=(tableView.dequeueReusableCell(withIdentifier: "SubmitreviewTableViewCell", for: indexPath) as? SubmitreviewTableViewCell)!
                    if btnwriteareviewflag==1{
                        
                        return submitreview
                    }else{
                    submitreview.lblproductname.text=namearray[indexPath.row]
                    productimage.btnreadmore.addTarget(self, action: #selector(btnreadmoreactiom(sender:)), for: .touchUpInside)
                    productimage.btnwritereview.addTarget(self, action: #selector(btnwritewareviewaction(sender:)), for: .touchUpInside)
                    if btnreadmoreflag==1{
                        // productimage.btnreadmore.isHidden=true
                    }else{
                        
                        if (productimage.lblprdctdescrption.text?.count)! > 157{
                            
                            productimage.btnreadmore.isHidden=false
                            
                            
                            
                            if isLabelAtMaxHeight == true {
                                productimage.lblprdctdescrption.numberOfLines = 0
                                productimage.lblprdctdescrption.lineBreakMode = NSLineBreakMode.byWordWrapping
                            }
                            else {
                                productimage.lblprdctdescrption.numberOfLines = 4
                                productimage.lblprdctdescrption.lineBreakMode = NSLineBreakMode.byWordWrapping
                                
                            }
                        }else{
                            productimage.btnreadmore.isHidden=true
                        }
                    }
                    
                    submitreview.viewoutersubmitreview.layer.borderWidth=1
                    submitreview.viewoutersubmitreview.layer.borderColor=txtfldcolor.cgColor
                        
                        submitreview.btnsubmit.addTarget(self, action: #selector(btnsubmitreviewaction1(sender:)), for: .touchUpInside)
                    
                    
                    submitreview.txtviewreview.delegate=self
                    
                    submitreview.txtviewreview.layer.cornerRadius=5
                    submitreview.Outerview.layer.cornerRadius=5
                    submitreview.Outerview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                    
                    
                    submitreview.txtviewreview.layer.borderColor = txtfldcolor.cgColor
                    
                    
                    submitreview.txtviewreview.layer.borderWidth = 1
                    
                    
                    submitreview.txtviewreview.textColor = UIColor.black
                    
                    return submitreview
                }
                    
                }
                    else{
                
                seeallreviews=(tableView.dequeueReusableCell(withIdentifier: "SeeallreviewsTableViewCell", for: indexPath) as? SeeallreviewsTableViewCell)!
                //seeallreviews.accessoryType = .disclosureIndicator
                seeallreviews.Outerview.layer.cornerRadius=5
                seeallreviews.Outerview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                    
                if titlearray.count==0||btnwriteareviewflag==1{
                    seeallreviews.isHidden=true
                }else if titlearray.count<=2{
                    seeallreviews.isHidden=true
                }else{
                    seeallreviews.isHidden=false
                }
                    
                     productimage.btnreadmore.addTarget(self, action: #selector(btnreadmoreactiom(sender:)), for: .touchUpInside)
                    productimage.btnwritereview.addTarget(self, action: #selector(btnwritewareviewaction(sender:)), for: .touchUpInside)
                    if btnreadmoreflag==1{
                       // productimage.btnreadmore.isHidden=true
                    }else{
                        
                        if (productimage.lblprdctdescrption.text?.count)! > 157{
                            
                            productimage.btnreadmore.isHidden=false
                            
                            
                            
                            if isLabelAtMaxHeight == true {
                                productimage.lblprdctdescrption.numberOfLines = 0
                                productimage.lblprdctdescrption.lineBreakMode = NSLineBreakMode.byWordWrapping
                            }
                            else {
                                productimage.lblprdctdescrption.numberOfLines = 4
                                productimage.lblprdctdescrption.lineBreakMode = NSLineBreakMode.byWordWrapping
                                
                            }
                        }else{
                            productimage.btnreadmore.isHidden=true
                        }
                    }
                    return seeallreviews
                }
                
                
            
            }
        }
        
    }
    
    
    func reviewsubmission(){
          dict1 =  ["1":20,"2":25,"3":30,"4":35]
        if submitreview.ratingqty.rating==5.0{
            dict1.updateValue(20, forKey: "1")
           // qualityrating = "\"1\":20,"
        }else if submitreview.ratingqty.rating==1.0{
             dict1.updateValue(16, forKey: "1")
           // qualityrating = "\"1\":16,"
        }else if submitreview.ratingqty.rating==2.0{
             dict1.updateValue(17, forKey: "1")
           // qualityrating = "\"1\":17,"
        }else if submitreview.ratingqty.rating==3.0{
             dict1.updateValue(18, forKey: "1")
            //qualityrating = "\"1\":18,"
        }else if submitreview.ratingqty.rating==4.0 {
             dict1.updateValue(19, forKey: "1")
           // qualityrating = "\"1\":19,"
        }else{
            // qualityrating = ""
            if let idx = dict1.index(forKey: "1") {
            dict1.remove(at: idx)
            }
        }
    
        print("rating",qualityrating)
       
        if submitreview.ratingrtng.rating==0.0{
            if let idx = dict1.index(forKey: "2") {
                dict1.remove(at: idx)
            }
            //ratingrating = " "
        }else if submitreview.ratingrtng.rating==1.0{
             dict1.updateValue(21, forKey: "2")
           // ratingrating = "\"2\":21,"
        }else if submitreview.ratingrtng.rating==2.0{
             dict1.updateValue(22, forKey: "2")
           // ratingrating = "\"2\":22,"
        }else if submitreview.ratingrtng.rating==3.0{
             dict1.updateValue(23, forKey: "2")
            //ratingrating = "\"2\":23,"
        }else if submitreview.ratingrtng.rating==4.0 {
             dict1.updateValue(24, forKey: "2")
            //ratingrating = "\"2\":24,"
        }else{
             dict1.updateValue(25, forKey: "2")
            //ratingrating = "\"2\":25,"
        }
        
       
        if submitreview.ratingprice.rating==0.0{
            if let idx = dict1.index(forKey: "3") {
                dict1.remove(at: idx)
            }
            //pricerating = " "
        }else if submitreview.ratingprice.rating==1.0{
            dict1.updateValue(26, forKey: "3")
           // pricerating = "\"3\":26,"
        }else if submitreview.ratingprice.rating==2.0{
            dict1.updateValue(27, forKey: "3")
           // pricerating = "\"3\":27,"
        }else if submitreview.ratingprice.rating==3.0{
            dict1.updateValue(28, forKey: "3")
            //pricerating = "\"3\":28,"
        }else if submitreview.ratingprice.rating==4.0 {
            dict1.updateValue(29, forKey: "3")
            //pricerating = "\"3\":29,"
        }else{
            dict1.updateValue(30, forKey: "3")
            //pricerating = "\"3\":30,"
        }
        
       
        if submitreview.ratingvalue.rating==0.0{
            if let idx = dict1.index(forKey: "4") {
                dict1.remove(at: idx)
            }
           // valuerating = " "
        }else if submitreview.ratingvalue.rating==1.0{
            dict1.updateValue(31, forKey: "4")
           // valuerating = "\"4\":31"
        }else if submitreview.ratingvalue.rating==2.0{
            dict1.updateValue(32, forKey: "4")
           // valuerating = "\"4\":32"
        }else if submitreview.ratingvalue.rating==3.0{
            dict1.updateValue(33, forKey: "4")
           // valuerating = "\"4\":33"
        }else if submitreview.ratingvalue.rating==4.0 {
            dict1.updateValue(34, forKey: "4")
           // valuerating = "\"4\":34"
        }else{
            dict1.updateValue(35, forKey: "4")
            //valuerating = "\"4\":35"
        }
       // ratingData = "{"+qualityrating+ratingrating+pricerating+valuerating+"}"
       // dictone.append(ratingData)
       
//    ratingData="{"+qualityrating+ratingrating+pricerating+valuerating+"}"
       

//        if submitreview.ratingqty.rating==0.0{
//
//        ratingData="[{"+ratingrating+","+pricerating+","+valuerating+"}]"
//        }
//        else if submitreview.ratingrtng.rating==0.0{
//            ratingData="[{"+qualityrating+","+pricerating+","+valuerating+"}]"
//        }
//        else if submitreview.ratingprice.rating==0.0{
//            ratingData="[{"+qualityrating+","+ratingrating+","+valuerating+"}]"
//
//        }else {
//            ratingData="[{"+qualityrating+","+ratingrating+","+pricerating+"}]"
//        }
        print(ratingData)
       fieldvalidation()
        
    }
    
   

//        var myarray=[NSDictionary]()
//        //myarray.append
//
//        dictone = ["1":20,"2":30,"3":40,"4":50]
//        print(dictone)
//
//        dictone.updateValue(100 as AnyObject, forKey: "1")
//        print(dictone)
//
//        if let idx = dictone.index(forKey: "2") {
//            dictone.remove(at: idx)
//            print(dictone) // ["baz": 3, "foo": 1]
//        }
//

    
    
    
    func fieldvalidation(){
        print(submitreview.txtviewnickname.text!)
       print(submitreview.txtviewsummary.text!)
         print(submitreview.txtviewreview.text!)
    if submitreview.txtviewnickname.text == ""||submitreview.txtviewsummary.text == ""||submitreview.txtviewreview.text == ""{
    let alert = UIAlertController(title: "Incomplete field", message: "Please complete all the fields", preferredStyle: .alert)
    
    
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    
    self.present(alert, animated: true)
    
    }else{
         servicesubmittreviews()
        }
    }
    
    
    
    
    @objc func btnsubmitreviewaction(sender: UIButton){
         reviewsubmission()
        // test()
        
        
    }
    @objc func btnsubmitreviewaction1(sender: UIButton){
        reviewsubmission()
        // test()
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section==4 && titlearray.count != 0{
        let allreview = self.storyboard?.instantiateViewController (withIdentifier: "AllreviewsViewController") as! AllreviewsViewController
        allreview.skuidreview=skuid
        allreview.nameproduct=namearray[indexPath.row]
        self.navigationController?.pushViewController(allreview, animated: false)
        }else{
            
        }
        
        
    }
     
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if btnreviewflag==0{

            if indexPath.section==0 {
                return UITableViewAutomaticDimension
            }else if indexPath.section==1{
                return 39
            }else {
                if btndetailsflag==0{
                    return UITableViewAutomaticDimension
                }else if btndeliveryflag==1{
                    return UITableViewAutomaticDimension
                }else{
                    return 0
                }
            }
            
        }else {
            if indexPath.section==0{
                return UITableViewAutomaticDimension
            }else if indexPath.section==1{
                return 39
            }else if indexPath.section==2{
                return 44
                
            }else if indexPath.section==3{
                if btnwriteareviewflag==1{
                    return 628
                }else{
                     return UITableViewAutomaticDimension
                }
               
            }
            else{
                
                if titlearray.count==0{
                    if btnwriteareviewflag==1{
                        return 0
                    }else{
                        return 628
                    }
                }else{
                    return 92
                }
                
            }
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if btnreviewflag==0{
            
            if indexPath.section==0 {
                return 575
            }else if indexPath.section==1{
                return 39
            }else {
                if btndetailsflag==0{
                    return 600
                }else if btndeliveryflag==1{
                    return 600
                }else{
                    return 0
                }
            }
            
        }else {
            if indexPath.section==0{
                return 575
            }else if indexPath.section==1{
                return 39
            }else if indexPath.section==2{
                return 44
                
            }else if indexPath.section==3{
                if btnwriteareviewflag==1{
                    return 628
                }else{
                return  UITableViewAutomaticDimension
            }
            }
            else{
                if titlearray.count==0{
                    if btnwriteareviewflag==1{
                        return 0
                    }else{
                        return  628
                    }
                }else{
                    return 92
                }
            }
            
        }
        
        
        
    }
        
        
        
        
//
//        if indexPath.section==0{
//            return 600
//        }
//        else if indexPath.section==1{
//            return 47
//        }
//        else if indexPath.section==2{
//            return 168
//        }else if indexPath.section==3{
//            return 70
//        } else{
//            return 345
//        }
     @objc func btnminustapped(sender: UIButton){
        
        if tempvalue==1{
           tempvalue=1
        }else{
            tempvalue=tempvalue-1
        }
        
        self.tableviewproductdetails.reloadData()
        
        
    }
    @objc func btnplustapped(sender: UIButton){
      
        if Int(productimage.lblquantity.text!)! >= quantityarray[sender.tag]{
            let alert = UIAlertController(title: "", message: "Quantity exceeds the total quantity available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else{
            tempvalue=tempvalue + 1
            
        }
      
        self.tableviewproductdetails.reloadData()
    }
    
    
    
    
    @objc func btnwritewareviewaction(sender: UIButton){
        if firstname == "Hi Guest" || firstname == nil{
            let login = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
            login.checkoutflag=1
            self.navigationController?.pushViewController(login, animated: false)
        }else{
            let indexPath = IndexPath(
                row: tableviewproductdetails.numberOfRows(inSection:  tableviewproductdetails.numberOfSections-1) - 1,
                section: tableviewproductdetails.numberOfSections-1)
            self.tableviewproductdetails.scrollToRow(at: indexPath, at: .bottom, animated: true)
          
           // tableviewproductdetails.scrollToRow(at: IndexPath(row: 0, section: 2), at: .bottom, animated: true)
        btnwriteareviewflag=1
        
         btnreviewflag=1
        tableviewproductdetails.reloadData()
        
    }
    }
   
     @objc func btndetailsactiom(sender: UIButton){
        btndetailsflag=0
        btndeliveryflag=0
        btnreviewflag=0
        let color=UIColor()
        productdescription.btndetails.backgroundColor=UIColor.white
         productdescription.btnreviews.backgroundColor=txtfldcolor
         productdescription.btndelivery.backgroundColor=txtfldcolor
        tableviewproductdetails.reloadData()
        
        
    }
         @objc func btndeliveryactiom(sender: UIButton){
            btndeliveryflag=1
            btndetailsflag=1
            btnreviewflag=0
           // btnreadmoreflag=1
            productdescription.btndetails.backgroundColor=txtfldcolor
        productdescription.btnreviews.backgroundColor=txtfldcolor
        productdescription.btndelivery.backgroundColor=UIColor.white
            tableviewproductdetails.reloadData()
            
    }
             @objc func btnreviewsactiom(sender: UIButton){
                btnreviewflag=1
                btndeliveryflag=0
                btndetailsflag=1
                btnwriteareviewflag=0
               
              //  btnreadmoreflag=1
                productdescription.btndetails.backgroundColor=txtfldcolor
                productdescription.btnreviews.backgroundColor=UIColor.white
                productdescription.btndelivery.backgroundColor=txtfldcolor
                tableviewproductdetails.reloadData()
                
    }
    
    @objc func btnreadmoreactiom(sender: UIButton){
        print("selected....")
//        if sender.isSelected{
//            self.productimage.labeldescrptionheight.constant=75
//
//        }else{
//            sender.isHidden=true
//            btnreadmoreflag=1
//            self.productimage.labeldescrptionheight.isActive=false
//            tableviewproductdetails.reloadData()
//        }
//
        
       
        print(isLabelAtMaxHeight)
       
            if isLabelAtMaxHeight {
                sender.setTitle("....Read more", for: .normal)
                isLabelAtMaxHeight = false

            }
            else {
                sender.setTitle("....Read less", for: .normal)
                isLabelAtMaxHeight = true

            }
         tableviewproductdetails.reloadData()
        }
    
    
    
        
        
    func getLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let lbl:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        lbl.frame.size.width = width
        lbl.font = font
        lbl.numberOfLines = 0
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.text = text
       
        lbl.sizeToFit()
        
        print(lbl.frame.size.height)
        return lbl.frame.size.height
    }
   
    
    
    
    
    
    
    
    
    @objc func btndetailreadmore(sender: UIButton){
        print("selected....")
//        if sender.isSelected{
//            self.productdetail.lbldetailheight.constant=67
//
//        }else{
//            sender.isHidden=true
//            btndetailsreadmoreflag=1
//            self.productdetail.lbldetailheight.isActive=false
//            tableviewproductdetails.reloadData()
//        }
        if detailLabelAtMaxHeight {
            sender.setTitle("....Read more", for: .normal)
            detailLabelAtMaxHeight = false
            
        }
        else {
            sender.setTitle("....Read less", for: .normal)
            detailLabelAtMaxHeight = true
            
        }
        tableviewproductdetails.reloadData()
        
        
        
        
        
        
        
        
        
    }
    @objc func btnprdctreviewreadmoreaction(sender: UIButton){
        print("selected....")
//        if sender.isSelected{
//            self.productreview.lblreviewheight.constant=67
//
//        }else{
//            sender.isHidden=true
//            btnreviewreadmoreflag=1
//            self.productreview.lblreviewheight.isActive=false
//            tableviewproductdetails.reloadData()
//        }
        
        
        
        if reviewLabelAtMaxHeight {
            sender.setTitle("....Read more", for: .normal)
           reviewLabelAtMaxHeight = false
           
        }
        else {
            sender.setTitle("....Read less", for: .normal)
            reviewLabelAtMaxHeight = true
            
        }
        tableviewproductdetails.reloadData()
        
        
    }
    @objc func btndeliveryreadmoreaction(sender: UIButton){
        print("selected....")
//        if sender.isSelected{
//            self.productstock.lblestimateddeliveryheight.constant=67
//
//        }else{
//            sender.isHidden=true
//            btndeliveryreadmoreflag=1
//            self.productstock.lblestimateddeliveryheight.isActive=false
//            tableviewproductdetails.reloadData()
//        }
        if deliveryLabelAtMaxHeight {
            sender.setTitle("....Read more", for: .normal)
            deliveryLabelAtMaxHeight = false
            
        }
        else {
            sender.setTitle("....Read less", for: .normal)
            deliveryLabelAtMaxHeight = true
            
        }
        tableviewproductdetails.reloadData()
        
    }
    
    


    @IBAction func btnaddtocartaction(_ sender: Any) {
        //print(productimage.txtfldquantity.text)
//        if firstname == "Hi Guest" || firstname == nil{
//            let login = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
//            self.navigationController?.pushViewController(login, animated: false)
//        }
//         if (productimage.txtfldquantity.text == "")                                 || (productimage.txtfldquantity.text == nil) || (productimage.txtfldquantity.text == "0"){
//            let alert = UIAlertController(title: "Alert", message: "Enter a valid quantity", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
//                print("Invalidlogin")
//            }))
//            self.present(alert, animated: true)
//        }
//        else{
        
        print("name",name)
       // let cartname=productimage.lblname.text
        if cartnamearray.contains(self.name){
            let alert = UIAlertController(title: "", message: "Item already present in cart", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        else if self.quantity == 0{
            let alert = UIAlertController(title: "", message: "Product you are trying to add is not available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        else{
        self.cartnamearray.append(self.name)
         print("cartnamearray",cartnamearray)
        self.cartqtyarray.append(String(tempvalue))
        print("cartqtyarray",cartqtyarray)
        self.cartpricearray.append(self.price)
        self.totalquantityarray.append(self.quantity)
        self.cartsubtotalarray.append(Double(self.price)!)
        self.cartnewpricearray.append(Double(self.price)!)
        print("cartnewpricearray",cartnewpricearray)
         print("cartsubtotalarray",cartsubtotalarray)
         print("cartpricearray",cartpricearray)
        self.cartimagearray.append(self.image)
         print("cartimagearray",cartimagearray)
        self.skuidarray.append(self.sku)
        UserDefaults.standard.set(skuidarray, forKey: "skuvalue")
        UserDefaults.standard.set(cartnamearray, forKey: "cartbadge")
        UserDefaults.standard.set(cartpricearray, forKey: "cartprice")
        UserDefaults.standard.set(cartimagearray, forKey: "cartimage")
        UserDefaults.standard.set(cartqtyarray, forKey: "cartqty")
        UserDefaults.standard.set(cartsubtotalarray, forKey: "totalprice")
         UserDefaults.standard.set(cartnewpricearray, forKey: "newprice")
        UserDefaults.standard.set("1", forKey: "addedcart")
        UserDefaults.standard.set(totalquantityarray, forKey: "totalquantity")
        cartcount()
        }
        print("skuidarray",skuidarray)
        
    }
    func cartcount(){
        if cartnamearray.count == 0  {
            self.cartbtn.badge = ""
            self.cartbtn.badgeBackgroundColor = UIColor.clear
        }
        else{
            self.cartbtn.badgeBackgroundColor = UIColor.white
            self.cartbtn.badge = String(cartnamearray.count)
            let alert = UIAlertController(title: "", message: "Item added to cart", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    func servicesubmittreviews(){
       
        
        var param=String()
        
        //let dict1 =  ["1":20,"2":25,"3":30,"4":35]
        
        let ratingarray = [dict1]
        print("ratingarray:",ratingarray)
        
        let dict_main = ["token":"33urorbe0o4fqu8jwpu25jbtowi8p5uc","sku": skuid,"nickname": submitreview.txtviewnickname.text!,"title": submitreview.txtviewsummary.text!,"detail": submitreview.txtviewreview.text!,"customer_id":entityid,"storeId": 1,"ratingData":ratingarray] as [String : Any]
        
        print(dict_main)
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: dict_main,
            options: .prettyPrinted
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: .utf8) {
            print("JSON string = \(theJSONText)")
            param=theJSONText
            print("param",param)

        }

        
        
        
//        if let theJSONData = try?  JSONSerialization.data(
//            withJSONObject: dict,
//            options: .prettyPrinted
//            ),
//            let theJSONText = String(data: theJSONData,
//                                     encoding: .utf8) {
//            print("JSON string = \(theJSONText)")
//            let value="["+theJSONText+"]"
//            print("value",value)
//            let data = theJSONText.data(using: .utf8)!
//            do {
//                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments)as? Array<Any>
//                {
//                    print(jsonArray)
//                     parameters = ["sku":skuid,"nickname":submitreview.txtviewnickname.text!,"title":submitreview.txtviewsummary.text!, "token":"33urorbe0o4fqu8jwpu25jbtowi8p5uc","detail": submitreview.txtviewreview.text!,"ratingData":jsonArray                                                                                                                                                                     ,"customer_id":entityid,"storeId":"1"] as [String : Any]
//                } else {
//                    print("bad json")
//                }
//            } catch let error as NSError {
//                print(error)
//            }
//
//        }
//        print("parameters",theJSONText)
//
        guard let url=URL(string :"https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/addReviewsReting")else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: dict_main, options:.prettyPrinted) else {
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
                    let jsonsignup = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                    
                    print("jsonsignup",jsonsignup)
                    for item in jsonsignup{
                        let value : [String:Any] = item as! [String : Any]
                        if(value["status"] != nil){
                            let status = value["status"]as! Int
                        print("status",status)
                        let message = value["message"]as! String
                   
                        if status==1{
                            let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                                
                                
                               // { action in
                                
//                                let home = self.storyboard?.instantiateViewController (withIdentifier: "HomeViewController") as! HomeViewController
//                                self.navigationController?.pushViewController(home, animated: false)
                            
                           // }))
                            
                            self.present(alert, animated: true)
                        }else{
                            let alert = UIAlertController(title: "", message: message , preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                            self.present(alert, animated: true)
                        }
                        
                        }
                else{
                        //let message=jsonsignup.value(forKey: "message") as! String
                        let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        
                    }
                
                    }
                    DispatchQueue.main.async {
                        self.submitreview.txtviewreview.text=""
                         self.submitreview.txtviewsummary.text=""
                         self.submitreview.txtviewnickname.text=""
                        self.submitreview.ratingqty.rating=0.0
                        self.submitreview.ratingrtng.rating=0.0
                        self.submitreview.ratingprice.rating=0.0
                        self.submitreview.ratingvalue.rating=0.0
                    }
        }
                catch{
                    
                    print(error)
                }
            }
            }
            
            .resume()
        
    }
    
    
    func serviceproductreview(){
        var params=[String:AnyObject]()
      
        params = ["token" :"33urorbe0o4fqu8jwpu25jbtowi8p5uc" as  AnyObject,"sku":skuid as AnyObject]
        print("stateparams:",params)
        
        guard let url=URL(string :"https://cheshirecheesecompany.co.uk/draft2/rest/V1/capi/reviews")else{return}
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
                    let jsonsignup = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                    print("jsonsignupreview",jsonsignup)
                    for item in jsonsignup{
                    let value : [String:Any] = item as! [String : Any]
                    let sku = value["sku"]
                        print("value",value)
                        let reviews=value["reviews"] as! NSArray
                        print("reviews",reviews)
                        for item in reviews{
                        let value : [String:Any] = item as! [String : Any]
                            let title=value["title"]
                            var detail=value["detail"]
                            let nickname=value["nickname"]
                            let date=value["created_at"]
                            print("title",title)
                           
                            self.titlearray.append(title as! String)
                            self.detailarray.append(detail as! String)
                            self.nicknamearray.append(nickname as! String)
                           
                            
                            self.datearray.append(date as! String)
                            print("datearray",self.datearray)
                            
                            
                            let ratingvotes=value["rating_votes"] as! NSArray
                            print("ratingvotes",ratingvotes)
                            for item in ratingvotes{
                                let value : [String:Any] = item as! [String : Any]
                                self.ratingcode=value["rating_code"] as! String
                                let ratingvalue=value["value"] as! String
                                print("ratingcode",self.ratingcode)
                                self.ratingcodearray.append(self.ratingcode)
                                self.ratingvaluearray.append(Double(ratingvalue)!)
                            }
                        }
                       
                }
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.tableviewproductdetails.reloadData()
                    }
                }
            catch{
                print("Error in parsing")
            }
        }
            }.resume()
    }

    
    func serviceproductinfosku(){
        print("skuid",skuid)
        self.showhud()
        let urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/productInfo/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"+skuid
        guard let url = URL(string: urlstring) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
               
                self.pricearray.removeAll()
                self.namearray.removeAll()
                self.imagearray.removeAll()
                self.descriptionarray.removeAll()
                self.qtyandstckarray.removeAll()
                self.deliverytextarray.removeAll()
                self.quantityarray.removeAll()
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let details = value["productInfo"]
                    let productdetaildata = productInfo(productdetaildata: details as! [String : Any])
                    self.name = productdetaildata.name
                    self.image = productdetaildata.image
                    let qtyandstck = productdetaildata.quantity_and_stock_status
                    //self.entityid=productdetaildata.entity_id
                    let deliverytext = productdetaildata.estimated_delivery_text
                    self.sku=productdetaildata.sku
                    print("deliverytext",deliverytext)
                    self.price=productdetaildata.price
                    let metadescription=productdetaildata.meta_description
                    let description=productdetaildata.description
                    self.metadescriptionarray.append(description)
                    self.quantity=productdetaildata.qty
                    self.pricearray.append(self.price)
                    self.namearray.append(self.name)
                    print("self.namearray",self.namearray)
                    self.imagearray.append(self.image)
                     self.descriptionarray.append(metadescription)
                     self.qtyandstckarray.append(qtyandstck)
                   self.quantityarray.append(self.quantity)
                    print("self.quantityarray",self.quantityarray)
                    if (deliverytext != "" && deliverytext != nil){
                        self.deliverytextarray.append(deliverytext)

                    }else{
                          self.deliverytextarray.append("Delivery details not available")
                    }
                    print("deliverytextarray",self.deliverytextarray.count)
                    print("deliverytext",deliverytext)
                      
                    
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.tableviewproductdetails.reloadData()
                    }
                }
            }
            catch{
                print("Error in parsing")
            }
            
            }.resume()
        
    }
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
//extension ProductDetailsViewController
////where Iterator.Element == [String:AnyObject]
//{
//    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
//        if let arr = dict as? [[String:AnyObject]],
//            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
//            let str = String(data: dat, encoding: String.Encoding.utf8) {
//            return str
//        }
//        return "[]"
//    } }
