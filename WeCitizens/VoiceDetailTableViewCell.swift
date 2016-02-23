//
//  VoiceDetailTableViewCell.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/22/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class VoiceDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Reputation: UILabel!
    @IBOutlet weak var CommentTime: UILabel!
    @IBOutlet weak var Comment: UITextView!
    
    
    
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
        Avatar.layer.masksToBounds = false
        Avatar.layer.borderWidth = 1
        Avatar.layer.borderColor = UIColor.clearColor().CGColor
        Avatar.layer.cornerRadius = Avatar.frame.height/2
        Avatar.clipsToBounds = true
        
        // Adjust the height of the textview
        let contentSize = self.Comment.sizeThatFits(self.Comment.bounds.size)
        var frame = self.Comment.frame
        frame.size.height = contentSize.height
        self.Comment.frame = frame
        
        let aspectRatioTextViewConstraint = NSLayoutConstraint(item: self.Comment, attribute: .Height, relatedBy: .Equal, toItem: self.Comment, attribute: .Width, multiplier: Comment.bounds.height/Comment.bounds.width, constant: 8)
        self.Comment.addConstraint(aspectRatioTextViewConstraint)
    }

}
