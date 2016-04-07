//
//  EditUserInfoControler.swift
//  WeCitizens
//
//  Created by  Harold LIU on 4/7/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class EditUserInfoControler: UITableViewController,UITextFieldDelegate{
    
    
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var OldPassword: UITextField!
    @IBOutlet weak var NewPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Email.delegate = self
        Username.delegate = self
        OldPassword.delegate = self
        NewPassword.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        Avatar = UIImageView.lxd_CircleImage(Avatar, borderColor: UIColor.clearColor(), borderWidth: 0)
        
    }

    @IBAction func ChangeAvatar(sender: UIButton) {
    }
    
    @IBAction func submit(sender: UIBarButtonItem) {
    }
    

}
