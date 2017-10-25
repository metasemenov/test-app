//
//  RoundedView.swift
//  test-app
//
//  Created by metasemenov on 22.10.17.
//  Copyright © 2017 metasemenov. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = 5
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1987906678)
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.8
    }
}
