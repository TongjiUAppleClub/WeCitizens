//
//  Issue.swift
//  WeCitizens
//
//  Created by  Harold LIU on 3/3/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import UIKit

enum IssueClassify:String {
    case Test = "test"
}

class Issue {
    var userEmail:String
    var userName:String
    
    var time:NSDate?
    var title:String
    var abstract:String
    var content:String
    var classify:IssueClassify
    var focusNum:Int = 1
    var city:String
    var isReplied:Bool = false
    var replyId = ""
    var images:[UIImage] = []
    
    init(email:String, name: String, time:NSDate?, title:String, abstract:String, content:String, classify:String, focusNum:Int?, city:String, replied:Bool?, images:[UIImage]) {
        self.userEmail = email
        self.userName = name
        
        self.time = time
        self.title = title
        self.abstract = abstract
        self.content = content
        self.classify = IssueClassify(rawValue: classify)!
        if let num = focusNum {
            self.focusNum = num
        }
        self.city = city
        if let isReplied = replied {
            self.isReplied = isReplied
        }
        self.images = images
    }
    
}