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

    func ConfigureUI()
    {
        self.backgroundColor = UIColor(red: 249/255, green: 251/255, blue: 255/255, alpha: 1.0)
       
        //Configure the Button
        CheckResponseButton.layer.borderColor = UIColor.lxd_MainBlueColor().CGColor
        CheckResponseButton.layer.borderWidth = 1.1
        CheckResponseButton.layer.cornerRadius = CheckResponseButton.frame.height/2
        
    }
    
    
}
