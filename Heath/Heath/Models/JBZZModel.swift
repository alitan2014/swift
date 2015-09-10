//
//  JBZZModel.swift
//  Heath
//
//  Created by TCL on 15/8/20.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit

class JBZZModel: NSObject {
    var ksname:String!
    var xgjyArr:NSMutableArray!
    var ystj:NSArray!
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "xgjy"
        {
            self.xgjyArr=NSMutableArray()
            if value != nil
            {
                for  dic in value as!NSArray
                {
                    
                    var model:XGJYModel=XGJYModel()
                    model.setValuesForKeysWithDictionary(dic as! [NSObject:AnyObject])
                    self.xgjyArr.addObject(model)
                }
            }
        }else
        {
            super.setValue(value, forKey: key)
        }
    }

}
