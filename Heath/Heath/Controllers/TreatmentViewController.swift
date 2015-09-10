//
//  TreatmentViewController.swift
//  Heath
//
//  Created by Mac on 15/7/13.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit
var treatmentView:TreatmentView!

class TreatmentViewController: UIViewController {
    var IPHONE_WIDTH:CGFloat=UIScreen.mainScreen().bounds.width
    var IPHONE_HEIGHT:CGFloat=UIScreen.mainScreen().bounds.height
    var bodyImgView:UIImageView!
    var kidImgView:UIImageView!
    var manButton:UIButton!
    var womenButton:UIButton!
    var kidButton:UIButton!
    var buttonArr:NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        IPHONE_WIDTH=UIScreen.mainScreen().bounds.width
        IPHONE_HEIGHT=UIScreen.mainScreen().bounds.height
        createUI()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden=false
    }
    func createUI()
    {
        
        var image=UIImage(named:"navigationBar")
        
        self.navigationController?.navigationBar.setBackgroundImage(image, forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent=false
        treatmentView=TreatmentView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)))
        var image1=UIImage(named:"white")!
        var image2=UIImage(named: "btn_share_weibo")!
        
        // 设置中间 segmentView 视图
        let TCLSegmentView=NYSegmentedControl(items: ["人体","列表"])
        TCLSegmentView.titleTextColor=UIColor.whiteColor()
        TCLSegmentView.selectedTitleTextColor=UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1)
        TCLSegmentView.selectedTitleFont=UIFont(name: "heiti SC", size: 13.0)
        TCLSegmentView.segmentIndicatorBackgroundColor=UIColor.whiteColor()
        TCLSegmentView.backgroundColor=UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1)
        TCLSegmentView.borderWidth=0
        TCLSegmentView.segmentIndicatorBorderWidth=0
        TCLSegmentView.segmentIndicatorInset=1.0
        TCLSegmentView.sizeToFit()
        //foursquareSegmentedControl.segmentIndicatorBorderColor = self.view.tintColor;
        TCLSegmentView.cornerRadius=CGRectGetHeight(TCLSegmentView.frame)/2.0
        TCLSegmentView.addTarget(self, action: Selector("valueChange:"), forControlEvents: UIControlEvents.ValueChanged)
        self.navigationItem.titleView=TCLSegmentView
        

        
        //创建其他身体症状
        let bodyOtherButton:UIButton=UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        bodyOtherButton.frame=CGRectMake(IPHONE_WIDTH-120, 20 , 100, 20)
        bodyOtherButton.setTitle("其他全身症状", forState: UIControlState.Normal)
        bodyOtherButton.setTitleColor(UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1), forState: UIControlState.Normal)
        bodyOtherButton.tag=110;
        bodyOtherButton.titleLabel?.font=UIFont(name: "heiti SC", size: 15)
        bodyOtherButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(bodyOtherButton)
        var height=IPHONE_HEIGHT-250
        //创建身体图片
        bodyImgView=UIImageView()
        //创建儿童身体图片
        kidImgView=UIImageView()
        if IPHONE_HEIGHT==480
        {
            height=IPHONE_HEIGHT-260
            bodyImgView.frame=CGRectMake(IPHONE_WIDTH/2-65, 60, 130, 290)
            kidImgView.frame=CGRectMake(IPHONE_WIDTH/2-65, 80, 130, 250)
        }else if IPHONE_HEIGHT==568
        {
            height=IPHONE_HEIGHT-280
            bodyImgView.frame=CGRectMake(IPHONE_WIDTH/2-75, 60, 150, 360)
            kidImgView.frame=CGRectMake(IPHONE_WIDTH/2-75, 80, 150, 310)
        }else if IPHONE_HEIGHT==667
        {
            height=IPHONE_HEIGHT-300
            bodyImgView.frame=CGRectMake(IPHONE_WIDTH/2-85, 65, 170, 410)
            kidImgView.frame=CGRectMake(IPHONE_WIDTH/2-85, 85, 170, 360)
        }else
        {
            height=IPHONE_HEIGHT-320
            bodyImgView.frame=CGRectMake(IPHONE_WIDTH/2-100, 80, 200, 450)
            kidImgView.frame=CGRectMake(IPHONE_WIDTH/2-100, 100, 200, 390)
        }
        
        
        bodyImgView.image=UIImage(named: "man_front")
        self.view .addSubview(bodyImgView)
        self.view.addSubview(kidImgView)
        var normalImage=UIImage(named: "btn_checkbox")
        var selectedImage=UIImage(named: "btn_dot_active")
        
        manButton=UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        manButton.frame=CGRectMake(20, height, 40, 40)
        manButton.layer.cornerRadius=20
        manButton.clipsToBounds=true
        manButton.selected=true
        manButton.setTitle("男性", forState: UIControlState.Normal)
        manButton.titleLabel?.font=UIFont(name: "heiti SC", size: 15)
        manButton.setTitleColor(UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1), forState: UIControlState.Normal)
        manButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        manButton.setBackgroundImage(selectedImage, forState: UIControlState.Selected)
         manButton.setBackgroundImage(normalImage, forState: UIControlState.Normal)
        manButton.tag=10
        manButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(manButton)
        height += CGRectGetHeight(manButton.frame)
        
        womenButton=UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        womenButton.frame=CGRectMake(20, height+10, 40, 40)
        womenButton.layer.cornerRadius=20
        womenButton.clipsToBounds=true
        womenButton.setTitle("女性", forState: UIControlState.Normal)
        womenButton.titleLabel?.font=UIFont(name: "heiti SC", size: 15)
        womenButton.setTitleColor(UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1), forState: UIControlState.Normal)
        womenButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        womenButton.setBackgroundImage(selectedImage, forState: UIControlState.Selected)
        womenButton.setBackgroundImage(normalImage, forState: UIControlState.Normal)
        womenButton.tag=20
        womenButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(womenButton)
        height+=CGRectGetHeight(womenButton.frame)+10
        
        kidButton=UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        kidButton.frame=CGRectMake(20, height+10, 40, 40)
        kidButton.layer.cornerRadius=20
        kidButton.clipsToBounds=true
        kidButton.setTitle("儿童", forState: UIControlState.Normal)
        kidButton.titleLabel?.font=UIFont(name: "heiti SC", size: 15)
        kidButton.setTitleColor(UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1), forState: UIControlState.Normal)
        kidButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        kidButton.setBackgroundImage(selectedImage, forState: UIControlState.Selected)
        kidButton.setBackgroundImage(normalImage, forState: UIControlState.Normal)
        kidButton.tag=30
        kidButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(kidButton)
        buttonArr=[manButton,womenButton,kidButton]
        
        
        var switchButton=UIButton.buttonWithType(UIButtonType.Custom)as! UIButton;
        switchButton.frame=CGRectMake(IPHONE_WIDTH-80, height+10, 60, 30)
        
        var faceImage=UIImage(named: "intelligent_diagnosis_btn_front")
        var backImage=UIImage(named: "intelligent_diagnosis_btn_back")
        switchButton.setImage(faceImage, forState: UIControlState.Normal)
        switchButton.setImage(backImage, forState: UIControlState.Selected)
        switchButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        switchButton.tag=200;
        self.view.addSubview(switchButton)
    }
    func valueChange(sender:NYSegmentedControl)
    {
        
    }
    func btnClick(sender:UIButton)
    {
        if sender.tag==200//点击了正反面
        {
            if sender.selected == true
            {
                sender.selected=false
                changeImage(true)
            }else
            {
                sender.selected=true
                changeImage(false)
            }
        }else if sender.tag==110//点击其他全身症状
        {
            var symptom=SymptomViewController()
            if manButton.selected==true
            {
                symptom.typeNum=1
                symptom.personType="男性"
            }else if womenButton.selected==true
            {
                symptom.typeNum=2
                symptom.personType="女性"
            }else if kidButton.selected==true
            {
                symptom.typeNum=3
                symptom.personType="儿童"
            }
            symptom.navigationController?.hidesBottomBarWhenPushed=true
            self.navigationController?.pushViewController(symptom, animated: true)
        }else
        {
            if sender.selected == true
            {
                sender.selected=false
                
            }else
            {
                sender.selected=true
                
            }
            
            for var i=0;i<3;i++
            {
                var button=buttonArr[i]as! UIButton
                if button.tag==sender.tag
                {
                    changeImage(true)
                    
                }else
                {
                    
                    button.selected=false
                    
                }
            }
        }
        
        
        
        
    }
    func changeImage(face:Bool)
    {
        if manButton.selected==true
        {
            kidImgView.hidden=true
            bodyImgView.hidden=false
            var faceImage=UIImage(named: "man_front")
            var backImage=UIImage(named: "man_back_view")
            if face==true
            {
                bodyImgView.image=faceImage
            }else
            {
                bodyImgView.image=backImage
            }
            
        }else if womenButton.selected==true
        {
            kidImgView.hidden=true
            bodyImgView.hidden=false
            var faceImage=UIImage(named: "woman_front")
            var backImage=UIImage(named: "woman_back_view")
            if face==true
            {
                bodyImgView.image=faceImage
            }else
            {
                bodyImgView.image=backImage
            }
        }else if kidButton.selected==true
        {
            bodyImgView.hidden=true
            kidImgView.hidden=false
            var faceImage=UIImage(named: "kid_front")
            var backImage=UIImage(named: "kid_back_view")
            if face==true
            {
                kidImgView.image=faceImage
            }else
            {
                kidImgView.image=backImage
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
