//
//  HomeWhatsNewTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 07/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD

protocol whatsnewcollectiondelegate{

    func whatsnewcellselection(value: AnyObject,sku: AnyObject)
}


struct newArrivalProduct{
    let entity_id : String
    let sku : String
    let name : String
    let image : String
    let price : String
    let meta_description: String
    init(newarrivaldata :[String:Any]) {
        entity_id = newarrivaldata["entity_id"] as? String ?? ""
        sku = newarrivaldata["sku"] as? String ?? ""
        name = newarrivaldata["name"] as? String ?? ""
        image = newarrivaldata["image"] as? String ?? ""
        price = newarrivaldata["price"] as? String ?? ""
        meta_description = newarrivaldata["meta_description"] as? String ?? ""
    }
}



class HomeWhatsNewTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var whatsnewleftbtn: UIButton!
    @IBOutlet weak var whatsnewrightbtn: UIButton!
    @IBOutlet weak var whatsnewcollectionview: UICollectionView!
     var cell=WhatsnewCollectionViewCell()
    var width:Int=0
   var hud:MBProgressHUD=MBProgressHUD()
    var namearray=[String]()
    var pricerarray=[String]()
    var skuarray=[String]()
    var imagearray=[String]()
    var delegate: whatsnewcollectiondelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        width=Int(UIScreen.main.bounds.size.width)
        whatsnewcollectionview.delegate=self
        whatsnewcollectionview.dataSource=self
         self.whatsnewcollectionview.register(UINib(nibName: "WhatsnewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WhatsnewCollectionViewCell")
       whatsnewleftbtn.isHidden=true
        servicenewarrival()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if namearray.count > 2{
            whatsnewrightbtn.isHidden=false
        }
        return namearray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WhatsnewCollectionViewCell", for: indexPath) as! WhatsnewCollectionViewCell
        cell.lblwhatsnew.text=namearray[indexPath.row]
        let dbleprice=Double(pricerarray[indexPath.row])
        cell.lblprice.text="£"+String(format:"%.2f",dbleprice ?? 0)
        let url = URL(string:imagearray[indexPath.row])
        cell.imageviewwhatsnew.kf.indicatorType = .activity
        cell.imageviewwhatsnew.kf.setImage(with: url)
        cell.imageviewwhatsnew.contentMode = .scaleToFill
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
            return CGSize (width: (whatsnewcollectionview.frame.width-10)/2, height: 223)
        }else{
            return CGSize (width: (whatsnewcollectionview.frame.width-10)/2, height: 223)
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        
        whatsnewrightbtn.isHidden = (indexPath.row == collectionView.numberOfItems(inSection: 0)-1)
        whatsnewleftbtn.isHidden = indexPath.row == 0
        
    }
    
    
    @IBAction func whtsnewlftbtnactn(_ sender: Any) {
        let contentOffset = CGFloat(floor(self.whatsnewcollectionview.contentOffset.x - cell.frame.width - 180))
        self.moveToFrame(contentOffset: contentOffset)
    }
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.whatsnewcollectionview.contentOffset.y ,width : self.whatsnewcollectionview.frame.width,height : self.whatsnewcollectionview.frame.height)
        self.whatsnewcollectionview.scrollRectToVisible(frame, animated: true)
    }
    
    @IBAction func whtsnewrghtbtnactn(_ sender: Any) {
        whatsnewleftbtn.isHidden=false
        //        let collectionBounds = self.itemscollectionview.bounds
        let contentOffset = CGFloat(floor(self.whatsnewcollectionview.contentOffset.x + cell.frame.width + 180))
        self.moveToFrame1(contentOffset: contentOffset)
    }
    func moveToFrame1(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.whatsnewcollectionview.contentOffset.y ,width : self.whatsnewcollectionview.frame.width,height : self.whatsnewcollectionview.frame.height)
        self.whatsnewcollectionview.scrollRectToVisible(frame, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let value = indexPath.row
        let sku=skuarray[indexPath.row]
        delegate?.whatsnewcellselection(value: value as AnyObject,sku: sku as AnyObject)
        print("selected......")
    }
    
    func servicenewarrival(){
        self.showhud()
        var urlstring:String!
        
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/newArrivalProducts/33urorbe0o4fqu8jwpu25jbtowi8p5uc"
        guard let url = URL(string: urlstring) else {
            return
        }

        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let newarrival = value["newArrivalProduct"] as! NSArray
                    for value in newarrival{
                        let newarrivaldata = newArrivalProduct(newarrivaldata: value as! [String : Any])
                        let price=newarrivaldata.price
                        let name = newarrivaldata.name
                        let sku = newarrivaldata.sku
                        let image=newarrivaldata.image
                        self.pricerarray.append(price)
                        self.namearray.append(name)
                        self.skuarray.append(sku)
                        self.imagearray.append(image)
                        print( "imagearray", self.imagearray)
                    }
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.whatsnewcollectionview.reloadData()
                    }
                    }
                }
            
            catch{
                print("Error in parsing")
            }
            
            }.resume()
        
        
    }
    func showhud(){
        hud = MBProgressHUD.showAdded(to: whatsnewcollectionview, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
