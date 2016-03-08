//
//  Issue.swift
//  WeCitizens
//
//  Created by Teng on 3/3/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation

class Issue {
    var avatar:NSData?
    var userEmail:String
    var userName:String
    var content:String
    var focusNum:Int = 1
    var abstract:String
    var image1:NSData?
    var image2:NSData?
    var image3:NSData?
    var image4:NSData?
    var image5:NSData?
    var image6:NSData?
    var image7:NSData?
    var image8:NSData?
    var image9:NSData?
    
    init(email:String, name: String, content:String, abstract:String) {
        self.userEmail = email
        self.userName = name
        self.content = content
        self.abstract = abstract
    }
}