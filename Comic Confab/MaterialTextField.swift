//
//  MaterialTextField.swift
//  Comic Confab
//
//  Created by Kyle Lee on 10/19/16.
//  Copyright © 2016 Kyle Lee. All rights reserved.
//

import UIKit

class MaterialTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.2).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 3.0
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }

    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
}
