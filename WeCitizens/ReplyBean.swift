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
    var userEmail:String
    var userName:String
    var user:User? = nil
    
    var time:NSDate?
    var issueId:String
    var content:String
    var city:String
    var satisfyLevel = NSDictionary()
    var images:[UIImage]
    
    init(email:String, name:String, time:NSDate?, issueId:String, content:String, city:String, level:Satisfy?, images:[UIImage]) {
        self.userEmail = email
        self.userName = name

        self.time = time
        self.issueId = issueId
        self.content = content
        self.city = city
        
        if let _ = level {
            self.satisfyLevel.setValue(level!.level1, forKey: "level1")
            self.satisfyLevel.setValue(level!.level2, forKey: "level2")
            self.satisfyLevel.setValue(level!.level3, forKey: "level3")
            self.satisfyLevel.setValue(level!.level4, forKey: "level4")
        } else {
            self.satisfyLevel.setValue(0, forKey: "level1")
            self.satisfyLevel.setValue(0, forKey: "level2")
            self.satisfyLevel.setValue(0, forKey: "level3")
            self.satisfyLevel.setValue(0, forKey: "level4")
        }
        self.images = images
    }
    
}