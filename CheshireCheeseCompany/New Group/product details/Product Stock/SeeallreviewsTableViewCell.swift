//
//  SeeallreviewsTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by apple on 03/07/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class SeeallreviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var btnseeallreviews: UIButton!
    @IBOutlet weak var bottomlbl: UIView!
    @IBOutlet weak var leftlbl: UILabel!
   
    @IBOutlet weak var rightlbl: UILabel!
    @IBOutlet weak var lblseeallreviews: UILabel!
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
