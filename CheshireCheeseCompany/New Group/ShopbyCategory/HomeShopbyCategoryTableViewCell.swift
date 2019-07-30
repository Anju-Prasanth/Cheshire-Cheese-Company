//
//  HomeShopbyCategoryTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 07/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD

struct homepagecategores{
    let categoryname : String
    let imageurl : String
    let categoryid : String
    
    init(shopbycategorydata :[String:Any]) {
        imageurl = shopbycategorydata["image url"] as? String ?? ""
        categoryname = shopbycategorydata["category name"] as? String ?? ""
        categoryid = shopbycategorydata["category id"] as? String ?? ""
    }
}
protocol promotioncollectionDelegate{
    
    func selectedcollectioncell(id: AnyObject,categoryid: Int,categoryname: String)
}

class HomeShopbyCategoryTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var delegate: promotioncollectionDelegate!

    @IBOutlet weak var collectionviewshopbycategory: UICollectionView!
    var cell=ShopbyCategoryCollectionViewCell()
    var height:Int=0
    var width:Int=0
    var layout=UICollectionViewFlowLayout()
    var namearray=[String]()
    var imagearray=[String]()
    var categoryidarray=[Int]()
    var hud:MBProgressHUD=MBProgressHUD()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionviewshopbycategory.delegate=self
         collectionviewshopbycategory.dataSource=self
         height = Int(UIScreen.main.bounds.size.height)
         width=Int(UIScreen.main.bounds.size.width)
        print("width",Int(UIScreen.main.bounds.size.width))
        layout.minimumInteritemSpacing=0
        layout.minimumLineSpacing=0
        self.collectionviewshopbycategory.register(UINib(nibName: "ShopbyCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ShopbyCategoryCollectionViewCell")
        serviceshopbycategory()
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return namearray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopbyCategoryCollectionViewCell", for: indexPath) as! ShopbyCategoryCollectionViewCell
        cell.lblcategoryname.text=namearray[indexPath.row]
        let url = URL(string:imagearray[indexPath.row])
        cell.imageviewshopbycategory.kf.indicatorType = .activity
        cell.imageviewshopbycategory.kf.setImage(with: url)
        cell.imageviewshopbycategory.contentMode = .scaleToFill
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
//        if height >= 1024{
//            return CGSize(width:((collectionviewshopbycategory.frame.width-40)/3),height:320)
//        }
//        else if height == 568{
//            return CGSize(width:((collectionviewshopbycategory.frame.width-15)/2) ,height:160)
//        }
//        else{
//            //            return CGSize(width:145,height:200)
//            return CGSize(width:((collectionviewshopbycategory.frame.width-15)/2) ,height:200)
//        }
         if width == 375{
         return CGSize (width: ((collectionviewshopbycategory.frame.width-40)/2), height: 184)
         }else{
            return CGSize (width: ((collectionviewshopbycategory.frame.width-40)/2), height: 184)
        
        
    }
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        //        let id = product_idarray[indexPath.row]
        let id = indexPath.row
        let categoryid=categoryidarray[indexPath.row]
        let categoryname=namearray[indexPath.row]
        
        delegate?.selectedcollectioncell(id: id as AnyObject, categoryid: categoryid  as Int,categoryname: categoryname as String)
        
    }
   
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
//
//        return 0
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func serviceshopbycategory(){
        self.showhud()
        var urlstring:String!
        
        urlstring = "https://cheshirecheesecompany.co.uk/draft2/rest/V1/capi/HomePageCategory/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                print("json",json)
                
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let homeshopbycategory = value["home page categores"] as! NSArray
                    for value in homeshopbycategory{
                        let homeshopbycategorydata = homepagecategores(shopbycategorydata: value as! [String : Any])
                        let name=homeshopbycategorydata.categoryname
                        let image = homeshopbycategorydata.imageurl
                        let categryid=homeshopbycategorydata.categoryid
                        self.namearray.append(name)
                        self.imagearray.append(image)
                        self.categoryidarray.append(Int(categryid)!)
                        print("namearray",self.namearray)
                        print("imagearfray",self.imagearray)
                       
                    }
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                     self.collectionviewshopbycategory.reloadData()
                    }
                }
            }
                
            catch{
                print("Error in parsing")
            }
            
            }.resume()
        
    
}
    func showhud(){
        hud = MBProgressHUD.showAdded(to: collectionviewshopbycategory, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
}
