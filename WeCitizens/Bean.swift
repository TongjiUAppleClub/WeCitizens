//
//  Bean.swift
//  WeCitizens
//
//  Created by Teng on 3/28/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation
import Parse

class Bean {
    let dateFormatter = NSDateFormatter()

    var userEmail:String
    var userName:String
    var date:NSDate?
    var dateStr:String {
        get {
            return dateFormatter.stringFromDate(date!)
        }
    }
    
    init(email:String, name:String) {
        self.userEmail = email
        self.userName = name
        dateFormatter.dateFormat = "yyyy.MM.dd"
    }
    
    init(dateFromRemote date:NSDate, email:String, name:String) {
        self.date = date
        self.userEmail = email
        self.userName = name
        
        dateFormatter.dateFormat = "yyyy.MM.dd"
    }
}