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
    


    @IBOutlet weak var ThirdView: RotatedView!
    
    @IBOutlet weak var L1_Button: SSRadioButton!
    @IBOutlet weak var L2_Button: SSRadioButton!
    @IBOutlet weak var L3_Button: SSRadioButton!
    @IBOutlet weak var L4_Button: SSRadioButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }

}
