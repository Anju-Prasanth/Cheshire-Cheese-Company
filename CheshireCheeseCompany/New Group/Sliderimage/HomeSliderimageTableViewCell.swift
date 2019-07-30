 //
//  HomeSliderimageTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 07/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import MBProgressHUD

 
 struct Bannerslider {
    let title : String
    let image : String
    //let alttext: String
    init(bannersliderdata :[String:Any]) {
        title = bannersliderdata["title"] as? String ?? ""
        image = bannersliderdata["image"] as? String ?? ""
    }
 }


class HomeSliderimageTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   

    @IBOutlet weak var pagecontroller: UIPageControl!
    @IBOutlet weak var collectionviewsliderimage: UICollectionView!
    var cell=sliderimageCollectionViewCell()
    var array=[UIImage]()
    var height:Int=0
    var width:Int=0
    var testdict:[String:AnyObject]!
    var sliderimagearray=[String]()
    var hud:MBProgressHUD=MBProgressHUD()
    var timer=Timer()
    var counter=0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionviewsliderimage.delegate=self
        collectionviewsliderimage.dataSource=self
        width=Int(UIScreen.main.bounds.size.width)
        array=[#imageLiteral(resourceName: "image2"),#imageLiteral(resourceName: "image3"),#imageLiteral(resourceName: "image2")]
           self.collectionviewsliderimage.register(UINib(nibName: "sliderimageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sliderimageCollectionViewCell")
      // servicesliderimages()
       urlsessionsliderservice()
       
        pagecontroller.currentPage=0
        DispatchQueue.main.async {
            self.timer=Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeimage), userInfo: nil, repeats: true)
            
        }
       
    }
    @objc func changeimage(){
        if sliderimagearray.count>1{
        if counter < sliderimagearray.count{
            let index=IndexPath.init(item: counter,section: 0)
            self.collectionviewsliderimage.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pagecontroller.currentPage=counter
            counter+=1
            
        }else{
            counter=0
            let index=IndexPath.init(item: counter,section: 0)
            self.collectionviewsliderimage.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
             pagecontroller.currentPage=counter
            counter=1
        }
        }else{
            
        }
        
    }
   
            
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pagecontroller.numberOfPages=sliderimagearray.count
        return sliderimagearray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderimageCollectionViewCell", for: indexPath) as! sliderimageCollectionViewCell
        print("sliderimagearray",sliderimagearray)
        //cell.imageviewslider.image=array[indexPath.row]
        let url = URL(string:sliderimagearray[indexPath.row])
        cell.imageviewslider.kf.indicatorType = .activity
        cell.imageviewslider.kf.setImage(with: url)
        cell.imageviewslider.contentMode = .scaleToFill
        pagecontroller.currentPage=indexPath.row
       
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }

   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        pagecontroller?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        pagecontroller?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
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
        
            return CGSize (width: width, height: 235)
            
            
        }
    func servicesliderimages(){
        let url1 = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/hello/name/33urorbe0o4fqu8jwpu25jbtowi8p5uc"
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
            let test = Mapper<responsetest>().mapArray(JSONArray: readableJSON as! [[String : Any]])
            print("test",test as Any)
            for item in test{
                let bannerslider = item.bannerslider
                //                let title = item.title
                //                print("title",title)
                print("bannerslider",bannerslider!  as NSDictionary)
                testdict = bannerslider
                let image=testdict["image"] as! NSString
                print("image",image)
                sliderimagearray.append(image as String)
                
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
        self.collectionviewsliderimage.reloadData()
    }
    
//
    func urlsessionsliderservice(){
        self.showhud()
        let urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/hello/name/33urorbe0o4fqu8jwpu25jbtowi8p5uc"
        guard let url = URL(string: urlstring) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let banner = value["bannerslider"]
                    let bannersliderdata = Bannerslider(bannersliderdata: banner as! [String : Any])
                    let title = bannersliderdata.title
                    let image = bannersliderdata.image
                    //let alttext = bannersliderdata.alttext
                    self.sliderimagearray.append(image)
                    print("title:",title)
                    print("image:",image)
                    //print("alttext:",alttext)
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true)
                        self.collectionviewsliderimage.reloadData()
                    }
                }
            }
            catch{
                print("Error in parsing")
            }
            
            }.resume()

    }
    func showhud(){
        hud = MBProgressHUD.showAdded(to: collectionviewsliderimage, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
