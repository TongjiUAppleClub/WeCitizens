//
//  CommentBean.swift
//  WeCitizens
//
//  Created by Teng on 3/12/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import UIKit

class Comment: Bean {
    var user:User?
    
    var voiceId:String
    var content:String
    
    init(emailFromLocal email:String, name:String, voiceId:String, content:String) {
        self.voiceId = voiceId
        self.content = content
        
        super.init(email: email, name: name)
    }
    
    init(emailFromRemote email:String, name:String, date:NSDate, voiceId:String, content:String) {
        self.voiceId = voiceId
        self.content = content

        super.init(dateFromRemote: date, email: email, name: name)
    }
}