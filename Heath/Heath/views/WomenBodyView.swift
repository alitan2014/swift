//
//  WomenBodyView.swift
//  Heath
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit
typealias sendTouchBlock=(touch:UITouch,state:String)->Void
typealias sendButtonBlock=(sender:UIButton)->Void
class WomenBodyView: UIView {
    var sendTouch:sendTouchBlock!
    var sendButton:sendButtonBlock!
    @IBOutlet weak var woManButton: UIButton!
    
    @IBOutlet weak var manButton: UIButton!
    @IBOutlet weak var faceButton: UIButton!
    
    @IBOutlet weak var otherButton: UIButton!
    
    @IBOutlet weak var bodyImgView: UIImageView!
    
    @IBOutlet weak var footImgView: UIImageView!//足部
    @IBOutlet weak var legImgView: UIImageView!//腿部
    @IBOutlet weak var reproductionImgView: UIImageView!//生殖部位
    @IBOutlet weak var handImgView: UIImageView!//手部
    @IBOutlet weak var abdominalImgView: UIImageView!//腹部
     @IBOutlet weak var limbImgView: UIImageView!//上肢
    @IBOutlet weak var chestImgView: UIImageView!//胸部
    @IBOutlet weak var neckImageView: UIImageView!//脖子
       func createUI()
    {
        self.otherButton.setTitleColor(UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1), forState: UIControlState.Normal)
        var normalImage=UIImage(named: "gray_1")
        var selectedImage=UIImage(named: "gray_2")
        
        manButton.setTitle("男性", forState: UIControlState.Normal)
        manButton.titleLabel?.font=UIFont(name: "heiti SC", size: 15)
        //manButton.setTitleColor(UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1), forState: UIControlState.Normal)
        manButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        manButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        manButton.setBackgroundImage(selectedImage, forState: UIControlState.Selected)
        manButton.setBackgroundImage(normalImage, forState: UIControlState.Normal)
        //manButton.layer.cornerRadius=CGRectGetWidth(manButton.frame)/2
        //manButton.clipsToBounds=true
        
        woManButton.setTitle("女性", forState: UIControlState.Normal)
        woManButton.selected=true
        woManButton.titleLabel?.font=UIFont(name: "heiti SC", size: 15)
        woManButton.setTitleColor(UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1), forState: UIControlState.Normal)
        woManButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        woManButton.setBackgroundImage(selectedImage, forState: UIControlState.Selected)
        woManButton.setBackgroundImage(normalImage, forState: UIControlState.Normal)
        woManButton.layer.cornerRadius=CGRectGetWidth(woManButton.frame)/2
        //woManButton.clipsToBounds=true
        woManButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        self.footImgView.image=nil
        self.legImgView.image=nil
        self.reproductionImgView.image=nil
        self.abdominalImgView.image=nil
        self.chestImgView.image=nil
        self.handImgView.image=nil
        self.limbImgView.image=nil
        self.neckImageView.image=nil
       
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let set=touches as NSSet
        let touch=set.anyObject() as!UITouch
        let state="began"
        if (self.sendTouch != nil)
        {
            self.sendTouch(touch: touch,state: state)
        }
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let set=touches as NSSet
        let touch=set.anyObject() as!UITouch
        let state="ended"
        if (self.sendTouch != nil)
        {
            self.sendTouch(touch: touch,state: state)
        }
    }
    @IBAction func btnClick(sender: AnyObject) {
        if (self.sendButton != nil)
        {
            self.sendButton(sender: sender as! UIButton)
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
