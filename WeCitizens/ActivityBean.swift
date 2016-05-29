//
//  ActivityBean.swift
//  WeCitizens
//
//  Created by Teng on 5/18/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation

class Activity:Bean {
    var title:String
    var content:String
    
    init (email:String, name:String, title:String, content:String) {
        self.title = title
        self.content = content
        
        super.init(email: email, name: name)
    }
    
    init (email:String, name:String, title:String, content:String, date:NSDate) {
        self.title = title
        self.content = content
        
        super.init(dateFromRemote: date, email: email, name: name)
    }
}