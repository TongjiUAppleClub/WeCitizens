//
//  ViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/4/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import ParseUI

class LoginViewController: PFLogInViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        logInView?.signUpButton?.removeFromSuperview()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ConfigureUI()
    }
    
    func ConfigureUI()
    {
        let offsetX = CGFloat(30)
        let TheColor = UIColor.lxd_MainBlueColor()
        // logo
        var logoF = logInView?.logo?.frame
        logoF?.origin.y -= 50
        
        logInView?.logo?.frame = logoF!
        
        var userframe = logInView?.usernameField?.frame
        userframe!.size.width -= offsetX * 2
        userframe?.origin.x += offsetX
        userframe?.origin.y -= 20
        
        logInView?.usernameField!.borderStyle  = .None
        logInView?.usernameField?.frame = userframe!
        logInView?.usernameField!.layer.borderWidth = 1.3
        logInView?.usernameField!.layer.borderColor = TheColor.CGColor
        logInView?.usernameField!.layer.cornerRadius = (logInView?.usernameField?.frame.height)!/2
        
        
        
        var passframe = userframe
        passframe?.origin.y += (userframe?.size.height)! + 32
        
        logInView?.passwordField?.borderStyle = .None
        logInView?.passwordField?.frame = passframe!
        logInView?.passwordField?.layer.cornerRadius = (logInView?.passwordField?.frame.height)!/2
        logInView?.passwordField?.layer.borderColor = TheColor.CGColor
        logInView?.passwordField?.layer.borderWidth = 1.3
        
        
        var buttonF = logInView?.logInButton?.frame
        buttonF?.origin.x += 50
        buttonF?.size.width -= 100
        buttonF?.size.height -= 10
        buttonF?.origin.y += 20
        
        logInView?.logInButton?.setBackgroundImage(nil, forState: .Normal)
        logInView?.logInButton?.frame = buttonF!
        logInView?.logInButton?.layer.borderWidth = 1.2
        logInView?.logInButton?.layer.cornerRadius = (logInView?.logInButton?.frame.height)!/2
        logInView?.logInButton?.layer.borderColor = TheColor.CGColor
        logInView?.logInButton?.backgroundColor = TheColor
        
        
    }
    
}

