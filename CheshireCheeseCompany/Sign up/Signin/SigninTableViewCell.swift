//
//  SigninTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 14/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class SigninTableViewCell: UITableViewCell {

   
    @IBOutlet weak var viewcreateaccount: UIView!
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var btnforgotpassword: UIButton!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var lblalreadymmbr: UILabel!
    @IBOutlet weak var btnchcklogin: UIButton!
    @IBOutlet weak var lblcreateacount: UILabel!
    @IBOutlet weak var btnchckcreateacount: UIButton!
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var lblwelcome: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 40))
        txtemail.leftView = paddingView
        txtemail.leftViewMode = UITextFieldViewMode.always
        let passwordview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 40))
        txtpassword.leftView = passwordview
        txtpassword.leftViewMode = UITextFieldViewMode.always
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
