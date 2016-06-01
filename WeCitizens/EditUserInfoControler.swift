//
//  EditUserInfoControler.swift
//  WeCitizens
//
//  Created by  Harold LIU on 4/7/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import Parse

class EditUserInfoControler: UITableViewController,UITextFieldDelegate{
    
    
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var OldPassword: UITextField!
    @IBOutlet weak var NewPassword: UITextField!
    
    var user:User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Email.delegate = self
        Username.delegate = self
        OldPassword.delegate = self
        NewPassword.delegate = self
        
        // 禁用Email修改，或者把Email换成label
        
        self.hideKeyboardWhenTappedAround()
        Avatar = UIImageView.lxd_CircleImage(Avatar, borderColor: UIColor.clearColor(), borderWidth: 0)
        
        if let currentUser = user {
            Username.text = currentUser.userName
            Email.text = currentUser.userEmail
        }
    }

    @IBAction func ChangeAvatar(sender: UIButton) {
    }
    
    @IBAction func submit(sender: UIBarButtonItem) {
        // 如果输入了密码，验证密码对不对
        do {
            try PFUser.logInWithUsername("123", password: "7887897897")
            print("well done")
        } catch {
            print("get error")
        }
        
        // 如果没有输入密码，修改昵称（需要看看昵称能不能改）
        
    }
    

}
