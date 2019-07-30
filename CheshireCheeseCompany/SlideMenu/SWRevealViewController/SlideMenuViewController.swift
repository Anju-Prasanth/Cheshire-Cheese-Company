//
//  SlideMenuViewController.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 12/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import MBProgressHUD

struct Parentdetailsdata {
    
    let name : String
    let url : String
    let subCategories :[String:Any]?
    
    
    init(details: [String:Any]) {
        name = details["name"] as? String ?? ""
        url = details["url"] as? String ?? ""
        subCategories = details["subCategories"] as? [String:Any] ?? ["":""]
    }
    
}

struct Childdetailsdata {
    
    let name : String
    let url : String
    
    init(details: [String:Any]) {
        name = details["name"] as? String ?? ""
        url = details["url"] as? String ?? ""
        
    }
}


class SlideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ExpandableTableDelegate {

    @IBOutlet weak var tableviewslideout: UITableView!
    var cell=SlidecellTableViewCell()
    var firstname:String!
    var email:String!
    var viewheight=Int()
    var fullname:String!
    
    
    func selectedrow(value: AnyObject, parentid: AnyObject, childid: AnyObject) {
        //on selectedrow
        print("value:",value)
        print("parentid:",parentid)
        print("childid:",childid)
//        if parentid as! Int == 28 {
//
//            let more = self.storyboard?.instantiateViewController (withIdentifier: "MoreViewController") as!  MoreViewController
//
//
//            let nc = revealViewController().frontViewController as! UINavigationController
//            nc.pushViewController(more, animated: false)
//            more.name=value as! String
//            revealViewController().pushFrontViewController(nc, animated: true)
        
            
//            let more = self.storyboard?.instantiateViewController (withIdentifier: "MoreViewController") as! MoreViewController
//            more.name=value as! String
//            self.navigationController?.pushViewController(more,animated: true)
        if value as! String == "Contact Us"{
        
        let contactus = self.storyboard?.instantiateViewController (withIdentifier: "ContactusViewController") as!  ContactusViewController
        let nc = revealViewController().frontViewController as! UINavigationController
        nc.pushViewController(contactus, animated: false)
        revealViewController().pushFrontViewController(nc, animated: true)
        }else if value as! String == "About Us"{
            let aboutus = self.storyboard?.instantiateViewController (withIdentifier: "AboutusViewController") as!  AboutusViewController
            let nc = revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(aboutus, animated: false)
             aboutus.contentflag=1
            revealViewController().pushFrontViewController(nc, animated: true)
        }
        else if value as! String == "Cheese & Wine Emporium"{
            let aboutus = self.storyboard?.instantiateViewController (withIdentifier: "AboutusViewController") as!  AboutusViewController
            let nc = revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(aboutus, animated: false)
              aboutus.contentflag=2
            revealViewController().pushFrontViewController(nc, animated: true)
        }else if value as! String == "Wholesale & Trade"{
            let aboutus = self.storyboard?.instantiateViewController (withIdentifier: "AboutusViewController") as!  AboutusViewController
            let nc = revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(aboutus, animated: false)
              aboutus.contentflag=3
            revealViewController().pushFrontViewController(nc, animated: true)
        }else if value as! String=="FAQs & Help"{
            let faqs = self.storyboard?.instantiateViewController (withIdentifier: "DemotableviewTableViewController") as!  DemotableviewTableViewController
            let nc = revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(faqs, animated: false)
            
            revealViewController().pushFrontViewController(nc, animated: true)
        }
        
        else{
            let productlistingshpbyctgry = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as!  ProdctlistingShopbyctgryViewController
            let nc = revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(productlistingshpbyctgry, animated: false)
            productlistingshpbyctgry.categoryname=value as! String
            productlistingshpbyctgry.childid1=childid as! Int
            revealViewController().pushFrontViewController(nc, animated: true)

//            let productlistingshpbyctgry = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as! ProdctlistingShopbyctgryViewController
//            productlistingshpbyctgry.categoryname=value as! String
//            productlistingshpbyctgry.childid1=childid as! Int
//            self.navigationController?.pushViewController(productlistingshpbyctgry,animated: true)
        }
    }
    
    
    
    func valueSelected(value: AnyObject, parentid: AnyObject, childid: AnyObject, status: AnyObject, nextdaystatus: AnyObject, offer_id: AnyObject, offer_price: AnyObject) {
        //        print(value)
    }
    
    func menuSelected(name: AnyObject) {
        print(name)
        
    }
    
    func parentSelected(parentid: AnyObject,name: AnyObject) {
        //on parentSelected
        
        print("parentid:",parentid)
        print("name:",name)
        //print("childid",childid)
        if name as! String == "Home"{
            let home = self.storyboard?.instantiateViewController (withIdentifier: "HomeViewController") as!  HomeViewController
            let nc = revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(home, animated: false)
            revealViewController().pushFrontViewController(nc, animated: true)
            
//
//            let home = self.storyboard?.instantiateViewController (withIdentifier: "HomeViewController") as! HomeViewController
//            self.navigationController?.pushViewController(home,animated: true)
        }
        else if name as! String == "Rewards"{
            
            let more = self.storyboard?.instantiateViewController (withIdentifier: "MoreViewController") as!  MoreViewController
            let nc = revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(more, animated: false)
            more.name=name as! String
            revealViewController().pushFrontViewController(nc, animated: true)
            
            
//            let more = self.storyboard?.instantiateViewController (withIdentifier: "MoreViewController") as! MoreViewController
//            more.name=name as! String
//            self.navigationController?.pushViewController(more,animated: true)
        }
    
            
        else if (nochild_idarray.contains(parentid as! Int)) {
            let productlistingshpbyctgry = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as!  ProdctlistingShopbyctgryViewController
            let nc = revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(productlistingshpbyctgry, animated: false)
            productlistingshpbyctgry.id=parentid as! Int
            productlistingshpbyctgry.categoryname=name as! String
            revealViewController().pushFrontViewController(nc, animated: true)
            
            
//            let productlistingshpbyctgry = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as! ProdctlistingShopbyctgryViewController
//            productlistingshpbyctgry.id=parentid as! Int
//            productlistingshpbyctgry.categoryname=name as! String
//            self.navigationController?.pushViewController(productlistingshpbyctgry,animated: true)
        }else{
            
        }
    }
    
    func closeDropDown() {
        
    }
    
    var id=Int()
    var subid=Int()
    var name=String()
    var subname=String()
    
    var testdict:[String:AnyObject]!
    
    var arraysubctgyid=[String]()
    var arraycategoryid=[Int]()
    var namecategoryarray=[String]()
    var parentidarray1=[Int]()
    
    var subctgryid=[Int]()
    var subctgryname=[String]()
    
    var parentChildDict = [String: AnyObject]()
    var idDict = [String: AnyObject]()
    
    var nameArray:[Dictionary<String, AnyObject>] = Array()
    var idArray:[Dictionary<String, AnyObject>] = Array()
    
    var expandableTable:ExpandableTable!
    var height:Int=0
    
    var parentnamearray = [String]()
    var parenturlarray = [String]()
    var parentidarray = [String]()
    
    var subcategorynamearray = [String]()
    var subcategoryurlarray = [String]()
    var subcategoryidarray = [Int]()
    var nochild_idarray=[Int]()
    var hud:MBProgressHUD=MBProgressHUD()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullname=UserDefaults.standard.value(forKey: "fullname") as? String
        firstname = UserDefaults.standard.value(forKey: "name") as? String
        email = UserDefaults.standard.value(forKey: "email") as? String
        print("fullname",fullname)
        //height=Int(UIScreen.main.bounds.size.height)
    
        revealViewController().rearViewRevealWidth = UIScreen.main.bounds.size.width-30
        let nib = UINib(nibName: "SlidecellTableViewCell", bundle: nil)
        self.tableviewslideout.register(nib, forCellReuseIdentifier: "SlidecellTableViewCell")
        expandableTable = ExpandableTable(nibName: "ExpandableTable", bundle: nil)
        expandableTable.view.frame = CGRect(x: 0 , y: 145, width: UIScreen.main.bounds.size.width-55, height: UIScreen.main.bounds.size.height-175)
        
        expandableTable.delegate = self
        self.view.addSubview(expandableTable.view)
        self.addChildViewController(expandableTable)
        expandableTable.tblExpandable.reloadData()
        serviceshopbycategorylisting()
    }
    func serviceshopbycategorylisting(){
        self.showhud()
        let url1 = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/hello/CategoriesData/33urorbe0o4fqu8jwpu25jbtowi8p5uc"
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
            let readableJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray
            if readableJSON != nil{
                
                for item in readableJSON!{
                    let categories :[String:Any] = item as! [String : Any]
                    let categoriesdata :[String:Any] = categories["categories"] as! [String : Any]
                    let parentidarray1 = Array(categoriesdata.keys)
                    //                print("parentidarray:",parentidarray)
                    self.nameArray.removeAll()
                    self.idArray.removeAll()
                    self.arraycategoryid.removeAll()
                    
                    for value in parentidarray1{
                        let tempvalue: String = value
                        let parentdetails = categoriesdata[tempvalue]
                        let details = Parentdetailsdata(details: parentdetails as! [String : Any])
                        let name = details.name
                        let url = details.url
                        
                        print("name",name)
                        
                        if name=="Home"{
                            self.parentnamearray.insert(name,at:0)
                            self.parenturlarray.insert(url,at:0)
                            self.parentidarray.insert(tempvalue,at:0)
                        }else if name=="Rewards"{
                            
                        }else if name=="Shop Everything"{
                            
                        }else if name=="Cheese Club"{
                            
                        }
                        else if name=="More"{
                            //                        self.parentnamearray.insert(name ,at: parentnamearray.endIndex)
                            //                        self.parenturlarray.insert(url ,at: parenturlarray.endIndex)
                            //                        self.parentidarray.insert(tempvalue,at:parentidarray.endIndex)
                            //
                        }
                        else{
                            self.parentnamearray.append(name)
                            self.parenturlarray.append(url)
                            self.parentidarray.append(tempvalue)
                            
                        }
                        
                        let subCategoriesdata = details.subCategories
                        print("subCategoriesdata",subCategoriesdata)
                        let subcategoryidarray = Array(subCategoriesdata!.keys)
                        print("subcategoryidarray",subcategoryidarray)
                        self.subcategorynamearray.removeAll()
                        self.subcategoryurlarray.removeAll()
                        self.subcategoryidarray.removeAll()
                        if subcategoryidarray[0] != "" && subcategoryidarray.count != 1{
                            for value in subcategoryidarray{
                                let subvalue: String = value
                                let subcategorydetails = subCategoriesdata![subvalue]
                                let details = Childdetailsdata(details: subcategorydetails as! [String : Any])
                                let subname = details.name
                                let suburl = details.url
                                print("name",name)
                                if name=="Home"{
                                    self.subcategorynamearray.insert(subname,at:0)
                                    self.subcategoryurlarray.insert(suburl,at:0)
                                    self.subcategoryidarray.insert(Int(subvalue)!,at:0)
                                }else if name=="Rewards"{
                                    
                                }else if name=="Shop Everything"{
                                    
                                }else if name=="Cheese Club"{
                                    
                                }
                                else if name=="More"{
                                    //                                self.subcategorynamearray.insert(subname,at:subcategorynamearray.endIndex)
                                    //                                self.subcategoryurlarray.insert(suburl,at:subcategoryurlarray.endIndex)
                                    //                                //self.subcategoryidarray.insert(Int(subvalue)!,at:subcategoryidarray.endIndex)
                                }
                                else{
                                    self.subcategorynamearray.append(subname)
                                    self.subcategoryurlarray.append(suburl)
                                    self.subcategoryidarray.append(Int(subvalue)!)
                                }
                                print("subcategorynamearray",subcategorynamearray)
                                print("subcategoryidarray",subcategoryidarray)
                            }
                            if name=="Home"{
                                
                                self.arraycategoryid.insert(Int(tempvalue)!,at:0)
                            }
                            else if name=="Rewards"{
                                
                            }else if name=="Shop Everything"{
                                
                            }else if name=="Cheese Club"{
                                
                            }
                            else if name=="More"{
                                //                            self.arraycategoryid.insert(Int(tempvalue)!,at:arraycategoryid.endIndex)
                            }
                            else{
                                
                                self.arraycategoryid.append(Int(tempvalue)!)
                            }
                            
                            
                            self.parentChildDict.updateValue(name as AnyObject,forKey: "parent")
                            
                            self.parentChildDict.updateValue(self.subcategorynamearray as AnyObject,forKey: "child")
                            self.idDict.updateValue(Int(tempvalue) as AnyObject,forKey: "parent_id")
                            self.idDict.updateValue(self.subcategoryidarray as AnyObject,forKey: "child_id")
                            print("parentChildDict",parentChildDict)
                            print("idDict",idDict)
                            if name=="Home"{
                                self.idArray.insert(self.idDict,at:0)
                                self.nameArray.insert(self.parentChildDict,at:0)
                            }
                            else if name=="Rewards"{
                                
                            }else if name=="Shop Everything"{
                                
                            }else if name=="Cheese Club"{
                                
                            }
                            else if name=="More"{
                                //                            self.idArray.insert(self.idDict,at:idArray.endIndex)
                                //                            self.nameArray.insert(self.parentChildDict,at:nameArray.endIndex)
                                //
                            }
                            else{
                                self.idArray.append(self.idDict)
                                self.nameArray.append(self.parentChildDict)
                                
                                
                            }
                            print("idArray",idArray)
                            print("nameArray",nameArray)
                            
                            self.expandableTable.subctgry1=self.subcategoryidarray
                            //                     self.nameArray.append(["parent":"About Us" as AnyObject])
                        }
                        else{
                            if name=="Home"{
                                self.nochild_idarray.insert(Int(tempvalue)!,at:0)
                                self.arraycategoryid.insert(Int(tempvalue)!,at:0)
                            }
                            else if name=="Rewards"{
                                
                            }else if name=="Shop Everything"{
                                
                            }else if name=="Cheese Club"{
                                
                            }
                            else if name=="More"{
                                //                            self.nochild_idarray.insert(Int(tempvalue)!,at:nochild_idarray.endIndex)
                                //                            self.arraycategoryid.insert(Int(tempvalue)!,at:arraycategoryid.endIndex)
                                //
                            }
                                
                            else{
                                self.nochild_idarray.append(Int(tempvalue)!)
                                self.arraycategoryid.append(Int(tempvalue)!)
                                
                            }
                            self.parentChildDict.updateValue(name as AnyObject,forKey: "parent")
                            
                            self.parentChildDict.updateValue(self.subcategorynamearray as AnyObject,forKey: "child")
                            self.idDict.updateValue(Int(tempvalue) as AnyObject,forKey: "parent_id")
                            self.idDict.updateValue(self.subcategoryidarray as AnyObject,forKey: "child_id")
                            print("parentChildDict",parentChildDict)
                            print("idDict",idDict)
                            if name=="Home"{
                                self.idArray.insert(self.idDict,at:0)
                                self.nameArray.insert(self.parentChildDict,at:0)
                            }
                            else if name=="Rewards"{
                                
                            }else if name=="Shop Everything"{
                                
                            }else if name=="Cheese Club"{
                                
                            }
                            else if name=="More"{
                                
                                
                                //                            self.idArray.insert(self.idDict,at:idArray.endIndex)
                                //                            self.nameArray.insert(self.parentChildDict,at:nameArray.endIndex)
                                
                            }
                            else{
                                self.idArray.append(self.idDict)
                                self.nameArray.append(self.parentChildDict)
                                
                                
                            }
                            print("idArray",idArray)
                            print("nameArray",nameArray)
                            
                            
                            self.expandableTable.subctgry1=self.subcategoryidarray
                            //                        print("subctgry1",subctgry1)
                        }
                        // self.nameArray.append(["Cotact Us": AnyObject.self as AnyObject])
                        
                        self.expandableTable.dataSourceForPlainTable = self.nameArray
                        self.expandableTable.dataSourceForid = self.idArray
                        //                    self.expandableTable.dataSourceForPlainTable.append(["Contact us": AnyObject.self as AnyObject])
                        //
                        //                     self.expandableTable.dataSourceForid.append(["0": AnyObject.self as AnyObject])
                        //                    self.expandableTable.dataSourceForPlainTable.append(["About Us": AnyObject.self as AnyObject])
                        //
                        //
                        //                    self.expandableTable.dataSourceForid.append(["0": AnyObject.self as AnyObject])
                        //
                        self.expandableTable.parentidarray = self.arraycategoryid
                        
                        //                    self.expandableTable.parentidarray.append(0)
                        //                     self.expandableTable.parentidarray.append(0)
                        self.expandableTable.parentnamearray1 = self.parentnamearray
                        //                    self.expandableTable.parentnamearray1.append("Contact Us")
                        //                     self.expandableTable.parentnamearray1.append("About Us")
                        self.hud.hide(animated: true)
                        self.expandableTable.tblExpandable.reloadData()
                        
                    }
                    
                    
                    
                    
                    
                    
                    for value in parentidarray1{
                        let tempvalue: String = value
                        let parentdetails = categoriesdata[tempvalue]
                        let details = Parentdetailsdata(details: parentdetails as! [String : Any])
                        let name = details.name
                        let url = details.url
                        
                        print("name",name)
                        
                        if name=="More"{
                            
                            self.parentnamearray.append(name)
                            self.parenturlarray.append(url)
                            self.parentidarray.append(tempvalue)
                            
                        }
                        
                        let subCategoriesdata = details.subCategories
                        print("subCategoriesdata",subCategoriesdata)
                        let subcategoryidarray = Array(subCategoriesdata!.keys)
                        print("subcategoryidarray",subcategoryidarray)
                        self.subcategorynamearray.removeAll()
                        self.subcategoryurlarray.removeAll()
                        self.subcategoryidarray.removeAll()
                        if subcategoryidarray[0] != "" && subcategoryidarray.count != 1{
                            for value in subcategoryidarray{
                                let subvalue: String = value
                                let subcategorydetails = subCategoriesdata![subvalue]
                                let details = Childdetailsdata(details: subcategorydetails as! [String : Any])
                                let subname = details.name
                                let suburl = details.url
                                print("name",name)
                                if name=="More"{
                                    
                                    self.subcategorynamearray.append(subname)
                                    self.subcategoryurlarray.append(suburl)
                                    self.subcategoryidarray.append(Int(subvalue)!)
                                }
                                print("subcategorynamearray",subcategorynamearray)
                                print("subcategoryidarray",subcategoryidarray)
                            }
                            if name=="More"{
                                
                                self.arraycategoryid.append(Int(tempvalue)!)
                            }
                            
                            
                            self.parentChildDict.updateValue(name as AnyObject,forKey: "parent")
                            
                            self.parentChildDict.updateValue(self.subcategorynamearray as AnyObject,forKey: "child")
                            self.idDict.updateValue(Int(tempvalue) as AnyObject,forKey: "parent_id")
                            self.idDict.updateValue(self.subcategoryidarray as AnyObject,forKey: "child_id")
                            print("parentChildDict",parentChildDict)
                            print("idDict",idDict)
                            if name=="More"{
                                
                                self.idArray.append(self.idDict)
                                self.nameArray.append(self.parentChildDict)
                                
                                
                            }
                            print("idArray",idArray)
                            print("nameArray",nameArray)
                            
                            self.expandableTable.subctgry1=self.subcategoryidarray
                            //                     self.nameArray.append(["parent":"About Us" as AnyObject])
                        }
                        else{
                            if name=="More"{
                                
                                self.nochild_idarray.append(Int(tempvalue)!)
                                self.arraycategoryid.append(Int(tempvalue)!)
                                
                            }
                            self.parentChildDict.updateValue(name as AnyObject,forKey: "parent")
                            
                            self.parentChildDict.updateValue(self.subcategorynamearray as AnyObject,forKey: "child")
                            self.idDict.updateValue(Int(tempvalue) as AnyObject,forKey: "parent_id")
                            self.idDict.updateValue(self.subcategoryidarray as AnyObject,forKey: "child_id")
                            print("parentChildDict",parentChildDict)
                            print("idDict",idDict)
                            if name=="More"{
                                
                                
                                
                                self.idArray.append(self.idDict)
                                self.nameArray.append(self.parentChildDict)
                                
                                
                            }
                            print("idArray",idArray)
                            print("nameArray",nameArray)
                            
                            
                            self.expandableTable.subctgry1=self.subcategoryidarray
                            //                        print("subctgry1",subctgry1)
                        }
                        // self.nameArray.append(["Cotact Us": AnyObject.self as AnyObject])
                        
                        self.expandableTable.dataSourceForPlainTable = self.nameArray
                        self.expandableTable.dataSourceForid = self.idArray
                        //                    self.expandableTable.dataSourceForPlainTable.append(["Contact us": AnyObject.self as AnyObject])
                        //
                        //                     self.expandableTable.dataSourceForid.append(["0": AnyObject.self as AnyObject])
                        //                    self.expandableTable.dataSourceForPlainTable.append(["About Us": AnyObject.self as AnyObject])
                        //
                        //
                        //                    self.expandableTable.dataSourceForid.append(["0": AnyObject.self as AnyObject])
                        //
                        self.expandableTable.parentidarray = self.arraycategoryid
                        
                        //                    self.expandableTable.parentidarray.append(0)
                        //                     self.expandableTable.parentidarray.append(0)
                        self.expandableTable.parentnamearray1 = self.parentnamearray
                        //                    self.expandableTable.parentnamearray1.append("Contact Us")
                        //                     self.expandableTable.parentnamearray1.append("About Us")
                        self.hud.hide(animated: true)
                        self.expandableTable.tblExpandable.reloadData()
                        
                    }
                    
                    
                    
                }
            }else{
                    let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
        
        } catch{
            print(error)
        }
    }
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    

    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        fullname=UserDefaults.standard.value(forKey: "fullname") as? String
        firstname = UserDefaults.standard.value(forKey: "name") as? String
        print("firstname",firstname)
         print("fullname",fullname)
        email = UserDefaults.standard.value(forKey: "email") as? String
       self.revealViewController().frontViewController.view.isUserInteractionEnabled = false
    self.revealViewController().view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.tableviewslideout.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        self.revealViewController().frontViewController.view.isUserInteractionEnabled = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableviewslideout.dequeueReusableCell(withIdentifier: "SlidecellTableViewCell", for: indexPath) as!SlidecellTableViewCell
        cell.isUserInteractionEnabled=true
        cell.viewheight.constant=159
        
        viewheight=Int(cell.viewheight.constant)
         cell.btnyourorder.addTarget(self, action: #selector(btnyourorder(sender:)), for: .touchUpInside)
          cell.btnprofile.addTarget(self, action: #selector(btnprofile(sender:)), for: .touchUpInside)
        cell.btnyourwhishlist.addTarget(self, action: #selector(btnyourwhishlist(sender:)), for: .touchUpInside)
         cell.btnshopbycategory.addTarget(self, action: #selector(btnshopbycategory(sender:)), for: .touchUpInside)
         cell.btnhome.addTarget(self, action: #selector(btnhome(sender:)), for: .touchUpInside)
        cell.btnmyaccount.addTarget(self, action: #selector(btnmyaccount(sender:)), for: .touchUpInside)
         cell.btnlogout.addTarget(self, action: #selector(btnlogout(sender:)), for: .touchUpInside)
         print("firstname",firstname)
        print("email",email)
        print("fullname",fullname)
        if UserDefaults.standard.value(forKey: "name") as? String != "Hi Guest" || UserDefaults.standard.value(forKey: "email") as? String != "Login"{
            cell.lblhiguest.text=UserDefaults.standard.value(forKey: "fullname") as? String
            cell.lbllogin.text = UserDefaults.standard.value(forKey: "email") as? String
            cell.btnlogout.isHidden=false
            cell.lbllogout.isHidden=false
         }else{
            cell.lblhiguest.text="Hi Guest"
            cell.lbllogin.text="Login"
             cell.btnlogout.isHidden=true
            cell.lbllogout.isHidden=true
        }
        
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 613
        
    }
    
@objc func btnlogout(sender:UIButton){
    
    //UserDefaults.standard.set("Hi Guest", forKey: "fullname")
    UserDefaults.standard.set("Hi Guest", forKey: "name")
    UserDefaults.standard.set("Login", forKey: "email")
    cell.btnlogout.isHidden=true
     UserDefaults.standard.removeObject(forKey: "skuvalue")
    UserDefaults.standard.removeObject(forKey: "cartbadge")
    UserDefaults.standard.removeObject(forKey: "cartprice")
    UserDefaults.standard.removeObject(forKey:  "cartimage")
    UserDefaults.standard.removeObject(forKey: "cartqty")
    UserDefaults.standard.removeObject(forKey: "totalprice")
    UserDefaults.standard.removeObject(forKey: "newprice")
    UserDefaults.standard.removeObject(forKey: "totalquantity")
    let home = self.storyboard?.instantiateViewController (withIdentifier: "HomeViewController") as! HomeViewController
    let nc = revealViewController().frontViewController as! UINavigationController
    nc.pushViewController(home, animated: false)
    revealViewController().pushFrontViewController(nc, animated: true)
    }
   
    
    @objc func btnmyaccount(sender:UIButton){
        print("firstname",firstname)
        
        if firstname == "Hi Guest"||firstname == nil{
            let login = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
            
            
            let nc = revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(login, animated: false)
            revealViewController().pushFrontViewController(nc, animated: true)
            
        }else{
          
            let account = self.storyboard?.instantiateViewController (withIdentifier: "MyAccountViewController") as! MyAccountViewController
            //header.removeFromSuperview()
            let nc = revealViewController().frontViewController as! UINavigationController
            // nc.present(ordersummary, animated: false)
            nc.pushViewController(account, animated: false)
            revealViewController().pushFrontViewController(nc, animated: true)
        }
       
    }
    @objc func btnyourorder(sender:UIButton){
        if firstname == "Hi Guest" || firstname == nil{
            let login = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
            
            
            let nc = revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(login, animated: false)
            revealViewController().pushFrontViewController(nc, animated: true)
            
        }else{
            let order = self.storyboard?.instantiateViewController (withIdentifier: "OrdersViewController") as! OrdersViewController
            //header.removeFromSuperview()
            let nc = revealViewController().frontViewController as! UINavigationController
            // nc.present(ordersummary, animated: false)
            nc.pushViewController(order, animated: false)
            revealViewController().pushFrontViewController(nc, animated: true)
            
        }
        
    }
    @objc func btnprofile(sender:UIButton){
        print("email:",UserDefaults.standard.value(forKey: "email"))
        print("firstname",firstname)
        if firstname != "Hi Guest"{
            let myaccount = self.storyboard?.instantiateViewController (withIdentifier: "MyAccountViewController") as! MyAccountViewController
            
            let nc = revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(myaccount, animated: false)
            revealViewController().pushFrontViewController(nc, animated: true)
            
        }else{
            
            let signin = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
            //header.removeFromSuperview()
            let nc = revealViewController().frontViewController as! UINavigationController
            //nc.present(ordersummary, animated: false)
            nc.pushViewController(signin, animated: false)
            revealViewController().pushFrontViewController(nc, animated: true)
        }
    }
    @objc func btnhome(sender:UIButton){
        let home = self.storyboard?.instantiateViewController (withIdentifier: "HomeViewController") as! HomeViewController
        //header.removeFromSuperview()
        let nc = revealViewController().frontViewController as! UINavigationController
        //nc.present(ordersummary, animated: false)
        nc.pushViewController(home, animated: false)
        revealViewController().pushFrontViewController(nc, animated: true)
    }
    
    
    @objc func btnyourwhishlist(sender:UIButton){
        if firstname == "Hi Guest"||firstname == nil{
            let login = self.storyboard?.instantiateViewController (withIdentifier: "SigninViewController") as! SigninViewController
            
            let nc = revealViewController().frontViewController as! UINavigationController
            nc.pushViewController(login, animated: false)
            revealViewController().pushFrontViewController(nc, animated: true)
            
        }else{
            let whishlist = self.storyboard?.instantiateViewController (withIdentifier: "MywhishlistViewController") as! MywhishlistViewController
            let nc = revealViewController().frontViewController as! UINavigationController
            //nc.present(ordersummary, animated: false)
            nc.pushViewController(whishlist, animated: false)
            revealViewController().pushFrontViewController(nc, animated: true)
            
        }
      
    }
    
    @objc func btnshopbycategory(sender:UIButton){
//        let shopcategory = self.storyboard?.instantiateViewController (withIdentifier: "ShopbyCategorylistingViewController") as! ShopbyCategorylistingViewController
//        let nc = revealViewController().frontViewController as! UINavigationController
//        //nc.present(ordersummary, animated: false)
//        nc.pushViewController(shopcategory, animated: false)
//        revealViewController().pushFrontViewController(nc, animated: true)
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
