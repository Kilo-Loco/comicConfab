//
//  MaterialView.swift
//  Comic Confab
//
//  Created by Kyle Lee on 10/19/16.
//  Copyright © 2016 Kyle Lee. All rights reserved.
//

import UIKit

class MaterialView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
    }

}
