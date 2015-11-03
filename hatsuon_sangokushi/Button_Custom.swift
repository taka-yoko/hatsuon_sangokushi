//
//  Button_Custom.swift
//  mp3_test
//
//  Created by tyoko on 2015/11/01.
//  Copyright © 2015年 tyoko. All rights reserved.
//

import UIKit

@IBDesignable
class Button_Custom: UIButton {
    
    @IBInspectable var textColor: UIColor?

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
}
