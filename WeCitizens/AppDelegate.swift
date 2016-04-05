//
//  AppDelegate.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/4/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.enableLocalDatastore()
        
        // Initialize Prase
        Parse.setApplicationId("2PVQUIOrjJC2tiMONyyeICDPVFW6CrHdAKlBbJjx", clientKey: "WB4B05hYeHOSTNOe0ASLli8AFJDjKdDAk8HZQIju")
        
        UINavigationBar.appearance().tintColor = UIColor.lxd_MainBlueColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.lxd_MainBlueColor()]
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

public extension UIColor
{
    class func lxd_MainBlueColor() ->UIColor{
        return UIColor(red: 32/255, green: 179/255, blue: 245/255, alpha: 1.0)
    }
    
    class func lxd_YellowColor() -> UIColor {
        return UIColor(red: 242/255, green: 228/255, blue: 76/255, alpha: 1.0)

    }
    
    class func lxd_FontColor() -> UIColor {
        return UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1.0)
    }
    
    class func lxd_lightGreyColor() -> UIColor {
        return UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
    }
    
}

public extension UIImageView
{
    class func lxd_CircleImage(imageView: UIImageView,borderColor:UIColor,borderWidth:CGFloat) -> UIImageView
    {
        imageView.layer.masksToBounds = false
        imageView.layer.borderWidth = borderWidth
        imageView.layer.borderColor = borderColor.CGColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true 
        
        return imageView
    }
}

public extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.Top:
            border.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), thickness)
            break
        case UIRectEdge.Bottom:
            border.frame = CGRectMake(0, CGRectGetHeight(self.frame) - thickness, CGRectGetWidth(self.frame), thickness)
            break
        case UIRectEdge.Left:
            border.frame = CGRectMake(0, 0, thickness, CGRectGetHeight(self.frame))
            break
        case UIRectEdge.Right:
            border.frame = CGRectMake(CGRectGetWidth(self.frame) - thickness, 0, thickness, CGRectGetHeight(self.frame))
            break
        default:
            break
        }
        
        border.backgroundColor = color.CGColor;
        
        self.addSublayer(border)
    }
}


