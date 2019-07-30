//
//  AboutusViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 29/05/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import MBProgressHUD

struct aboutus{
    let content : String
    
    init(orderinfo :[String:Any]) {
        content = orderinfo["content"] as? String ?? ""
       
    }
}




class AboutusViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var webView: UIWebView?
    var hud:MBProgressHUD=MBProgressHUD()
    var webcontent:Any?
    @IBOutlet weak var tableviewaboutus: UITableView!
    var cell=AboutusTableViewCell()
    @IBOutlet weak var imageviewaboutus: UIImageView!
    var contentflag=Int()
   // var banner:[String]?
    var imagearray=String()
    var contentarray=String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
        servicenewaboutus()
       // if contentflag==1{
       // serviceaboutus()
//        }else if contentflag==2{
//            servicecheeseandwine()
//            }else{
//                servicewholesale()
//            }
        
        tableviewaboutus.register(UINib(nibName: "AboutusTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutusTableViewCell")
//
//        test()
       
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
        title = "About Us"
       
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: 20.0)
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
    
    func loadHTMLStringImage() -> Void {
        let htmlString = webcontent
        webView?.loadHTMLString(htmlString as! String, baseURL: nil)
    }
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = (tableView.dequeueReusableCell(withIdentifier: "AboutusTableViewCell", for: indexPath) as? AboutusTableViewCell)!
//        let url = URL(string:imagearray)
//        imageviewaboutus.kf.indicatorType = .activity
//        imageviewaboutus.kf.setImage(with: url)
//       imageviewaboutus.contentMode = .scaleToFill
        imageviewaboutus.image=UIImage(named: "aboutus-banner-1")
        let encodedData = contentarray.data(using: String.Encoding.utf8)!
        var attributedString: NSAttributedString
        
        do {
            attributedString = try NSAttributedString(data: encodedData, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
            let content=attributedString.string
            cell.lblaboutuscontent.text=content
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("error")
        }
      
        
        return cell
        
    }
    
    
    func serviceaboutus(){
        self.showhud()
        var urlstring:String!
        
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/getcmscontent/33urorbe0o4fqu8jwpu25jbtowi8p5uc/about_us_mobile"
        
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                print("json",json)
               
                for item in json{
                    let value: [String:Any] = item as! [String:Any]
                    self.webcontent = value["content"] as Any
                    print("webcontent",self.webcontent)
                    
                }
                DispatchQueue.main.async {
                    self.hud.hide(animated: true)
                    self.loadHTMLStringImage()
                }
                
            } catch{
                print("Error in parsing")
            }
            
            
            }.resume()
        
    }
    func servicecheeseandwine(){
        self.showhud()
        var urlstring:String!
        
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/getcmscontent/33urorbe0o4fqu8jwpu25jbtowi8p5uc/cheese-wine-emporium_mobile"
        
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                print("json",json)
                
                for item in json{
                    let value: [String:Any] = item as! [String:Any]
                    self.webcontent = value["content"] as Any
                    print("webcontent",self.webcontent)
                    
                }
                DispatchQueue.main.async {
                    self.hud.hide(animated: true)
                    self.loadHTMLStringImage()
                }
                
            } catch{
                print("Error in parsing")
            }
            
            
            }.resume()
        
    }
    func servicewholesale(){
        self.showhud()
        var urlstring:String!
        
        urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/getcmscontent/33urorbe0o4fqu8jwpu25jbtowi8p5uc/trade-and-wholesale_mobile"
        
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                print("json",json)
                
                for item in json{
                    let value: [String:Any] = item as! [String:Any]
                    self.webcontent = value["content"] as Any
                    print("webcontent",self.webcontent)
                    
                }
                DispatchQueue.main.async {
                    self.hud.hide(animated: true)
                    self.loadHTMLStringImage()
                }
                
            } catch{
                print("Error in parsing")
            }
            
            
            }.resume()
        
    }
    
    func servicenewaboutus(){
        self.showhud()
        var urlstring:String!
        urlstring = "https://cheshirecheesecompany.co.uk/draft2/rest/V1/capi/aboutUsMobile/33urorbe0o4fqu8jwpu25jbtowi8p5uc/200?token=33urorbe0o4fqu8jwpu25jbtowi8p5uc&CMSpage=200"
        
        guard let url = URL(string: urlstring) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                let alert = UIAlertController(title: "Alert", message: "No internet connection", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {action in
                
                return
                }))
                self.present(alert, animated: true)
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray
                if json != nil{
                print("json",json)
                    let banner=json!.value(forKey: "banner") as! NSArray
                    let content=json!.value(forKey: "content") as! NSArray
                print("banner",banner)
                for item in banner{
                    let image=item as! NSArray
                     print("image",image)
                    for value in image{
                        print("value",value)
                        self.imagearray=value as! String
                        print("imagearray",self.imagearray)
                        
                    }
                }
                for item in content{
                   let webcontent=item as! NSArray
                    for value in webcontent{
                        self.contentarray=value as! String
                    }

                }
                DispatchQueue.main.async {
                    self.hud.hide(animated: true)
                  self.tableviewaboutus.reloadData()
                }
                }else{
                    let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            } catch{
                print("Error in parsing")
                
            }
            
            
            }.resume()
       
        
    }
    func test(){
        var params=[String:AnyObject]()
//        email = UserDefaults.standard.value(forKey: "email") as? String
        //params = ["":""] as [String : AnyObject]
//
//
        guard let url=URL(string :"https://wm-service.tk/api/states")else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
//            return
//        }
        //request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("response",response)
            }
            if let data = data {
                print("data",data)
                do {
                    let jsonsignup = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                    
                    print("jsonsignup",jsonsignup)
                }
                    
                catch{
                    
                    print(error)
                }
            }
            }
            
            .resume()
    }
    
    func showhud(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
    }

}
