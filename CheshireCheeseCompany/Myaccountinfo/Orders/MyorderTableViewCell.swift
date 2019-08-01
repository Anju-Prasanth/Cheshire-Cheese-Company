//
//  MyorderTableViewCell.swift
//  
//
//  Created by apple on 20/04/19.
//

import UIKit

class MyorderTableViewCell: UITableViewCell {
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var lblitemordrd: UILabel!
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
