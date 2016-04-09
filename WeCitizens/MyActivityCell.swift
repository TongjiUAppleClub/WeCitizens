//
//  MyActivityCell.swift
//  WeCitizens
//
//  Created by  Harold LIU on 4/9/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class MyActivityCell: UITableViewCell {

    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Activity: UILabel!
    @IBOutlet weak var Title: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        ConfigureUI()
    }

    
    func ConfigureUI()
    {
        self.layer.cornerRadius = 10
        Avatar = UIImageView.lxd_CircleImage(Avatar, borderColor: UIColor.clearColor(), borderWidth: 0)

    }
    
}
