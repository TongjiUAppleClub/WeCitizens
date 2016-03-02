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
        UITabBar.appearance().tintColor = UIColor(red: 243.0/255, green: 77/255, blue: 54/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor(red: 243.0/255, green: 77/255, blue: 54/255, alpha: 1.0)
    }
    
}
