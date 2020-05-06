//
//  BorderColor.swift
//  Swift03
//
//  Created by 王铁刚 on R 2/04/04.
//  Copyright © Reiwa 2 王铁刚. All rights reserved.
//

import UIKit

@IBDesignable class BorderLabel: UILabel {
    @IBInspectable var borderColor: UIColor? {
        get { return UIColor(cgColor: layer.borderColor!)}
        set { layer.borderColor = newValue?.cgColor ?? nil}
    }
    
    @IBInspectable var borderWidth:CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0.0
        }
    }
}
