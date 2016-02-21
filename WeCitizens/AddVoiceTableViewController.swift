//
//  AddVoiceTableViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/21/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class AddVoiceTableViewController: UITableViewController {

  
    @IBOutlet weak var TitleCell: UITableViewCell!
    @IBOutlet weak var BodyCell: UITableViewCell!
    @IBOutlet weak var VoiceTitle: UITextField!
    @IBOutlet weak var Content: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
