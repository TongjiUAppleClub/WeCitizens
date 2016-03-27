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
    var level1Num:Int//满意
    var level2Num:Int//较满意
    var level3Num:Int//较不满意
    var level4Num:Int//不满意
    var attitude:Int? = nil
    
    var satisfaction:Float32{
        get {
            return Float32((level1Num + level2Num + level3Num + level4Num)/10)
        }
    }
    
    var level1:Float32 {
        get {
            let tmp = level1Num*100/(level1Num + level2Num + level3Num + level4Num)
            return Float32(Float32(tmp)/100)
        }
    }
    
    var level2:Float32 {
        get {
            let tmp = level2Num*100/(level1Num + level2Num + level3Num + level4Num)
            return Float32(Float32(tmp)/100)
        }
    }

    var level3:Float32 {
        get {
            let tmp = level3Num*100/(level1Num + level2Num + level3Num + level4Num)
            return Float32(Float32(tmp)/100)
        }
    }

    var level4:Float32 {
        get {
            let tmp = level4Num*100/(level1Num + level2Num + level3Num + level4Num)
            return Float32(Float32(tmp)/100)
        }
    }

    
    init(num1:Int, num2:Int, num3:Int, num4:Int) {
        self.level1Num = num1
        self.level2Num = num2
        self.level3Num = num3
        self.level4Num = num4
    }
}

class Reply {
    var userEmail:String
    var userName:String
    var user:User? = nil
    
    var title:String
    var time:NSDate?
    var issueId:String
    var content:String
    var city:String
    var satisfyLevel:Satisfy? = nil
    var images:[UIImage]
    
    init(email:String, name:String, time:NSDate?, issueId:String, title:String, content:String, city:String, level:Satisfy?, images:[UIImage]) {
        self.userEmail = email
        self.userName = name

        self.title = title
        self.time = time
        self.issueId = issueId
        self.content = content
        self.city = city
        
        if let _ = level {
            self.satisfyLevel = level!
        } else {
            self.satisfyLevel = Satisfy(num1: 0, num2: 0, num3: 0, num4: 0)
        }
        self.images = images
    }
    
}