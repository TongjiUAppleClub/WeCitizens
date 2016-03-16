//
//  UserBean.swift
//  WeCitizens
//
//  Created by Teng on 3/15/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import UIKit

class User {
    var avatar:UIImage?
    var name:String
    var email:String
    var resume:Int
    
    init(image:UIImage?, name:String, email:String, resume:Int) {
        self.avatar = image
        self.name = name
        self.email = email
        self.resume = resume
    }
}