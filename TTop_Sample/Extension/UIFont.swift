//
//  UIFont.swift
//  VesamAcademyInitializerApp_iOS
//
//  Created by Nima Davarpanah on 11/27/19.
//  Copyright © 2019 Mohammad Davarpanah. All rights reserved.
//

import UIKit

extension UIFont {
    
    convenience init(type: FontString, fontSize: CGFloat) {
        self.init(name: type.rawValue, size: fontSize)!
    }
    
}

