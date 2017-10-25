//
//  UserCell.swift
//  test-app
//
//  Created by metasemenov on 25.10.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userCityLbl: UILabel!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userPhoneLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(user: User) {
        userNameLbl.text = user.userName
        userCityLbl.text = user.userCity
        userEmailLbl.text = user.userEmail
        userPhoneLbl.text = user.userPhone
    }

}
