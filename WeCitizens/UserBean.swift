//
//  UserBean.swift
//  WeCitizens
//
//  Created by Teng on 3/15/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import UIKit

class User: Bean {
    var avatar:UIImage?
    var resume:Int
    var voiceNum:Int
    var focusNum:Int
    
    init(imageFromRemote image:UIImage?, name:String, email:String, resume:Int, voiceNum:Int, focusNum:Int) {
        self.avatar = image

        self.resume = resume
        self.voiceNum = voiceNum
        self.focusNum = focusNum
        
        super.init(email: email, name: name)
    }
}