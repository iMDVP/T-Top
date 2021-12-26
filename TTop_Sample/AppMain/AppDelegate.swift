//
//  AppDelegate.swift
//  TTop_Sample
//
//  Created by Nima Davarpanah on 10/3/1400 AP.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor.init(hex: "142953")
        UINavigationBar.appearance().backgroundColor = UIColor.init(hex: "142953")
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(type: .lalezar, fontSize: 20.0) ,NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let attributes = [NSAttributedString.Key.font: UIFont.init(type: .regular, fontSize: 12.0), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = attributes
        
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)



        let dynamicList = DynamicRouter.createModule()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = dynamicList
        window?.makeKeyAndVisible()

        return true
    }


}

