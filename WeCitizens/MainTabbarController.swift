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
        UITabBar.appearance().tintColor = UIColor.lxd_MainBlueColor()
        UINavigationBar.appearance().tintColor = UIColor.lxd_MainBlueColor()
    }
    
}
