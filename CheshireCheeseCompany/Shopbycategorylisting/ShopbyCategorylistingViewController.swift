//
//  ShopbyCategorylistingViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 26/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import MBProgressHUD

//struct Parentdetailsdata {
//
//    let name : String
//    let url : String
//    let subCategories :[String:Any]?
//
//
//    init(details: [String:Any]) {
//        name = details["name"] as? String ?? ""
//        url = details["url"] as? String ?? ""
//        subCategories = details["subCategories"] as? [String:Any] ?? ["":""]
//    }
//
//}
//
//struct Childdetailsdata {
//
//    let name : String
//    let url : String
//
//    init(details: [String:Any]) {
//        name = details["name"] as? String ?? ""
//        url = details["url"] as? String ?? ""
//
//    }
//}
//

class ShopbyCategorylistingViewController: UIViewController,ExpandableTableDelegate{
    
    
    
    
    
    func selectedrow(value: AnyObject, parentid: AnyObject, childid: AnyObject) {
        //on selectedrow
        print("value:",value)
        print("parentid:",parentid)
        print("childid:",childid)
        if parentid as! Int == 28 {
            let more = self.storyboard?.instantiateViewController (withIdentifier: "MoreViewController") as! MoreViewController
               more.name=value as! String
            self.navigationController?.pushViewController(more,animated: true)
        }else{
        let productlistingshpbyctgry = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as! ProdctlistingShopbyctgryViewController
                 productlistingshpbyctgry.categoryname=value as! String
                productlistingshpbyctgry.childid1=childid as! Int
               self.navigationController?.pushViewController(productlistingshpbyctgry,animated: true)
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
            let home = self.storyboard?.instantiateViewController (withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(home,animated: true)
        }else if name as! String == "Rewards"{
            let more = self.storyboard?.instantiateViewController (withIdentifier: "MoreViewController") as! MoreViewController
            more.name=name as! String
            self.navigationController?.pushViewController(more,animated: true)
        }
        else if (nochild_idarray.contains(parentid as! Int)) {
            let productlistingshpbyctgry = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as! ProdctlistingShopbyctgryViewController
            productlistingshpbyctgry.id=parentid as! Int
            productlistingshpbyctgry.categoryname=name as! String
            self.navigationController?.pushViewController(productlistingshpbyctgry,animated: true)
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
    
    
    
//    var childid=Int()
//    var id=Int()
//    var subid=Int()
//    var name=String()
//    var subname=String()
//
//     var testdict:[String:AnyObject]!
//
//    var arraycategoryid=[Int]()
//    var namecategoryarray=[String]()
//    var parentidarray1=[Int]()
//    var childidarray1=[Int]()
//    var subctgryid=[Int]()
//    var subctgryname=[String]()
//
//    var parentChildDict = [String: AnyObject]()
//    var idDict = [String: AnyObject]()
//
//    var nameArray:[Dictionary<String, AnyObject>] = Array()
//    var idArray:[Dictionary<String, AnyObject>] = Array()
//
//     var expandableTable:ExpandableTable!
//    var height:Int=0
//    var parentid:Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        expandableTable = ExpandableTable(nibName: "ExpandableTable", bundle: nil)
        expandableTable.view.frame = CGRect(x: 0, y: 70, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-100)
        expandableTable.delegate = self
        self.view.addSubview(expandableTable.view)
        self.addChildViewController(expandableTable)
        expandableTable.tblExpandable.reloadData()
        serviceshopbycategorylisting()
        
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
     
        expandableTable.view.frame = CGRect(x: 0, y: 70, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-100)
        
        height = Int(UIScreen.main.bounds.size.height)
        
        expandableTable.delegate = self
        self.view.addSubview(expandableTable.view)
        self.addChildViewController(expandableTable)
        expandableTable.tblExpandable.reloadData()
        
    }
//    func closeDropDown() {
//
//    }
//
//    func valueSelected(parentid: AnyObject, childid: AnyObject, name: AnyObject) {
//        print(valueSelected)
//        print("parentid.....",parentid)
//        print("childid",childid)
//        print("name",name)
//
//
//        let productlistingshpbyctgry = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as! ProdctlistingShopbyctgryViewController
//         productlistingshpbyctgry.categoryname=name as! String
//         productlistingshpbyctgry.childid1=childid as! Int
//        self.navigationController?.pushViewController(productlistingshpbyctgry,animated: true)
//
//    }
//
//    func parentSelected(parentid: AnyObject) {
//        print("childid",childid)
//         //print("name",name)
//        if childid == 0{
//        let productlistingshpbyctgry = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as! ProdctlistingShopbyctgryViewController
//        productlistingshpbyctgry.id=parentid as! Int
//        productlistingshpbyctgry.categoryname=name as! String
//        self.navigationController?.pushViewController(productlistingshpbyctgry,animated: true)
//        }else{
//
    
//        }
//    }
//
//
//    func selectedcollectioncell(id: AnyObject) {
////        let productlistingshpbyctgry = self.storyboard?.instantiateViewController (withIdentifier: "ProdctlistingShopbyctgryViewController") as! ProdctlistingShopbyctgryViewController
////        productlistingshpbyctgry.childid=id as! Int
////        self.navigationController?.pushViewController(productlistingshpbyctgry,animated: true)
//
//    }
//    func serviceshopbycategorylisting(){
//        let url1 = "https://www.cheshirecheesecompany.co.uk//rest/V1/hello/CategoriesData/33urorbe0o4fqu8jwpu25jbtowi8p5uc"
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
//            //            print("readableJSON : \(readableJSON)")
//            let test = Mapper<Shopctgrylisting>().mapArray(JSONArray: readableJSON as! [[String : Any]])
//            var id=Int()
//            var subid=Int()
//            var name=String()
//            var subname=String()
//
//            //self.parentidarray1.removeAll()
//
//            for item in test{
//                let categories = item.categories
//                testdict = categories
//                print("testdict",testdict)
//                let testarray=Array(testdict.keys)
//                print("name....",name)
//                for (key) in testarray{
//                    print("\(key)")
//                    id=Int(("\(key)"))!
//                    self.parentid=id
//                    self.parentidarray1.append(parentid)
//                    print("parentidarray1",parentidarray1)
//
//                }
//                print("id",id)
//                self.arraycategoryid.append(id)
//                self.nameArray.removeAll()
//                self.idArray.removeAll()
//                self.subctgryid.removeAll()
//                self.subctgryname.removeAll()
//
//                for value in 0...testarray.count-1{
//                    let sampletest=testdict![testarray[value]]as! NSDictionary
//                    print("**********************")
//                    name=(sampletest["name"] as! NSString) as String
//                    print("name1",name)
//
//                    self.namecategoryarray.append(name)
//                    print("namecategoryarray",namecategoryarray)
//                    let subcat = sampletest["subCategories"]
//                    print("subcat",subcat)
//                    if subcat != nil{
//                        let subdict = subcat as! [String : AnyObject]
//                        let subarray=Array(subdict.keys)
//                        self.subctgryid.removeAll()
//
//                        for (key) in subarray{
//                            print("\(key)")
//                            subid=Int(("\(key)"))!
//                            print("subid",subid)
//                            self.subctgryid.append(subid)
//
//                        }
//
//                        self.idDict.updateValue(id as AnyObject,forKey: "parent_id")
//                        self.idDict.updateValue(self.subctgryid as AnyObject,forKey: "child_id")
//                         self.idArray.append(self.idDict)
////                        print("subid",subid)
////                        self.subctgryid.append(subid)
//                        print("subctgryid",subctgryid)
//                        self.subctgryname.removeAll()
//                        print("subctgryname",subctgryname)
//                        for value in 0...subarray.count-1{
//                            let sub=subdict[subarray[value]]as! NSDictionary
//                            print("$$$$$$$$$$$$$$$$$$$$$$$$")
//                            subname=(sub["name"] as! NSString) as String
//                            print("subname",subname)
//                            self.subctgryname.append(subname)
//                            print("subctgryname",subctgryname)
//                        }
//                        self.parentChildDict.updateValue(name as AnyObject,forKey: "parent")
//                        self.parentChildDict.updateValue(self.subctgryname as AnyObject,forKey: "child")
//                        print("parentChildDict",self.parentChildDict)
//                        self.nameArray.append(self.parentChildDict)
//                        print("idArray",self.idArray)
//                        print("nameArray",self.nameArray)
//
//                    }else{
//                        self.subctgryname.removeAll()
//                    self.expandableTable.parentidarray = self.parentidarray1
//                  self.idDict.updateValue(id as AnyObject,forKey: "parent_id")
//                  self.idDict.updateValue(self.subctgryid as AnyObject,forKey: "child_id")
//                  print("idDict",self.idDict)
//
//                    self.parentChildDict.updateValue(name as AnyObject,forKey: "parent")
//                    self.parentChildDict.updateValue(self.subctgryname as AnyObject,forKey: "child")
//                    print("parentChildDict",self.parentChildDict)
//
//                    self.idArray.append(self.idDict)
//                    self.nameArray.append(self.parentChildDict)
//                    print("idArray",self.idArray)
//                    print("nameArray",self.nameArray)
////                        self.idDict.updateValue(id as AnyObject,forKey: "parent_id")
////                        self.idDict.updateValue(self.subctgryid as AnyObject,forKey: "child_id")
////                        self.idArray.append(self.idDict)
//
//                        print("idDict",self.idDict)
//                    }
////                    self.idDict.updateValue(id as AnyObject,forKey: "parent_id")
////                     self.idDict.updateValue(self.subctgryid as AnyObject,forKey: "child_id")
////                    self.idArray.append(self.idDict)
//
//                    print("idDict",self.idDict)
//
//                }
//                }
//
//
//            self.expandableTable.dataSourceForPlainTable = self.idArray
//            self.expandableTable.dataSourceFordiscription = self.nameArray
//
//            self.expandableTable.tblExpandable.reloadData()
//
//        }
//        catch{
//            print(error)
//        }
//
//    }
//
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
            let readableJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
            
            
            for item in readableJSON{
                let categories :[String:Any] = item as! [String : Any]
                let categoriesdata :[String:Any] = categories["categories"] as! [String : Any]
                let parentidarray = Array(categoriesdata.keys)
                //                print("parentidarray:",parentidarray)
                self.nameArray.removeAll()
                self.idArray.removeAll()
                self.arraycategoryid.removeAll()
                for value in parentidarray{
                    let tempvalue: String = value
                    let parentdetails = categoriesdata[tempvalue]
                    let details = Parentdetailsdata(details: parentdetails as! [String : Any])
                    let name = details.name
                
                    let url = details.url
                    self.parentnamearray.append(name)
                    self.parenturlarray.append(url)
                    self.parentidarray.append(tempvalue)
                    let subCategoriesdata = details.subCategories
                    //                    print("subCategoriesdata",subCategoriesdata)
                    let subcategoryidarray = Array(subCategoriesdata!.keys)
                    //                    print("subcategoryidarray",subcategoryidarray)
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
                            self.subcategorynamearray.append(subname)
                            self.subcategoryurlarray.append(suburl)
                            self.subcategoryidarray.append(Int(subvalue)!)
                            
                        }
                        self.arraycategoryid.append(Int(tempvalue)!)
                        
                        self.parentChildDict.updateValue(name as AnyObject,forKey: "parent")
                        
                        self.parentChildDict.updateValue(self.subcategorynamearray as AnyObject,forKey: "child")
                        self.idDict.updateValue(Int(tempvalue) as AnyObject,forKey: "parent_id")
                        self.idDict.updateValue(self.subcategoryidarray as AnyObject,forKey: "child_id")
                        
                        self.idArray.append(self.idDict)
                        self.nameArray.append(self.parentChildDict)
                        
                       
                        print("subcategoryidarray",subcategoryidarray)
                        self.expandableTable.subctgry1=self.subcategoryidarray
                        
                    }
                    else{
                       
                        self.nochild_idarray.append(Int(tempvalue)!)
                        
                       
                        self.arraycategoryid.append(Int(tempvalue)!)
                        self.parentChildDict.updateValue(name as AnyObject,forKey: "parent")
                       
                        
                        self.parentChildDict.updateValue(self.subcategorynamearray as AnyObject,forKey: "child")
                        self.idDict.updateValue(Int(tempvalue) as AnyObject,forKey: "parent_id")
                        self.idDict.updateValue(self.subcategoryidarray as AnyObject,forKey: "child_id")
                        
                        self.idArray.append(self.idDict)
                        self.nameArray.append(self.parentChildDict)
                       
                        
                        print("subcategoryidarray",subcategoryidarray)
                        self.expandableTable.subctgry1=self.subcategoryidarray
//                        print("subctgry1",subctgry1)
                    }
                    
                    self.expandableTable.dataSourceForPlainTable = self.nameArray
                    self.expandableTable.dataSourceForid = self.idArray
                    self.expandableTable.parentidarray = self.arraycategoryid
                    self.expandableTable.parentnamearray1 = self.parentnamearray
                    self.hud.hide(animated: true)
                    self.expandableTable.tblExpandable.reloadData()
                }
            }
        }
        catch{
            print(error)
        }
    }
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    

}
