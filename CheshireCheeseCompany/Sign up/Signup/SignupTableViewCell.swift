//
//  SignupTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 13/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class SignupTableViewCell: UITableViewCell {

    @IBOutlet weak var viewalreadyamembr: UIView!
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var btncontinue: UIButton!
    @IBOutlet weak var lblalraedyacustmr: UILabel!
    @IBOutlet weak var btnchcklogin: UIButton!
    @IBOutlet weak var txtcnfirmpassword: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var lblfemale: UILabel!
    @IBOutlet weak var btnchckgender2: UIButton!
    @IBOutlet weak var lblmale: UILabel!
    @IBOutlet weak var btnchckgender: UIButton!
    @IBOutlet weak var lblgender: UILabel!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtlastname: UITextField!
    @IBOutlet weak var Txtfirstname: UITextField!
    @IBOutlet weak var lblcreateaccount: UILabel!
    @IBOutlet weak var btnchckcreteaccount: UIButton!
    @IBOutlet weak var viewcreateaccount: UIView!
    @IBOutlet weak var lblwlcme: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let emailview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 40))
        txtemail.leftView = emailview
       txtemail.leftViewMode = UITextFieldViewMode.always
        let firstnameview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 40))
       Txtfirstname.leftView = firstnameview
       Txtfirstname.leftViewMode = UITextFieldViewMode.always
         let lastnameview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 40))
        txtlastname.leftView = lastnameview
        txtlastname.leftViewMode = UITextFieldViewMode.always
         let confirmpswrd = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 40))
       txtcnfirmpassword.leftView = confirmpswrd
       txtcnfirmpassword.leftViewMode = UITextFieldViewMode.always
         let password = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 40))
       txtpassword.leftView = password
       txtpassword.leftViewMode = UITextFieldViewMode.always
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
