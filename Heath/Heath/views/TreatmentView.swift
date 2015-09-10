//
//  TreatmentView.swift
//  Heath
//
//  Created by TCL on 15/8/13.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit
typealias senderViewTouchBlock=(touch:UITouch,state:String)->Void
typealias senderViewButtonBlock=(button:UIButton)->Void
class TreatmentView: UIView {
    var sendTouchBlock:senderViewTouchBlock!
    var sendButtonBlock:senderViewButtonBlock!
    @IBOutlet weak var mouthImageView: UIImageView!//嘴巴
    @IBOutlet weak var faceImageView: UIImageView!//面部
    @IBOutlet weak var noseImageView: UIImageView!//鼻子
    @IBOutlet weak var earsImageView: UIImageView!//耳朵
    @IBOutlet weak var eyesImageView: UIImageView!//眼睛
    @IBOutlet weak var headImageView: UIImageView!//头部
    @IBOutlet weak var backButton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: CGRect())
       
    }
    required  init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
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
    //开始触摸图片
    func imgViewBeganTouch(touch:UITouch)
    {
        var view=touch.view
        let tag=view.tag
        switch tag
        {
        case 10:
            self.mouthImageView.image=UIImage(named: "intelligence_highlight_0304.png")
        case 20:
            self.eyesImageView.image=UIImage(named: "intelligence_highlight_0302")
        case 30:
            self.earsImageView.image=UIImage(named: "intelligence_highlight_0305")
        case 40:
            self.faceImageView.image=UIImage(named: "intelligence_highlight_0306")
        case 50:
            self.noseImageView.image=UIImage(named: "intelligence_highlight_0307")
        case 60:
            self.headImageView.image=UIImage(named: "intelligence_highlight_0301")
        
        default:
            println()
        }
        
    }
    //结束触摸图片
    func imgViewEndedTouch(touch:UITouch)
    {
        var view=touch.view
        let tag=view.tag
        var symptom=SymptomViewController()
        switch tag
        {
        case 10:
            self.mouthImageView.image=UIImage(named: "intelligence_highlight_0304.png")
            
        case 20:
            self.eyesImageView.image=UIImage(named: "intelligence_highlight_0302")
        case 30:
            self.earsImageView.image=UIImage(named: "intelligence_highlight_0305")
        case 40:
            self.faceImageView.image=UIImage(named: "intelligence_highlight_0306")
        case 50:
            self.noseImageView.image=UIImage(named: "intelligence_highlight_0307")
        case 60:
            self.headImageView.image=UIImage(named: "intelligence_highlight_0301")
            
        default:
            println()
        }
    }
    //开始触摸
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        var set=touches as NSSet
        let touch:UITouch=set.anyObject() as! UITouch
        let state="began"
        if (sendTouchBlock != nil)
        {
            self.sendTouchBlock(touch: touch,state: state)
        }
        imgViewBeganTouch(touch)
    }
    //结束触摸
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        var set=touches as NSSet
        let touch:UITouch=set.anyObject() as! UITouch
        let state="ended"
        if (sendTouchBlock != nil)
        {
            self.sendTouchBlock(touch: touch,state:state)
        }
        imgViewEndedTouch(touch)
    }

    @IBAction func btnClick(sender: AnyObject) {
        if (self.sendButtonBlock != nil)
        {
            self.sendButtonBlock(button: sender as! UIButton)
        }
    }
    
    
    
}
