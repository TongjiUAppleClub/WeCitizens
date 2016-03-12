//
//  VoiceTitleTableViewCell.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/22/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class VoiceTitleTableViewCell: CommentTableViewCell {

//MARK:- Params
    
    @IBOutlet weak var CheckResponseButton: UIButton!

    
    
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
       
        //Configure the Button
        CheckResponseButton.layer.borderColor = UIColor(red: 237.0/255, green: 78/255, blue: 48/255, alpha: 1.0).CGColor
        CheckResponseButton.layer.borderWidth = 1.1
        CheckResponseButton.layer.cornerRadius = CheckResponseButton.frame.height/2
        
        
    }
    
    
}
