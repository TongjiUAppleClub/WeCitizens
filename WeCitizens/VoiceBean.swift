//
//  VoiceType.swift
//  WeCitizens
//
//  Created by  Harold LIU on 3/3/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import UIKit

//enum VoiceType:String {
//    case cosumption = "消费"
//    case education = "教育"
//    case environment = "环境"
//    case food = "食品"
//    case house = "居住"
//    case job = "就业"
//    case medicine = "医疗卫生"
//    case more = "其他"
//    case security = "安全"
//    case traffic = "交通"
//}

class Voice: Bean {
    var user:User? = nil
    
    var id:String?
    
    var title:String
    var abstract:String
    var content:String
    var classify:String
    var focusNum:Int = 1
    var city:String
    var isReplied:Bool = false
    var replyId = ""
    var status:Bool = false
    var images:[UIImage] = []
    
    var latitude:Double// = 30.0//纬度
    var longitude:Double// = 130.0//经度
    
    
    init(emailFromLocal email:String, name: String, title:String, abstract:String, content:String, classify:String, city:String, latitude:Double, longitude:Double, images:[UIImage]) {
        
        self.title = title
        self.abstract = abstract
        self.content = content
        self.classify = classify//VoiceType(rawValue: classify)!
        self.city = city
        
        self.latitude = latitude
        self.longitude = longitude
        
        self.images = images
        
        super.init(email: email, name: name)
    }
    
    init(voiceIdFromRemote voiceId:String, email:String, name:String, date:NSDate, title:String, abstract:String, content:String, status:Bool, classify:String, focusNum:Int, city:String, replied:Bool, latitude:Double, longitude:Double, images:[UIImage]) {
        
        self.id = voiceId
        self.title = title
        self.abstract = abstract
        self.content = content
        self.classify = classify//VoiceType(rawValue: classify)!
        self.focusNum = focusNum
        self.city = city
        self.isReplied = replied
        self.status = status
        
        self.latitude = latitude
        self.longitude = longitude
        
        self.images = images
        
        super.init(dateFromRemote: date, email: email, name: name)
    }
}