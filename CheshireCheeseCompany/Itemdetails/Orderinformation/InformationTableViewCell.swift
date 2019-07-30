//
//  InformationTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 25/04/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class InformationTableViewCell: UITableViewCell {
     @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var lblorderinfrmtn: UILabel!
     @IBOutlet weak var btnitemordered: UIButton!
     @IBOutlet weak var btnorderinfrmation: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
  
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
