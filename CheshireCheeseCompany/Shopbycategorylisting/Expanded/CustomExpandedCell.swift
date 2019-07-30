//
//  CustomExpandedCell.swift
//  ExpandableTable
//
//  Created by Aman Aggarwal on 3/23/17.
//  Copyright © 2017 iostutorialjunction.com. All rights reserved.
//

import UIKit

class CustomExpandedCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var layoutLC: NSLayoutConstraint!
//    @IBOutlet var imagearrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
