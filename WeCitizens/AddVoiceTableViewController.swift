//
//  AddVoiceTableViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/21/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import Parse

class AddVoiceTableViewController: UITableViewController,UITextViewDelegate {

  
    @IBOutlet weak var TitleCell: UITableViewCell!
    @IBOutlet weak var BodyCell: UITableViewCell!
    @IBOutlet weak var VoiceTitle: UITextField!
    @IBOutlet weak var Content: UITextView!
    
    
    
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
        
        let Abstract = VoiceTitle.text
        let content = Content.text
        let userName = PFUser.currentUser()?.username
        let date = NSDate()
        print("\(date),\(Abstract),\(content),\(userName)")
        
//TODO:- Add send action
        
        
    }

}
