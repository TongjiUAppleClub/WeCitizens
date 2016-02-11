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
        print("test register")
        
        UserModel.register("HelloWorld", userEmail: "843018739@qq.com", password: "123456") { (success, error) -> Void in
            if error == nil {
                // Hooray! Let them user th app now.
                print(success)
                print("success")
            } else {
                // Examine the error object and inform the user.
                print("there is a error")
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
