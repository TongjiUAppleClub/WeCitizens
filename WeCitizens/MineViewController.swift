//
//  MineViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 3/27/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {

    @IBOutlet weak var HeadView: UIView!
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Reputation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UIconfigure()
    }
    
    func UIconfigure()
    {
      self.navigationController?.navigationBar.hidden = true
      HeadView.backgroundColor = UIColor.lxd_MainBlueColor()
      Avatar = UIImageView.lxd_CircleImage(Avatar, borderColor: UIColor.clearColor(), borderWidth: 1.0)
      Reputation.backgroundColor = UIColor.lxd_YellowColor()
      Reputation.clipsToBounds = true
      Reputation.layer.cornerRadius = Reputation.frame.height/2
        
    }
}
