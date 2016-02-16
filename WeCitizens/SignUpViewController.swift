//
//  SignUpViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/16/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate{

    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var signIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.delegate = self
        password.delegate = self
        repeatPassword.delegate = self
        email.delegate = self
        configureUI()
    }

    //MARK:- UI Congigure
    func configureUI(){
        //img
        avatar.image =  UIImage(named: "07")
        avatar.layer.borderWidth = 1
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = UIColor.clearColor().CGColor
        avatar.layer.cornerRadius = avatar.layer.frame.height/2
        avatar.clipsToBounds = true
        
        //text
        username.layer.borderWidth = 1.3
        username.layer.borderColor = UIColor.redColor().CGColor
        username.layer.cornerRadius = 8
        
        password.layer.borderWidth = 1.3
        password.layer.borderColor = UIColor.redColor().CGColor
        password.layer.cornerRadius = 8
        
        repeatPassword.layer.borderWidth = 1.3
        repeatPassword.layer.borderColor = UIColor.redColor().CGColor
        repeatPassword.layer.cornerRadius = 8
        
        email.layer.borderWidth = 1.3
        email.layer.borderColor = UIColor.redColor().CGColor
        email.layer.cornerRadius = 8
        
        //Button
        signIn.layer.borderWidth = 1.2
        signIn.layer.borderColor = UIColor.redColor().CGColor
        signIn.layer.cornerRadius = 10
        
        signUp.layer.borderWidth = 1.2
        signUp.layer.borderColor = UIColor.redColor().CGColor
        signUp.layer.cornerRadius = 10
        
    }
    
    //MARK:- Keyboard
    
    //Called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Called when the user click on the view (outside the UITextField).
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //TODO:- Finish the action
    //MARK:- Action
    @IBAction func SignUp(sender: AnyObject) {
        
        print("\(username),\(password),\(repeatPassword),\(email)")
        guard let vc = storyboard?.instantiateViewControllerWithIdentifier("MainTabVC")else {
            print("Error!")
            return
        }
        presentViewController(vc, animated: true, completion: nil)

    }
    
}
