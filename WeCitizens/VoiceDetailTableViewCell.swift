//
//  VoiceDetailTableViewCell.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/22/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class VoiceDetailTableViewCell: UITableViewCell {

    

    @IBOutlet weak var CommentUserAvatar: UIImageView!
    @IBOutlet weak var CommentUserResume: UILabel!
    @IBOutlet weak var CommentUserName: UILabel!
    @IBOutlet weak var CommentContent: UITextView!
    @IBOutlet weak var CommentTime: UILabel! 
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CongfigureUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func CongfigureUI()
    {
        self.backgroundColor = UIColor(red: 249/255, green: 251/255, blue: 255/255, alpha: 1.0)
        //make avatar circle
        CommentUserAvatar.layer.masksToBounds = false
        CommentUserAvatar.layer.borderWidth = 1
        CommentUserAvatar.layer.borderColor = UIColor.clearColor().CGColor
        CommentUserAvatar.layer.cornerRadius = CommentUserAvatar.frame.height/2
        CommentUserAvatar.clipsToBounds = true
        
        // make reputation circle
        CommentUserResume.layer.masksToBounds = false
        CommentUserResume.layer.borderColor = UIColor.clearColor().CGColor
        CommentUserResume.layer.cornerRadius = CommentUserResume.frame.height/2
        CommentUserResume.clipsToBounds = true
        
    }

}
