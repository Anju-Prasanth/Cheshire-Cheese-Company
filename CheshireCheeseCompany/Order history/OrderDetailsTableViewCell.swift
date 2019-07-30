//
//  OrderDetailsTableViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 14/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {
  
    @IBOutlet weak var Outerview: UIView!
    @IBOutlet weak var imageviewproduct: UIImageView!
    @IBOutlet weak var lblarrival: UILabel!
    @IBOutlet weak var lblqty: UILabel!
    @IBOutlet weak var lblname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
