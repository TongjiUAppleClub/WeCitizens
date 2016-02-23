//
//  VoiceTitleTableViewCell.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/22/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class VoiceTitleTableViewCell: UITableViewCell {

//MARK:- Params
    
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Reputation: UILabel!
    @IBOutlet weak var Classify: UILabel!
    @IBOutlet weak var Content: UITextView!
    @IBOutlet weak var SendTime: UILabel!
    @IBOutlet weak var ResponseButton: UIButton!

    @IBOutlet var Images: [UIImageView]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ConfigureUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func ConfigureUI()
    {
        self.backgroundColor = UIColor(red: 249/255, green: 251/255, blue: 255/255, alpha: 1.0)
        
        //make avatar circle
        Avatar.layer.masksToBounds = false
        Avatar.layer.borderWidth = 1
        Avatar.layer.borderColor = UIColor.clearColor().CGColor
        Avatar.layer.cornerRadius = Avatar.frame.height/2
        Avatar.clipsToBounds = true
        
        // Adjust the height of the textview
        let contentSize = self.Content.sizeThatFits(self.Content.bounds.size)
        var frame = self.Content.frame
        frame.size.height = contentSize.height
        self.Content.frame = frame
        
        let aspectRatioTextViewConstraint = NSLayoutConstraint(item: self.Content, attribute: .Height, relatedBy: .Equal, toItem: self.Content, attribute: .Width, multiplier: Content.bounds.height/Content.bounds.width, constant: 8)
        self.Content.addConstraint(aspectRatioTextViewConstraint)
        
        //Configure the Button
        ResponseButton.layer.borderColor = UIColor(red: 237.0/255, green: 78/255, blue: 48/255, alpha: 1.0).CGColor
        ResponseButton.layer.borderWidth = 1.1
        ResponseButton.layer.cornerRadius = 16
        
        //UITEXTVIEW 
        Content.backgroundColor = UIColor.clearColor()
        
    }
    
    
}
