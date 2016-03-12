//
//  CommentBean.swift
//  WeCitizens
//
//  Created by Teng on 3/12/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import UIKit

class Comment {
    var avatar:UIImage?
    var userEmail:String
    var userName:String
    
    var time:NSDate?
    var issueId:String
    var content:String
    
    init(avatar:UIImage?, email:String, name:String, time:NSDate?, id:String, content:String) {
        self.avatar = avatar
        self.userEmail = email
        self.userName = name
        
        self.time = time
        self.issueId = id
        self.content = content
    }
}