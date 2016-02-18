//
//  WelcomeViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/18/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import ParseUI
import Parse

func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}


class WelcomeViewController: UIViewController,PFSignUpViewControllerDelegate,PFLogInViewControllerDelegate {
    
    var loginVC:LoginViewController!
    var signUpVC:SignUpViewController!
    
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var LoginB: UIButton!
    @IBOutlet weak var SignupB: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (PFUser.currentUser() != nil) {
            delay(seconds: 1.0, completion: { () -> () in
                
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MainTabVC")
                self.presentViewController(vc!, animated: true, completion: nil)
            })
            
        }
        else {
            loginVC = LoginViewController()
            loginVC.delegate = self
            signUpVC = SignUpViewController()
            signUpVC.delegate = self
        }
        
    }
    
    
    override func viewDidLayoutSubviews() {
        let TheColor = UIColor(red: 243/255, green: 77/255, blue: 53/255, alpha: 1.0)
        super.viewDidLayoutSubviews()
        LoginB.layer.cornerRadius = 10
        LoginB.layer.borderColor = TheColor.CGColor
        LoginB.layer.borderWidth = 1.2
        SignupB.layer.cornerRadius = 10
        
    }
    
    @IBAction func Login() {
        self.presentViewController(self.loginVC, animated: true, completion: nil)
    }
    
    @IBAction func SignUp() {
        self.presentViewController(self.signUpVC, animated: true, completion: nil)
    }
    
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if (!username.isEmpty && !password.isEmpty )
        {
            return true
        }
        UIAlertView(title: "缺少信息", message: "请补全缺少的信息", delegate: self, cancelButtonTitle:"确定").show()
        
        return false
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        
        print("登录错误")
        
        
    }
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        
        var infomationComplete = true
        for key in info.values {
            let field = key as! String
            if (field.isEmpty){
                infomationComplete = false
                break
            }
        }
        
        if (!infomationComplete){
            
            UIAlertView(title: "缺少信息", message: "请补全缺少的信息", delegate: self, cancelButtonTitle:"确定").show()
            
            return false
        }
        return true
    }
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("注册失败")
    }
    
    
    
}
