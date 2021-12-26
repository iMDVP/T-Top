//
//  String.swift
//  VesamAcademyInitializerApp_iOS
//
//  Created by Nima Davarpanah on 11/25/19.
//  Copyright © 2019 Mohammad Davarpanah. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return (match.range.length == self.utf16.count) && (self.contains(".jpg") || self.contains(".jpeg") || self.contains(".png"))
        } else {
            return false
        }
    }
    
    public func removeSpaceFromPath() -> String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
    
    public func insertSpaceToPath() -> String {
        return self.replacingOccurrences(of: "%20", with: " ")
    }
    


}

