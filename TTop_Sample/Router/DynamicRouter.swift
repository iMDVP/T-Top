//
//  DynamicRouter.swift
//  TTop_Sample
//
//  Created by Nima Davarpanah on 10/3/1400 AP.
//


import Foundation
import UIKit

class DynamicRouter: DynamicListPresenterToRouterProtocol {
    
    // MARK: - Methods
    
    class func createModule() -> UIViewController {
        let view = ViewController()

        return view
    }

}
