//
//  WomenHeadView.swift
//  Heath
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit
typealias senderTouchBlock=(touch:UITouch,state:String)->Void
typealias senderButtonBlock=(sender:UIButton)->Void
class WomenHeadView: UIView {
    var sendTouchBlock:senderTouchBlock!
    var sendButtonBlock:senderButtonBlock!
    @IBOutlet weak var mouthImageView: UIImageView!//嘴巴
    @IBOutlet weak var noseImageView: UIImageView!//鼻子
    @IBOutlet weak var faceImageView: UIImageView!//面部
    @IBOutlet weak var eyesImageView: UIImageView!//眼睛
    @IBOutlet weak var earsImageView: UIImageView!//耳朵
    @IBOutlet weak var headImageView: UIImageView!//头部
    @IBOutlet weak var backButton: UIButton!
    func createUI()
    {
        self.backgroundColor=UIColor.whiteColor()
        self.backButton.setTitleColor(UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1), forState: UIControlState.Normal)
        mouthImageView.image=nil
        mouthImageView.userInteractionEnabled=true
        faceImageView.image=nil
        noseImageView.image=nil
        earsImageView.image=nil
        eyesImageView.image=nil
        headImageView.image=nil
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let set=touches as NSSet
        let touch:UITouch=set.anyObject() as!UITouch
        let state="began"
        if (self.sendTouchBlock != nil)
        {
            self.sendTouchBlock(touch:touch,state:state)
        }
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let set=touches as NSSet
        let touch:UITouch=set.anyObject() as!UITouch
        let state="ended"
        if (self.sendTouchBlock != nil)
        {
            self.sendTouchBlock(touch:touch,state:state)
        }
    }
    @IBAction func btnClick(sender: AnyObject) {
        if (self.sendButtonBlock != nil)
        {
            self.sendButtonBlock(sender: sender as! UIButton)
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
