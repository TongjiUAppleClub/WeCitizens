//
//  AddVoiceTableViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/21/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import Parse

class AddVoiceTableViewController: UITableViewController,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  
    @IBOutlet weak var TitleCell: UITableViewCell!
    @IBOutlet weak var BodyCell: UITableViewCell!
    @IBOutlet weak var VoiceTitle: UITextField!
    @IBOutlet weak var Content: UITextView!
    
    let imagePickerController = UIImagePickerController()
    var isFullScreen:Bool = false
    let dataModel = DataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Content.delegate = self
        // self.clearsSelectionOnViewWillAppear = false
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    func configureUI()
    {

     VoiceTitle.backgroundColor = UIColor.clearColor()
     BodyCell.frame.size.height += 40
     Content.backgroundColor = UIColor.clearColor()
    
    }
    
    @IBAction func PublishVoice(sender: UIBarButtonItem) {
        
        let abstract = VoiceTitle.text!
        let content = Content.text
        let userName = PFUser.currentUser()!.username!
        let userEmail = PFUser.currentUser()!.email!
        
        let newIssue = Issue(email: userEmail, name: userName, time: nil, title: "Test", abstract: abstract, content: content, classify: "test", focusNum: nil, city: "shanghai", replied: nil, images: [])
        
//TODO:- Add send action
        dataModel.addNewIssue(newIssue) { (success, error) -> Void in
            if nil == error {
                if success {
                    print("Add new issue success")
                    self.navigationController?.popViewControllerAnimated(true)
                    //给用户提示
                }
            } else {
                //Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                //给用户提示
            }
        }
        
    }

}
