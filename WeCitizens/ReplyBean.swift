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

class Reply: Bean {
    var user:User? = nil
    
    var title:String
    var voiceId:String
    var content:String
    var city:String
    var satisfyLevel:Satisfy = Satisfy(num1: 0, num2: 0, num3: 0, num4: 0)
    var satisfyDictionary:NSDictionary {
        get {
            let dictionary = NSDictionary()
//            dictionary.setValuesForKeysWithDictionary(["level1" : satisfyLevel.level1Num, "level2": satisfyLevel.level2Num, "level3": satisfyLevel.level3Num, "level4": satisfyLevel.level4Num])
            
            dictionary.setValue(10, forKey: "level1")
            dictionary.setValue(10, forKey: "level2")
            dictionary.setValue(10, forKey: "level3")
            dictionary.setValue(10, forKey: "level4")
            
            return dictionary
        }
    }
    
    var images:[UIImage]
    
    init(emailFromLocal email:String, name:String, voiceId:String, title:String, content:String, city:String, images:[UIImage]) {
        self.title = title
        self.voiceId = voiceId
        self.content = content
        self.city = city
        self.images = images
        super.init(email: email, name: name)
    }
    
    init(emailFromRemote email:String, name:String, title:String, date:NSDate, voiceId:String, content:String, city:String, satisfyLevel:Satisfy, images:[UIImage]) {
        self.title = title
        self.voiceId = voiceId
        self.content = content
        self.city = city
        self.satisfyLevel = satisfyLevel
        self.images = images
        
        super.init(dateFromRemote: date, email: email, name: name)
    }
    
}