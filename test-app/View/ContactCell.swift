//
//  ContactCell.swift
//  test-app
//
//  Created by metasemenov on 23.10.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var iconBg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(contactInfo: String, imgName: String) {
        iconBg.layer.cornerRadius = iconBg.layer.frame.width / 2
        if imgName == "telephone" {
            iconBg.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        } else if imgName == "github" {
            iconBg.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        } else {
            iconBg.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }
        info.text = contactInfo
        iconImg.image = UIImage(named: "\(imgName).png")
    }
}
