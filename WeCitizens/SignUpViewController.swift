//
//  SignUpViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/16/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import ParseUI

class SignUpViewController: PFSignUpViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ConfigureUI()
        
    }
    
    
    func ConfigureUI()
    {
        let offsetX = CGFloat(30)
        let TheColor = UIColor(red: 243/255, green: 77/255, blue: 53/255, alpha: 1.0)
        
        // logo
        var logoF = signUpView?.logo?.frame
        logoF?.origin.y -= 60
        
        signUpView?.logo?.frame = logoF!
        
        var userframe = signUpView?.usernameField?.frame
        userframe!.size.width -= offsetX * 2
        userframe?.origin.x += offsetX
        userframe?.origin.y -= 60
        
        signUpView?.usernameField!.borderStyle  = .None
        signUpView?.usernameField?.frame = userframe!
        signUpView?.usernameField!.layer.borderWidth = 1.3
        signUpView?.usernameField!.layer.borderColor = TheColor.CGColor
        signUpView?.usernameField!.layer.cornerRadius = 8
        
        
        
        var passframe = userframe
        passframe?.origin.y += (userframe?.size.height)! + 24
        
        signUpView?.passwordField?.borderStyle = .None
        signUpView?.passwordField?.frame = passframe!
        signUpView?.passwordField?.layer.cornerRadius = 8
        signUpView?.passwordField?.layer.borderColor = TheColor.CGColor
        signUpView?.passwordField?.layer.borderWidth = 1.3
        
        var emailF = passframe
        emailF?.origin.y += passframe!.size.height + 24
        
        signUpView?.emailField?.borderStyle = .None
        signUpView?.emailField?.frame = emailF!
        signUpView?.emailField?.layer.cornerRadius = 8
        signUpView?.emailField?.layer.borderColor = TheColor.CGColor
        signUpView?.emailField?.layer.borderWidth = 1.3
        
        
        var buttonF = signUpView?.signUpButton?.frame
        buttonF?.origin.x += 50
        buttonF?.size.width -= 100
        buttonF?.size.height -= 10
        
        signUpView?.signUpButton?.setBackgroundImage(nil, forState: .Normal)
        signUpView?.signUpButton?.frame = buttonF!
        signUpView?.signUpButton?.layer.cornerRadius = 10
        signUpView?.signUpButton?.layer.borderWidth = 1.2
        signUpView?.signUpButton?.layer.borderColor = TheColor.CGColor
        signUpView?.signUpButton?.backgroundColor = TheColor

        
    }
    
 
    
    
    
}
