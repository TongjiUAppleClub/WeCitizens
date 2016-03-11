//
//  Revert.swift
//  WeCitizens
//
//  Created by Teng on 3/3/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation

class Revert {
    var issueId: String
    var content: String
    var userEmail: String
    var userName: String
    
    init(id:String, content:String, email:String, name:String) {
        self.issueId = id
        self.content = content
        self.userEmail = email
        self.userName = name
    }
    
}