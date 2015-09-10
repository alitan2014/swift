//
//  DoctorModel.swift
//  Heath
//
//  Created by TCL on 15/8/20.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit

class DoctorModel: NSObject {
    var expertid:String!//医生ID
    var expertpicpath:String!//医生头像
    var expertname:String!//医生姓名
    var experttitle:String!//医生头衔
    var expertvisittime:String!//出诊时间
    override func  setValue(value: AnyObject?, forUndefinedKey key: String) {
    
    }
}
