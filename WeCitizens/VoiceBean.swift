//
//  Issue.swift
//  WeCitizens
//
//  Created by  Harold LIU on 3/3/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import UIKit

class Voice {
    let dateFormatter = NSDateFormatter()
    
    var userEmail:String
    var userName:String
    var user:User? = nil
    
    var id:String? = nil
    var time:NSDate?
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
    
    init(voiceId:String?, email:String, name: String, time:NSDate?, title:String, abstract:String, content:String, status:Bool?, classify:String, focusNum:Int?, city:String, replied:Bool?, images:[UIImage]) {
        self.userEmail = email
        self.userName = name
        
        self.id = voiceId
        self.time = time
        self.title = title
        self.abstract = abstract
        self.content = content
        self.classify = VoiceType(rawValue: classify)!
        if let num = focusNum {
            self.focusNum = num
        }
        self.city = city
        if let isReplied = replied {
            self.isReplied = isReplied
        }
        if let _ = status {
            self.status = status!
        }
        self.images = images
        
        dateFormatter.dateFormat = "yyyy.MM.dd"
    }
    
    func getDateString() -> String {        
        return dateFormatter.stringFromDate(time!)
    }
    
}