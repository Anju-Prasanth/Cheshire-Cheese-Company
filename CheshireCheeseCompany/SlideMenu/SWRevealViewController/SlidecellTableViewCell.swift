//
//  SlidecellTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 12/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class SlidecellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbllogout: UILabel!
    @IBOutlet weak var viewheight: NSLayoutConstraint!
    @IBOutlet weak var lbllogin: UILabel!
    @IBOutlet weak var lblhiguest: UILabel!
    @IBOutlet weak var btnprofile: UIButton!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblphonenumber: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btnlogout: UIButton!
   
    @IBOutlet weak var btnmyaccount: UIButton!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var imagelogout: UIImageView!

    @IBOutlet weak var btnhome: UIButton!
    
    @IBOutlet weak var btnshipingprivacy: UIButton!
    @IBOutlet weak var btnnotifications: UIButton!
    @IBOutlet weak var btncontactus: UIButton!
    @IBOutlet weak var btnaboutus: UIButton!
    @IBOutlet weak var btnyourwhishlist: UIButton!
    @IBOutlet weak var btnyourorder: UIButton!
    @IBOutlet weak var btnshopbycategory: UIButton!
   
    
    @IBOutlet weak var btnmyorder: UIButton!
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view1height: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        image1.layer.borderWidth=1.0
        image1.layer.masksToBounds = false
        //        image1.layer.borderColor = UIColor.white.cgColor
        image1.layer.cornerRadius = image1.frame.size.height/2
        image1.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
