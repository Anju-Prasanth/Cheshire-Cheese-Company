//
//  TopSellingCollectionViewCell.swift
//  CheshireCheeseCompany
//
//  Created by Milan on 08/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit

class TopSellingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lbltopselling: UILabel!
    @IBOutlet weak var imageviewtopselling: UIImageView!
    @IBOutlet weak var Overview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Overview.layer.borderWidth = 1
        let color = UIColor(red: 226 / 255, green: 226 / 255, blue: 226 / 255, alpha: 1.0)
        Overview.layer.borderColor = color.cgColor
    }

}
