//
//  UITextFieldExtension.swift
//  realworld
//
//  Created by Mac on 2020/09/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
        layer.masksToBounds = true
    }
    
}
