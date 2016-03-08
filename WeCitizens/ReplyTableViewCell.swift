//
//  ReplyTableViewCell.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/24/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import FoldingCell

class ReplyTableViewCell: FoldingCell {

//Foreground View
    
    @IBOutlet weak var Favatar: UIImageView!
    @IBOutlet weak var imgContainer: UIView!
    @IBOutlet weak var ResponseTitle: UILabel!
    @IBOutlet weak var FAgency: UILabel!
    @IBOutlet weak var ResponseTime: UILabel!
    @IBOutlet weak var SupportPercent: UILabel!

//Container View
//First
    @IBOutlet weak var CAvatar: UIImageView!
    @IBOutlet weak var CAgency: UILabel!
    @IBOutlet weak var CTitle: UILabel!
    @IBOutlet weak var CContent: UITextView!
//Second
    @IBOutlet weak var CimgContainer: UIView!
    @IBOutlet weak var CResponseTime: UILabel!
    @IBOutlet weak var CResponseButton: UIButton!
//Third 
    @IBOutlet weak var EvaluateButton: UIButton!
    @IBOutlet weak var CheckHistoryButton: UIButton!
    
    
    
    
    @IBOutlet weak var ThirdView: RotatedView!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
    func configureUI()
    {
        foregroundView.layer.cornerRadius = 8
        
        Favatar.layer.masksToBounds = false
        Favatar.layer.cornerRadius = Favatar.frame.height/2
        Favatar.clipsToBounds = true
        
        imgContainer.layer.cornerRadius = 5
        
        containerView.layer.cornerRadius = 8
        
        CAvatar.layer.masksToBounds = false
        CAvatar.layer.cornerRadius = CAvatar.frame.height/2
        CAvatar.clipsToBounds = true
        CimgContainer.layer.cornerRadius = 5
        CResponseButton.layer.borderColor = UIColor(red: 243.0/255, green: 77/255, blue: 54/255, alpha: 1.0).CGColor
        CResponseButton.layer.borderWidth = 1.3
        CResponseButton.layer.cornerRadius = CResponseButton.frame.height/2
        
    }
    
    
}
