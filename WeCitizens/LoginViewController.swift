//
//  ViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/4/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

//MARK:- Controls
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var Register: UIButton!
    
    
//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UserName.delegate = self
        Password.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureUI()
    }
    
    
//MARK:- UI Congigure
    func configureUI(){
        //img
        logoImg.image =  UIImage(named: "07")
        logoImg.layer.borderWidth = 1
        logoImg.layer.masksToBounds = false
        logoImg.layer.borderColor = UIColor.clearColor().CGColor
        logoImg.layer.cornerRadius = logoImg.layer.frame.height/2
        logoImg.clipsToBounds = true
        
        //text
        UserName.layer.borderWidth = 1.3
        UserName.layer.borderColor = UIColor.redColor().CGColor
        UserName.layer.cornerRadius = 8
        
        Password.layer.borderWidth = 1.3
        Password.layer.borderColor = UIColor.redColor().CGColor
        Password.layer.cornerRadius = 8
        
        
        //Button
        Login.layer.borderWidth = 1.2
        Login.layer.borderColor = UIColor.redColor().CGColor
        Login.layer.cornerRadius = 10
        
        Register.layer.borderWidth = 1.2
        Register.layer.borderColor = UIColor.redColor().CGColor
        Register.layer.cornerRadius = 10
        
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

    //MARK:- Action
    //TODO:-  Add model action here
    @IBAction func logInAction() {
        let password = Password.text!
        let username = UserName.text!
     //   print("username is \(username) & password is \(password)")
    //如果登录成功，执行下面的代码，否则弹出alert，alert我准备用HUD，还没加
        guard let vc = storyboard?.instantiateViewControllerWithIdentifier("MainTabVC")else {
            print("Error!")
            return
        }
        presentViewController(vc, animated: true, completion: nil)
    }
    
}

