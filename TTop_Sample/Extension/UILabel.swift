//
//  UILabel.swift
//  VesamAcademyInitializerApp_iOS
//
//  Created by Nima Davarpanah on 11/27/19.
//  Copyright © 2019 Mohammad Davarpanah. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func requiredHeight() {
        self.numberOfLines = 0
        self.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    func configure(text: String, fontSize: CGFloat, textColor: UIColor, textAlignment: NSTextAlignment = .right, fontType: FontString = .regular, hasSizeToFit: Bool = true) {
        self.text = text
        self.font = UIFont.init(type: fontType, fontSize: fontSize)
        self.textColor = textColor
        self.textAlignment = textAlignment
        if hasSizeToFit {
            self.sizeToFit()
        }
    }

    
}

