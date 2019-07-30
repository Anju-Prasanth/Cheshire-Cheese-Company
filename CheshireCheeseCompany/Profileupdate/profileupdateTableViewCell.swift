//
//  profileupdateTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 28/05/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class profileupdateTableViewCell: UITableViewCell {

    @IBOutlet weak var txtfldupdateemail: UITextField!
    @IBOutlet weak var btnupdate: UIButton!
    @IBOutlet weak var txtfldtaxvat: UITextField!
    @IBOutlet weak var lblprofileupdate: UILabel!
    @IBOutlet weak var txtfldemail: UITextField!
    @IBOutlet weak var txtflddob: UITextField!
    @IBOutlet weak var txtfldlastname: UITextField!
    @IBOutlet weak var txtfldmiddlename: UITextField!
    @IBOutlet weak var txtfldfirstname: UITextField!
    @IBOutlet weak var Outerview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
