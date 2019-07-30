//
//  ProductImageTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 11/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Cosmos
import MBProgressHUD
import  Kingfisher

struct productimageinfo {
    let image : String
    init(productimagedata :[String:Any]) {
        image = productimagedata["image"] as? String ?? ""
    }
}

class ProductImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblprice: UILabel!
    
    @IBOutlet weak var lblqty: UILabel!
    
    @IBOutlet weak var viewqntyproductimage: UIView!
    @IBOutlet weak var ratingview: CosmosView!
    
    @IBOutlet weak var imageviewproduct: UIImageView!
    @IBOutlet weak var btnwritereview: UIButton!
    @IBOutlet weak var txtfldquantity: UITextField!
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var pagecontrol: UIPageControl!
    @IBOutlet weak var collectionviewproductimage: UICollectionView!
    var cell=ProductimageCollectionViewCell()
    @IBOutlet weak var lblquantity: UILabel!
    @IBOutlet weak var btnplus: UIButton!
    @IBOutlet weak var btnminus: UIButton!
    @IBOutlet weak var lblprdctdescrption: UILabel!
    var height:Int=0
    var width:Int=0
    var hud:MBProgressHUD=MBProgressHUD()
    
    @IBOutlet weak var labeldescrptionheight: NSLayoutConstraint!
    
    @IBOutlet weak var btnreadmore: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let myColor = UIColor.lightGray
//        txtfldquantity.layer.borderColor = myColor.cgColor
//        txtfldquantity.layer.borderWidth = 1.0
       
//        collectionviewproductimage.delegate=self
//        collectionviewproductimage.dataSource=self
        height = Int(UIScreen.main.bounds.size.height)
        width=Int(UIScreen.main.bounds.size.width)
        print("width",Int(UIScreen.main.bounds.size.width))
//        self.collectionviewproductimage.register(UINib(nibName: "ProductimageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductimageCollectionViewCell")
//        
        
        
    }
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductimageCollectionViewCell", for: indexPath) as! ProductimageCollectionViewCell
//        return cell
//    }
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//////    {
//////
//////        //        if height >= 1024{
//////        //            return CGSize(width:((collectionviewshopbycategory.frame.width-40)/3),height:320)
//////        //        }
//////        //        else if height == 568{
//////        //            return CGSize(width:((collectionviewshopbycategory.frame.width-15)/2) ,height:160)
//////        //        }
//////        //        else{
//////        //            //            return CGSize(width:145,height:200)
//////        //            return CGSize(width:((collectionviewshopbycategory.frame.width-15)/2) ,height:200)
//////        //        }
//        if width == 375{
//            return CGSize (width: collectionviewproductimage.frame.width-5, height: 262)
//        }else{
//            return CGSize (width: collectionviewproductimage.frame.width-20, height: 270)
//
//
//        }
//    }
//

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
