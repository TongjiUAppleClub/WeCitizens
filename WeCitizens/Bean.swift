//
//  Bean.swift
//  WeCitizens
//
//  Created by Teng on 3/28/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Parse

class Bean:PFObject {
    var userEmail:String
    var userName:String
    
    init(email:String, name:String) {
        self.userEmail = email
        self.userName = name
        super.init()
    }
}