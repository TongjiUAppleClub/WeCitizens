//
//  MainTabbarController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/11/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // UITabBar.appearance().barTintColor = UIColor.redColor()
        UITabBar.appearance().tintColor = UIColor(red: 237.0, green: 78, blue: 48, alpha: 1.0)
        UITabBar.appearance().tintColor = UIColor.redColor()
        UINavigationBar.appearance().tintColor = UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
