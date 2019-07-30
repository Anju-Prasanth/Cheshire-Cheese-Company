//
//  AddnewadrsTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 24/06/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import iOSDropDown

class AddnewadrsTableViewCell: UITableViewCell {
    @IBOutlet weak var txtfldmiddlename: UITextField!
    @IBOutlet weak var btnsaveadrs: UIButton!
    @IBOutlet weak var txtfldstate: DropDown!
    @IBOutlet weak var txtfldcity: UITextField!
    @IBOutlet weak var txtfldstreetyadrs: UITextField!
    @IBOutlet weak var txtfldadrs1: UITextField!
    @IBOutlet weak var lbladrs: UILabel!
    @IBOutlet weak var lblcontactinfrmtn: UILabel!
    @IBOutlet weak var txtfldphonenumbr: UITextField!
    @IBOutlet weak var txtfldpostalcode: UITextField!
    
    
    @IBOutlet weak var txtfldcountry: DropDown!
    
    @IBOutlet weak var txtfldlastname: UITextField!
    @IBOutlet weak var txtfldfirstname: UITextField!
    @IBOutlet weak var Outerview: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
