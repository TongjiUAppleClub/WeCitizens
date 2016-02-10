//
//  TestViewController.swift
//  WeCitizens
//
//  Created by Teng on 2/7/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import Parse

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Test Parse Store
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
            print("Object hase been saved.")
        }
        
        
        
        // Test Parse Signup
        let user = PFUser()
        user.username = "myName"
        user.passowrd = "myPassword"
        user.email = "email@example.com"
        
        // other fields can be set if you want to save more information
        user["phone"] = "650-555-0000"
        
        user.signUpInBackgroundWithBlock{ (success: Bool, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them user th app now.
            } else {
                // Examine the error object and inform the user.
            }
        }
        
        
        
        // Test Parse Login
        PFUser.logInWithUsernameInBackground("myName", password: "myPassword") {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
            } else {
                // The login failed. Check error to see why.
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
