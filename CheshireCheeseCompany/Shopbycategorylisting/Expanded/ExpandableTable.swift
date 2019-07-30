//
//  ExpandableTable.swift
//  ExpandableTable
//
//  Created by Aman Aggarwal on 3/21/17.
//  Copyright © 2017 iostutorialjunction.com. All rights reserved.
//

import UIKit

protocol ExpandableTableDelegate {
//    func valueSelected(value: AnyObject)
    func valueSelected(value: AnyObject,parentid: AnyObject,childid: AnyObject, status: AnyObject, nextdaystatus: AnyObject, offer_id: AnyObject, offer_price: AnyObject )
    
    func parentSelected(parentid: AnyObject,name: AnyObject)
    func menuSelected(name: AnyObject)
    func selectedrow(value: AnyObject,parentid: AnyObject,childid: AnyObject)
}





class ExpandableTable: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandedCellDelegate {
    
    
    
    
    
    
    
    @IBOutlet weak var tblExpandable: UITableView!
    
    var idfornochild:Int!
    var nochildflag:Bool!
    
    var dataSourceForPlainTable:[Dictionary<String, AnyObject>] = Array()
    var dataSourceFordiscription:[Dictionary<String, AnyObject>] = Array()
    var dataSourceForprice:[Dictionary<String, AnyObject>] = Array()
    var dataSourceForimage:[Dictionary<String, AnyObject>] = Array()
    var dataSourceForstatus:[Dictionary<String, AnyObject>] = Array()
    var dataSourceForstock_status:[Dictionary<String, AnyObject>] = Array()
    var dataSourceFornextday_status:[Dictionary<String, AnyObject>] = Array()
    var dataSourceForoffer_id:[Dictionary<String, AnyObject>] = Array()
    var dataSourceForoffer_price:[Dictionary<String, AnyObject>] = Array()
    
    var dataSourceForid:[Dictionary<String, AnyObject>] = Array()
    var parentidarray:Array<Int>!
    var parentnamearray1:Array<String>!
    var subctgry1:Array<Int>!
    
    var indexToExpand = -1
    
    var delegate: ExpandableTableDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
print("subctgry1",subctgry1)
        // Do any additional setup after loading the view.
        tblExpandable.register(UINib(nibName: "ExpandedCell", bundle: nil), forCellReuseIdentifier: "Expanded_Cell")
    
        nochildflag = false
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      closeDropDown()
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//       return dataSourceFordiscription.count
        return dataSourceForPlainTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dict = dataSourceForPlainTable[indexPath.row]
        let iddict = dataSourceForid[indexPath.row]
        print("dataSourceForPlainTable:",dataSourceForPlainTable)
        
        if indexToExpand == indexPath.row {
            
            let cellExpanded = tableView.dequeueReusableCell(withIdentifier: "Expanded_Cell") as! ExpandedCell
            cellExpanded.delegate = self
            
            var tempArray:[String] = dict["child"] as! Array
            //            var tempdiscriptionArray:[String] = discriptiondict["childdisc"] as! Array
            //            var temppriceArray:[String] = pricedict["childprice"] as! Array
            //            var tempimageArray:[String] = imagedict["childimage"] as! Array
            //            var tempstatusArray:[String] = statusdict["childstatus"] as! Array
            //            var tempstock_statusArray:[String] = stock_statusdict["childstock_status"] as! Array
            //            var tempnextday_statusArray:[String] = nextday_statusdict["childnextday_status"] as! Array
            //            var tempoffer_idArray:[String] = offer_iddict["childoffer_id"] as! Array
            //            var tempoffer_priceArray:[String] = offer_pricedict["childoffer_price"] as! Array
            
            var tempidArray:[Int] = iddict["child_id"] as! Array
            
           
            
            tempArray.insert((dict["parent"] as? String)!, at: 0)
            
            //            tempdiscriptionArray.insert((discriptiondict["parentdisc"] as? String)!, at: 0)
            //            temppriceArray.insert((pricedict["parentprice"] as? String)!, at: 0)
            //            tempimageArray.insert((imagedict["parentimage"] as? String)!, at: 0)
            //            tempstatusArray.insert((statusdict["parentstatus"] as? String)!, at: 0)
            //            tempstock_statusArray.insert((stock_statusdict["parentstock_status"] as? String)!, at: 0)
            //            tempnextday_statusArray.insert((nextday_statusdict["parentnextday_status"] as? String)!, at: 0)
            
            //            tempoffer_idArray.insert((offer_iddict["parentoffer_id"] as? String)!, at: 0)
            //            tempoffer_priceArray.insert((offer_pricedict["parentoffer_price"] as? String)!, at: 0)
            
            tempidArray.insert((iddict["parent_id"] as? Int)!, at: 0)
            //            print("tempidarray: ",tempidArray)
            //            print("temparray: ",tempArray)
            //            print("--------------")
            
            
           cellExpanded.dataSourceArray = tempArray
            cellExpanded.idarray = tempidArray
            //            cellExpanded.discriptionArray = tempdiscriptionArray
            //            cellExpanded.priceArray = temppriceArray
            //            cellExpanded.imageArray = tempimageArray
            //            cellExpanded.statusArray = tempstatusArray
            //            cellExpanded.stock_statusArray = tempstock_statusArray
            //            cellExpanded.nextday_statusArray = tempnextday_statusArray
            //            cellExpanded.offer_idArray = tempoffer_idArray
            //            cellExpanded.offer_priceArray = tempoffer_priceArray
            
            cellExpanded.tblExpandedOptions.reloadData()
            if tempidArray.count == 1{
                
                idfornochild = tempidArray[0]
                nochildflag = true
            }
            return cellExpanded
            
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "PlainCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "PlainCell")
        }
        
        //        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        cell?.textLabel?.font = UIFont(name: "TitilliumWeb-SemiBold", size: 20.0)
        cell?.textLabel?.text = dict["parent"] as? String
         cell?.accessoryType = .disclosureIndicator
        cell?.selectionStyle = .none
        return cell!
        
    
        
    }
    
    
    //MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("parentselected")
        print("nochildflag:",nochildflag)
        print("dataSourceForid",dataSourceForid)
        
        delegate.parentSelected(parentid: parentidarray[indexPath.row] as AnyObject,name: parentnamearray1[indexPath.row] as AnyObject)
        
        //delegate.menuSelected(name:dataSourceForPlainTable[indexPath.row] as AnyObject)
            tableView.deselectRow(at: indexPath, animated: true)
            if indexToExpand == indexPath.row {
                //we tap on same row who is expanded right now close it
                indexToExpand  = -1
            } else {
                if indexToExpand != -1 {
                    let indexpath = IndexPath(row: indexToExpand, section: 0)
                    indexToExpand = indexPath.row
                    tblExpandable.reloadRows(at: [indexpath], with: .fade)
                    
                }
                
                indexToExpand = indexPath.row
                
            }
        
            tblExpandable.reloadRows(at: [indexPath], with: .fade)
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let dict = dataSourceForPlainTable[indexPath.row]
        if indexToExpand == indexPath.row {
            var tempArray:[String] = dict["child"] as! Array
            tempArray.insert((dict["parent"] as? String)!, at: 0)
            let count = (tempArray.count)
            //            print("count",count)
            //            return CGFloat((120.0 * CGFloat(count-1))+44.0)
            return CGFloat((44.0 * CGFloat(count-1))+44.0)
        }
        return UITableViewAutomaticDimension
    }

    func menuSelected(name: AnyObject) {
        if delegate != nil {
            
                       self.delegate.menuSelected(name: name)
            
            
        }
        closeDropDown()
    }
    
    
    func valueSelected(value: AnyObject, parentid: AnyObject, childid: AnyObject, status: AnyObject,nextdaystatus: AnyObject, offer_id: AnyObject, offer_price: AnyObject) {
        if delegate != nil {
            //            print("parentid: ",parentid)
            
            //            self.delegate.valueSelected(value: value, parentid: parentid as AnyObject, childid: childid as AnyObject, status: status, nextdaystatus: nextdaystatus)
            self.delegate.valueSelected(value: value, parentid: parentid as AnyObject, childid: childid as AnyObject, status: status, nextdaystatus: nextdaystatus, offer_id: offer_id, offer_price: offer_price)
            
        }
        closeDropDown()
    }
    
    func parentSelected(parentid: AnyObject,name: AnyObject){
        
        self.delegate.parentSelected(parentid: parentid as AnyObject,name: name as AnyObject)
        
        
    }
    
    func selectedrow(value: AnyObject, parentid: AnyObject, childid: AnyObject) {
      
        self.delegate.selectedrow(value: value, parentid: parentid as AnyObject, childid: childid as AnyObject)
     
            closeDropDown()
        
    }
    
    
    func closeDropDown() {
        let indexpath = IndexPath(row: indexToExpand, section: 0)
        indexToExpand  = -1
        tblExpandable.reloadRows(at: [indexpath], with: .fade)
        
    }

}
