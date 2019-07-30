//
//  ExpandedCell.swift
//  ExpandableTable
//
//  Created by Aman Aggarwal on 3/23/17.
//  Copyright © 2017 iostutorialjunction.com. All rights reserved.
//

import UIKit




protocol ExpandedCellDelegate {
//    func valueSelected(value: AnyObject)
    func valueSelected(value: AnyObject,parentid: AnyObject,childid: AnyObject, status: AnyObject,nextdaystatus: AnyObject, offer_id: AnyObject, offer_price: AnyObject)
    func closeDropDown()
    func menuSelected(name: AnyObject)
    func selectedrow(value: AnyObject,parentid: AnyObject,childid: AnyObject)
}

class ExpandedCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblExpandedOptions: UITableView!
    var dataSourceArray:[String] = Array()
    var discriptionArray:[String] = Array()
    var priceArray:[String] = Array()
    var imageArray:[String] = Array()
    var statusArray:[String] = Array()
    var stock_statusArray:[String] = Array()
    var nextday_statusArray:[String] = Array()
    var offer_idArray:[String] = Array()
    var offer_priceArray:[String] = Array()
    var idarray:[Int] = Array()
    var delegate: ExpandedCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tblExpandedOptions.register(UINib(nibName: "CustomExpandedCell", bundle: nil), forCellReuseIdentifier: "category")
        tblExpandedOptions.register(UINib(nibName: "SubcategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SubcategoryTableViewCell")
        
        tblExpandedOptions.delegate = self
        tblExpandedOptions.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Array: ",dataSourceArray)
        print("Arraycount: ",dataSourceArray.count)
        return dataSourceArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "category") as! CustomExpandedCell
            cell.lblTitle?.text = String(dataSourceArray[indexPath.row])
            cell.lblTitle?.font = UIFont.systemFont(ofSize: 17.0)
            cell.layoutLC.constant = 15
            cell.separatorInset.left = 15
            cell.selectionStyle = .none
            return cell
            
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubcategoryTableViewCell") as! SubcategoryTableViewCell
            cell.selectionStyle = .none
            cell.lblsubctgry.text = dataSourceArray[indexPath.row]
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return CGFloat(44.0)
        }
        else{
            return CGFloat(44.0)
        }
    }
    
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            //we tap on same row who is expanded right now close it
            if delegate != nil {
                delegate.closeDropDown()
            }

       } else {
            //we tap on drop down selection, will pass the value and close dropdown in main class
            if delegate != nil {

                


//                let id = [indexPath.row]
//
//                delegate?.selectedcollectioncell(id: id as AnyObject)
                
                
                
                delegate.selectedrow(value: dataSourceArray[indexPath.row] as AnyObject, parentid: idarray[0] as AnyObject, childid: idarray[indexPath.row] as AnyObject)
                
               
            }
        }
        
    }
    
    
    
   
    @objc func outofstockaction(sender:UIButton)
    {
        print("out of stock")
        
    }
    
    
    
    


}
