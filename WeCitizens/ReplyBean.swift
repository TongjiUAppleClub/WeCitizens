//
//  Revert.swift
//  WeCitizens
//
//  Created by Teng on 3/3/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import UIKit

class Satisfy {
    var level1:Int//满意
    var level2:Int//较满意
    var level3:Int//较不满意
    var level4:Int//不满意
    
    init(num1:Int, num2:Int, num3:Int, num4:Int) {
        self.level1 = num1
        self.level2 = num2
        self.level3 = num3
        self.level4 = num4
    }
}

class Reply {
    var avatar:UIImage?
    var userEmail:String
    var userName:String
    
    var time:NSDate?
    var issueId:String
    var content:String
    var city:String
    var satisfyLevel:Satisfy = Satisfy(num1: 0, num2: 0, num3: 0, num4: 0)
    var images:[UIImage]
    
    init(avatar:UIImage?, email:String, name:String, time:NSDate?, id:String, content:String, city:String, level:Satisfy?, images:[UIImage]) {
        self.avatar = avatar
        self.userEmail = email
        self.userName = name

        self.time = time
        self.issueId = id
        self.content = content
        self.city = city
        
        if let _ = level {
            self.satisfyLevel = level!
        }
        self.images = images
    }
    
}