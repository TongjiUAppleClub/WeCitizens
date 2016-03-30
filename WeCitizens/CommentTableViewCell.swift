//
//  CommentTableViewCell.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/11/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import SnapKit

class CommentTableViewCell: UITableViewCell,UITextViewDelegate,UIScrollViewDelegate{
    
    

    @IBOutlet weak var Back: UIView!
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var CommentUser: UILabel!
    @IBOutlet weak var Reputation: UILabel!
    @IBOutlet weak var Classify: UILabel!
    @IBOutlet weak var UpdateTime: UILabel!
    @IBOutlet weak var Abstract: UITextView!
    @IBOutlet weak var ClassifyKind: UIImageView!
    @IBOutlet weak var VoiceTitle: UILabel!
    @IBOutlet weak var ImgesContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIconfigure()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//MARK:- Configure UI
    func UIconfigure()
    {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.clearColor().CGColor
        
        Avatar = UIImageView.lxd_CircleImage(Avatar, borderColor: UIColor.clearColor(), borderWidth: 1.0)
        CommentUser.textColor = UIColor.lxd_FontColor()
        Reputation.backgroundColor = UIColor.lxd_YellowColor()
        Reputation.layer.cornerRadius = Reputation.frame.height/2
        Reputation.clipsToBounds = true
        Reputation.textColor = UIColor.lxd_FontColor()
        UpdateTime.textColor = UIColor.lxd_FontColor()
        // Images Containter
        ImgesContainer.layer.masksToBounds = false
        ImgesContainer.layer.cornerRadius = 10
        ImgesContainer.layer.borderWidth = 1.2
        ImgesContainer.layer.borderColor = UIColor.clearColor().CGColor
        
    }
}


