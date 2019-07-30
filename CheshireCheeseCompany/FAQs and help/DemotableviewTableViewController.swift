//
//  DemotableviewTableViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 10/06/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import ExpandableTableViewController
import Kingfisher
import MBProgressHUD

struct FAQs{
    let question : String
    let answer : String

    init(faqdata :[String:Any]) {
        question = faqdata["question"] as? String ?? ""
        answer = faqdata["answer"] as? String ?? ""
       
    }
}


enum TableViewRows: Int {
    case text = 0, total, list
}

class DemotableviewTableViewController: ExpandableTableViewController, ExpandableTableViewDelegate {
    var hud:MBProgressHUD=MBProgressHUD()
    var questionarray=[String]()
    var answerarray=[String]()
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        
        return questionarray.count
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.expandableTableView.expandableDelegate = self
        servicefaqs()
//        let frame3=CGRect(x: 0, y: 0, width: 100, height: 200)
//        let view=UIView(frame:frame3)
        let frame = CGRect(x: 0, y: 0, width: 100, height: 130)
        let headerImageView = UIImageView(frame: frame)
        let image: UIImage = UIImage(named: "banner-1")!
        headerImageView.image = image
        
       // expandableTableView.tableHeaderView = headerImageView
//        let frame1 = CGRect(x: 0, y: 150, width: 100, height: 50)
//        let headerlabel=UILabel(frame: frame1)
//        headerlabel.text="FREQUENTLY ASKED QUESTIONS"
//        view.addSubview(headerImageView)
//        view.addSubview(headerlabel)
        expandableTableView.tableHeaderView = headerImageView
        self.navigationItem.hidesBackButton = true
        let btnsback = backButton(imageName: "back", selector: #selector(back))
        navigationItem.leftBarButtonItem = btnsback
    
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        let lbl = UILabel(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width * 1, height: 50))
        title = "Frequently Asked Questions"
//            let titleAttributes = [
//                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)
//                ]
//                self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: 16.0)
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
        
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> UITableViewCell {
        
        let titleCell = expandableTableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: expandableIndexPath) as! TitleTableViewCell
        titleCell.lblquestion.text=questionarray[expandableIndexPath.row]
       titleCell.accessoryType = .disclosureIndicator
        return titleCell
    }
    
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, estimatedHeightForRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> CGFloat {
         return 35.0
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) {
        if let cell = expandableTableView.cellForRowAtIndexPath(expandableIndexPath) as? CommonTableViewCell{
            if expandableTableView.isCellExpandedAtExpandableIndexPath(expandableIndexPath){
                cell.showSeparator()
            }else{
                cell.hideSeparator()
            }
        }
         expandableTableView.deselectRowAtExpandableIndexPath(expandableIndexPath, animated: true)
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfSubRowsInRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> Int {
        return 1
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, subCellForRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> UITableViewCell {
        
    let descriptionCell = expandableTableView.dequeueReusableCellWithIdentifier("DescriptionCell", forIndexPath: expandableIndexPath) as! DescriptionTableViewCell
        descriptionCell.lblanswers.text=answerarray[expandableIndexPath.row]
        return descriptionCell
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForSubRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, estimatedHeightForSubRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> CGFloat {
       return 114.0
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectSubRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) {
        
    }
    
    func servicefaqs(){
        print("serviceproductlisting")
        self.showhud()
        
            let urlstring = "https://www.cheshirecheesecompany.co.uk/draft2/rest/V1/capi/getFrequentlyAskedQuestions/33urorbe0o4fqu8jwpu25jbtowi8p5uc/"
        
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
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                print("json",json)
                for item in json{
                    let value : [String:Any] = item as! [String : Any]
                    let faq = value["frequently asked questions"] as! NSArray
                    if faq.count != 0 {
                    
                        for value in faq{
                            let productdata = FAQs(faqdata: value as! [String : Any])
                            //                            print("productdata",productdata)
                            let questions = productdata.question
                            let answers = productdata.answer
                            //let delCharSet = NSCharacterSet(charactersIn: "\t")
                          let newanswers=answers.replacingOccurrences(of: "\t", with: "", options: .literal, range: nil)
                         
                            //let newanswer = answers.stringByReplacingOccurrencesOfString("\t", withString: "", options: NSString.CompareOptions.LiteralSearch, range: nil)
                            //print(str2)
                            print("newanswer",newanswers)
                            
                            self.questionarray.append(questions)
                            self.answerarray.append(newanswers)
                        }
                        }else{
                            DispatchQueue.main.async {
                            self.hud.hide(animated: true)
                            }
                            
                        }
                        print("finished.........")
//                        DispatchQueue.main.async {
//                            self.hud.hide(animated: true)
//                             self.expandableTableView.reloadData()
//                    }
                    }
                DispatchQueue.main.async {
                    self.hud.hide(animated: true)
                    self.expandableTableView.reloadData()
                }
                }
                catch{
                    print("Error in parsing")
                }
                
                //            self.prdctshopbyctgrycollectionview.reloadData()
                
            }.resume()
            
        }
    
        func showhud(){
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = MBProgressHUDMode.indeterminate
        }

 
}
