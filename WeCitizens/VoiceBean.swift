//
//  Issue.swift
//  WeCitizens
//
//  Created by  Harold LIU on 3/3/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import UIKit

enum VoiceType:String {
    case cosumption = "消费"
    case education = "教育"
    case environment = "环境"
    case food = "食品"
    case house = "居住"
    case job = "就业"
    case medicine = "医疗卫生"
    case more = "其他"
    case security = "安全"
    case traffic = "交通"
}

class Voice: Bean {
    let dateFormatter = NSDateFormatter()
    
//    var userEmail:String
//    var userName:String
    var user:User? = nil
    
    var id:String?
    var date:NSDate?
    
    var dateStr:String {
        get {
            return dateFormatter.stringFromDate(date!)
        }
    }
    
    var title:String
    var abstract:String
    var content:String
    var classify:VoiceType
    var focusNum:Int = 1
    var city:String
    var isReplied:Bool = false
    var replyId = ""
    var status:Bool = false
    var images:[UIImage] = []
    
    init(fromLocal email:String, name: String, title:String, abstract:String, content:String, classify:String, city:String, images:[UIImage]) {
//        self.userEmail = email
//        self.userName = name
        
        self.title = title
        self.abstract = abstract
        self.content = content
        self.classify = VoiceType(rawValue: classify)!
        self.city = city
        self.images = images
        
        dateFormatter.dateFormat = "yyyy.MM.dd"
    }
    
    init(datafromRemote voiceId:String, email:String, name:String, date:NSDate, title:String, abstract:String, content:String, status:Bool, classify:String, focusNum:Int, city:String, replied:Bool, images:[UIImage]) {
//        self.userEmail = email
//        self.userName = name
        
        self.id = voiceId
        self.title = title
        self.abstract = abstract
        self.content = content
        self.classify = VoiceType(rawValue: classify)!
        self.focusNum = focusNum
        self.city = city
        self.isReplied = replied
        self.status = status
        self.images = images
        
        dateFormatter.dateFormat = "yyyy.MM.dd"
    }
}