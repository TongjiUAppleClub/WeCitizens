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
        UITabBar.appearance().tintColor = UIColor(red: 237.0/255, green: 78/255, blue: 48/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor(red: 237.0/255, green: 78/255, blue: 48/255, alpha: 1.0)
    }
    
}
