//
//  UIButtonX.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/24/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

@IBDesignable
class UIButtonX: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
