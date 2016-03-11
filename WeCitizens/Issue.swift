//
//  Issue.swift
//  WeCitizens
//
//  Created by  Harold LIU on 3/3/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import UIKit

//class Issue {
//    
//    var issueTitle:String = ""
//    var issueAbstract:String = ""
//    var issueClassify:String = ""
//    var issueTime:String = ""
//    var issueReplied:Bool = false
//    var issueImages:[UIImage] = []
//    var browseTime:String = ""
//    
//    var userAvatar:UIImage = UIImage()
//    var userName:String = ""
//    var userResume: String = ""
//
//    
//}

enum IssueClassify:String {
    case Test1 = "test"
}

class Issue {
    var avatar:UIImage?
    var userEmail:String
    var userName:String
    var userResume:String?
    
    var title:String
    var time:String?
    var classify:IssueClassify
    var isReplied:Bool = false
    var content:String
    var focusNum:Int = 1
    var abstract:String
    var images:[UIImage]
    
    init(email:String, name: String, title:String, classify:String, content:String, abstract:String, images:[UIImage]) {
        self.userEmail = email
        self.userName = name
        
        self.title = title
        self.content = content
        self.abstract = abstract
        self.images = images
        self.classify = .Test1
    }
    
}