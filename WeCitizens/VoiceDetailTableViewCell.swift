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
    
    func CongfigureUI()
    {
        //make avatar circle
        CommentUserAvatar = UIImageView.lxd_CircleImage(CommentUserAvatar, borderColor: UIColor.clearColor(), borderWidth: 0)
        // make reputation circle
        CommentUserResume.layer.masksToBounds = false
        CommentUserResume.layer.cornerRadius = CommentUserResume.frame.height/2
        CommentUserResume.clipsToBounds = true
        CommentUserResume.backgroundColor = UIColor.lxd_YellowColor()
        CommentUserResume.textColor = UIColor.lxd_FontColor()
        CommentUserName.textColor = UIColor.lxd_FontColor()
    }

}
