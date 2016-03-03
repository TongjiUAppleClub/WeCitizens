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
    @IBOutlet weak var BrowseNum: UILabel!
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
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1.2
        self.layer.borderColor = UIColor.clearColor().CGColor
        
        
       // self.layer.addBorder(.Bottom, color: UIColor(red: 124/255, green: 124/255, blue: 124/255, alpha: 1.0), thickness: 1.8)
        //make avatar circle
        Avatar.layer.masksToBounds = false
        Avatar.layer.borderWidth = 1
        Avatar.layer.borderColor = UIColor.clearColor().CGColor
        Avatar.layer.cornerRadius = Avatar.frame.height/2
        Avatar.clipsToBounds = true
        // make reputation circle
        Reputation.layer.masksToBounds = false
        Reputation.layer.borderWidth = 0.2
        Reputation.layer.borderColor = UIColor(red: 249/255, green: 251/255, blue: 255/255, alpha: 1.0).CGColor
        Reputation.layer.cornerRadius = Reputation.frame.height/2
        Reputation.clipsToBounds = true
        // Images Containter
        ImgesContainer.layer.masksToBounds = false
        ImgesContainer.layer.cornerRadius = 10
        ImgesContainer.layer.borderWidth = 1.2
        ImgesContainer.layer.borderColor = UIColor.clearColor().CGColor
        
    }
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.Top:
            border.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), thickness)
            break
        case UIRectEdge.Bottom:
            border.frame = CGRectMake(0, CGRectGetHeight(self.frame) - thickness, CGRectGetWidth(self.frame), thickness)
            break
        case UIRectEdge.Left:
            border.frame = CGRectMake(0, 0, thickness, CGRectGetHeight(self.frame))
            break
        case UIRectEdge.Right:
            border.frame = CGRectMake(CGRectGetWidth(self.frame) - thickness, 0, thickness, CGRectGetHeight(self.frame))
            break
        default:
            break
        }
        
        border.backgroundColor = color.CGColor;
        
        self.addSublayer(border)
    }
}

