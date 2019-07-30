//
//  contactusTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 28/05/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class contactusTableViewCell: UITableViewCell {

    @IBOutlet weak var btnsend: UIButton!
    @IBOutlet weak var txtviewmessage: UITextView!
    @IBOutlet weak var lblcomplteform: UILabel!
    @IBOutlet weak var lblsndusmsg: UILabel!
    @IBOutlet weak var txtfldphnenumbr: UITextField!
    @IBOutlet weak var txtfldemail: UITextField!
    @IBOutlet weak var txtfldname: UITextField!
    @IBOutlet weak var Outerview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
