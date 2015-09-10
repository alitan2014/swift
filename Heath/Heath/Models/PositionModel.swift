//
//  PositionModel.swift
//  Heath
//
//  Created by TCL on 15/8/20.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit

class PositionModel: NSObject {
    var ID:String!// "id":"38",
    var jbname:String!//"jbname":"眼部",
    var jblistArr:NSMutableArray!
//    "jblist":[
//    {
//    "id":"47",
//    "jbname":"444"
//    },
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if key=="id"
        {
            self.ID = value as!String
        }else if key == "jblist"
        {
            self.jblistArr=NSMutableArray()
            
            
                if (value != nil)
                {
                    for var i=0;i<value?.count;i++
                    {
                        var model=JBModel.alloc()
                        var dic:NSDictionary=value!.objectAtIndex(i) as!NSDictionary
                        model.setValuesForKeysWithDictionary(dic as![NSObject:AnyObject])
                        self.jblistArr.addObject(model)
                    }
//                    for dic in value as!NSArray
//                    {
//                        model.setValuesForKeysWithDictionary(dic as! [NSObject : AnyObject])
//                        self.jblistArr.addObject(model)
//                       
//                        
//                    }
                    
                }
         
        }else
        {
            super.setValue(value, forKey: key)
        }
    }
}
