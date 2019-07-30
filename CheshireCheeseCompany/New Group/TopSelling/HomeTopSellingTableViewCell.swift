//
//  HomeTopSellingTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 07/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD
protocol topsellingcollectionviewdelegate{
    
    func topselling(value: AnyObject,productid: Int,categoryname: String)
}

struct bestSellerProducts{
    let product_name : String
    let product_id : String
    let product_price : String
    let image : String
    init(bestsellingdata :[String:Any]) {
        product_price = bestsellingdata["product_price"] as? String ?? ""
        product_id = bestsellingdata["product_id"] as? String ?? ""
        product_name = bestsellingdata["product_name"] as? String ?? ""
        image = bestsellingdata["image"] as? String ?? ""
    }
}

class HomeTopSellingTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var topsellinglftbtn: UIButton!
    @IBOutlet weak var topsellingrghtbtn: UIButton!
    @IBOutlet weak var topsellingcollectionview: UICollectionView!
     var cell=TopSellingCollectionViewCell()
    var width:Int=0
     var hud:MBProgressHUD=MBProgressHUD()
    var namearray=[String]()
    var pricerarray=[String]()
    var productidarray=[String]()
    var imagearray=[String]()
    var delegate: topsellingcollectionviewdelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        width=Int(UIScreen.main.bounds.size.width)
        topsellingcollectionview.delegate=self
        topsellingcollectionview.dataSource=self
        self.topsellingcollectionview.register(UINib(nibName: "TopSellingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopSellingCollectionViewCell")
        topsellinglftbtn.isHidden=true
        servicebestsellingproducts()
    }
    
    
    @IBAction func topsellingrghtbtnactn(_ sender: Any) {
        topsellinglftbtn.isHidden=false
        //        let collectionBounds = self.itemscollectionview.bounds
        let contentOffset = CGFloat(floor(self.topsellingcollectionview.contentOffset.x + cell.frame.width + 180))
        self.moveToFrame1(contentOffset: contentOffset)
    }
    func moveToFrame1(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.topsellingcollectionview.contentOffset.y ,width : self.topsellingcollectionview.frame.width,height : self.topsellingcollectionview.frame.height)
        self.topsellingcollectionview.scrollRectToVisible(frame, animated: true)
    }
    
    
    
    
    @IBAction func topsellinglftbtnactn(_ sender: Any) {
        let contentOffset = CGFloat(floor(self.topsellingcollectionview.contentOffset.x - cell.frame.width - 180))
        self.moveToFrame(contentOffset: contentOffset)
    }
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.topsellingcollectionview.contentOffset.y ,width : self.topsellingcollectionview.frame.width,height : self.topsellingcollectionview.frame.height)
        self.topsellingcollectionview.scrollRectToVisible(frame, animated: true)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if namearray.count > 2{
            topsellingrghtbtn.isHidden=false
        }
        return namearray.count
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
        topsellingrghtbtn.isHidden = (indexPath.row == collectionView.numberOfItems(inSection: 0)-1)
        topsellinglftbtn.isHidden = indexPath.row == 0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopSellingCollectionViewCell", for: indexPath) as! TopSellingCollectionViewCell
        cell.lbltopselling.text=namearray[indexPath.row]
        let dbleprice=Double(pricerarray[indexPath.row])
        cell.lblprice.text="£"+String(format:"%.2f",dbleprice ?? 0)
        let url = URL(string:imagearray[indexPath.row])
        cell.imageviewtopselling.kf.indicatorType = .activity
        cell.imageviewtopselling.kf.setImage(with: url)
        cell.imageviewtopselling.contentMode = .scaleToFill
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
            return CGSize (width:(topsellingcollectionview.frame.width-10)/2, height: 227)
        }else{
            return CGSize (width: (topsellingcollectionview.frame.width-10)/2, height: 227)
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let value = indexPath.row
        let productid=Int(productidarray[indexPath.row])
        let categoryname=namearray[indexPath.row]
        delegate?.topselling(value: value as AnyObject,productid: productid as! Int,categoryname: categoryname as String)
        print("selected......")
    }
    func servicebestsellingproducts(){
        self.showhud()
        var urlstring:String!
        
            urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/bestSellerProducts/33urorbe0o4fqu8jwpu25jbtowi8p5uc"
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let bestselling = value["bestSellerProducts"] as! NSArray
                        for value in bestselling{
                            let bestsellingdata = bestSellerProducts(bestsellingdata: value as! [String : Any])
                            let price=bestsellingdata.product_price
                            let name = bestsellingdata.product_name
                            let productid = bestsellingdata.product_id
                            let image=bestsellingdata.image
                            self.pricerarray.append(price)
                            self.namearray.append(name)
                            self.productidarray.append(productid)
                            self.imagearray.append(image)
                        }
                            DispatchQueue.main.async {
                                self.hud.hide(animated: true)
                                self.topsellingcollectionview.reloadData()
                    }
                }
            }
                    catch{
                        print("Error in parsing")
                    }
                    
                }.resume()
                
            
    }
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: topsellingcollectionview, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
