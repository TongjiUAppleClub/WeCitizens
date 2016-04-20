//
//  PFError.swift
//  WeCitizens
//
//  Created by Teng on 4/4/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import Foundation

func convertPFNSErrorToMssage(errorCode:Int) -> (String, String) {
    var errorMessage = (label:"未知错误", detail:"出现错误，无法完成当前操作")
    
    switch errorCode {
    case 100:
        errorMessage.label = "无法连接到服务器"
        errorMessage.detail = "请打开网路连接"
    default:
        print("other error")
    }
    
    return errorMessage
}