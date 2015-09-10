//
//  GuideView.swift
//  Heath
//
//  Created by TCL on 15/8/17.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit
typealias senderBlock=(titleArr:NSArray)->Void
typealias senderViewBlock=(UIButton)->Void
typealias senderDepatrmentBlock=(String,NSArray)->Void
class GuideView: UIView {
    var bgView:UIView!
    var activity:UIActivityIndicatorView!
    var personTypeLabel:UILabel!//比如 男性 女性 儿童
    var bodyTypeLabel:UILabel!//比如 头部 腿部 等等。。。
    var symptomTypeLabel:UILabel!//比如 内科 。。。
    var backButton:UIButton!//返回按钮
    var sendBock:senderBlock?
    var sendButtonBlock:senderViewBlock!
    var sendDepartment:senderDepatrmentBlock!
    var IPHONE_WIDTH:CGFloat=UIScreen.mainScreen().bounds.width
    var IPHONE_HEIGHT:CGFloat=UIScreen.mainScreen().bounds.height
    var tableHeaderView:UIView!
    var tableView:UITableView!
    var sytomView:UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        var IPHONE_WIDTH:CGFloat=UIScreen.mainScreen().bounds.width
        var IPHONE_HEIGHT:CGFloat=UIScreen.mainScreen().bounds.height
        createUI()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI()
    {
        self.bgView=UIView(frame: CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT))
        self.bgView.backgroundColor=UIColor.grayColor()
        self.bgView.alpha=0.5
        self.activity=UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        self.activity.frame=CGRectMake(IPHONE_WIDTH/2-50, IPHONE_HEIGHT/2-50-64, 100, 100)
        self.activity.backgroundColor=UIColor.blackColor()
        self.bgView.addSubview(self.activity)
        
        self.backButton=UIButton.buttonWithType(UIButtonType.Custom)as! UIButton
        self.backButton.frame=CGRectMake(0, 0, 40, 40)
        self.backButton.setImage(UIImage(named: "back"), forState: UIControlState.Normal)
        self.backButton.tag=100;
        self.backButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.tableHeaderView=UIView(frame: CGRectMake(0, 0, IPHONE_WIDTH, 400))
        
        var height:CGFloat=50
        var bgImgView=UIImageView(frame: CGRectMake(0, 0, IPHONE_WIDTH, height))
        bgImgView.image=UIImage(named: "gray@2x-2")
        bgImgView.backgroundColor=UIColor(red: 231/225.0, green: 231/255.0, blue: 231/255.0, alpha: 1)
        
        self.tableHeaderView.addSubview(bgImgView)
        var image=UIImage(named: "arrow")
        
        
        var  departmentLabel:UILabel=UILabel()
        var experienceLabel:UILabel=UILabel()
        var doctorLabel:UILabel=UILabel()
        var typeLabel:UILabel=UILabel()
        var height1:CGFloat=0
        
        var grayImgView2=UIImageView()
        if IPHONE_HEIGHT==480
        {
           bgImgView.frame=CGRectMake(0, 0, IPHONE_WIDTH, 50)
            var width:CGFloat
            
            self.personTypeLabel=UILabel(frame: CGRectMake(0, 0, 70, 50))
            bgImgView.addSubview(self.personTypeLabel)
            width=CGRectGetWidth(self.personTypeLabel.frame)
            var imageView=UIImageView(frame: CGRectMake(width, 0, 20, 50))
            imageView.image=image
            bgImgView.addSubview(imageView)
            width += CGRectGetWidth(imageView.frame)
            self.bodyTypeLabel=UILabel(frame: CGRectMake(width, 0, 70, 50))
            bgImgView.addSubview(self.bodyTypeLabel)
            width += CGRectGetWidth(self.bodyTypeLabel.frame)
            var imageView1=UIImageView(frame: CGRectMake(width, 0, 20, 50))
            imageView1.image=image
            bgImgView.addSubview(imageView1)
            width += CGRectGetWidth(imageView1.frame)
            self.symptomTypeLabel=UILabel(frame: CGRectMake(width, 0, IPHONE_WIDTH-width, 50))
            bgImgView.addSubview(self.symptomTypeLabel)
            height1 += CGRectGetHeight(bgImgView.frame)
            
            
            
            var imgView=UIImageView(frame: CGRectMake(10, height1+20, 60, 60))
            imgView.image=UIImage(named: "image_1")
            self.tableHeaderView.addSubview(imgView)
            departmentLabel.frame = CGRectMake(CGRectGetWidth(imgView.frame)+20, height1+20, IPHONE_WIDTH-150, 30)
            departmentLabel.text="参考科室：消化内科"
            departmentLabel.font=UIFont(name: "heiti SC", size: 15)
            self.tableHeaderView.addSubview(departmentLabel)
            var consultationLabel:UILabel=UILabel(frame: CGRectMake(CGRectGetWidth(imgView.frame)+20, height1+20+30, IPHONE_WIDTH-180, 30))
            consultationLabel.text="病况因人而异 建议先咨询"
            consultationLabel.font=UIFont(name: "heiti SC", size: 12)
            consultationLabel.textColor=UIColor.grayColor()
            self.tableHeaderView.addSubview(consultationLabel)
            var consultionButton:UIButton=UIButton.buttonWithType(UIButtonType.Custom)as! UIButton
            consultionButton.tag=200
            consultionButton.setTitleColor(UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1), forState: UIControlState.Normal)
            consultionButton.setTitle("咨询", forState: UIControlState.Normal)
            consultionButton.setImage(UIImage(named: "image_2"), forState: UIControlState.Normal)
            consultionButton.titleEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0)
            consultionButton.frame=CGRectMake(IPHONE_WIDTH-100, height1+30, 80, 40)
            consultionButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
            height1 += CGRectGetHeight(imgView.frame)+20
            var grayImgView=UIImageView(frame: CGRectMake(0, height1+20, IPHONE_WIDTH, 40))
            grayImgView.image=UIImage(named: "gray")
            self.tableHeaderView.addSubview(grayImgView)
           experienceLabel.frame = CGRectMake(20, 0, IPHONE_WIDTH-40, 40)
            experienceLabel.text="打嗝"
            experienceLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
          
            grayImgView.addSubview(experienceLabel)

            self.tableHeaderView.addSubview(consultionButton)
            height1 += CGRectGetHeight(grayImgView.frame)+20
            
            
            
            
            
            self.sytomView=UIView(frame: CGRectMake(0, height1, IPHONE_WIDTH, 50))
            self.tableHeaderView.addSubview(self.sytomView)
            //height1 += CGRectGetHeight(self.sytomView.frame)
            
            grayImgView2.frame=CGRectMake(0, height1+10, self.IPHONE_WIDTH, 40)
            grayImgView2.image=UIImage(named: "gray")
            self.tableHeaderView.addSubview(grayImgView2)
            typeLabel.frame=CGRectMake(20, 0, IPHONE_WIDTH-40, 40)
            grayImgView2.addSubview(typeLabel)
            typeLabel.text="消化科"
            
            typeLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
            
        
        }else if IPHONE_HEIGHT==568
        {
        
            bgImgView.frame=CGRectMake(0, 0, IPHONE_WIDTH, height)
            var width:CGFloat
            
            self.personTypeLabel=UILabel(frame: CGRectMake(0, 0, 70, height))
            bgImgView.addSubview(self.personTypeLabel)
            width=CGRectGetWidth(self.personTypeLabel.frame)
            var imageView=UIImageView(frame: CGRectMake(width, 0, 20, height))
            imageView.image=image
            bgImgView.addSubview(imageView)
            width += CGRectGetWidth(imageView.frame)
            self.bodyTypeLabel=UILabel(frame: CGRectMake(width, 0, 70, height))
            bgImgView.addSubview(self.bodyTypeLabel)
            width += CGRectGetWidth(self.bodyTypeLabel.frame)
            var imageView1=UIImageView(frame: CGRectMake(width, 0, 20, height))
            imageView1.image=image
            bgImgView.addSubview(imageView1)
            width += CGRectGetWidth(imageView1.frame)
            self.symptomTypeLabel=UILabel(frame: CGRectMake(width, 0, IPHONE_WIDTH-width, height))
            bgImgView.addSubview(self.symptomTypeLabel)
            height1 += CGRectGetHeight(bgImgView.frame)
            
            
            
            var imgView=UIImageView(frame: CGRectMake(10, height1+20, 60, 60))
            imgView.image=UIImage(named: "image_1")
            self.tableHeaderView.addSubview(imgView)
            departmentLabel.frame=CGRectMake(CGRectGetWidth(imgView.frame)+20, height1+20, IPHONE_WIDTH-150, 30)
            departmentLabel.text=NSString.localizedStringWithFormat("参考科室：%@", "消化内科") as String
            departmentLabel.font=UIFont(name: "heiti SC", size: 15)
            self.tableHeaderView.addSubview(departmentLabel)
            var consultationLabel:UILabel=UILabel(frame: CGRectMake(CGRectGetWidth(imgView.frame)+20, height1+20+30, IPHONE_WIDTH-180, 30))
            consultationLabel.text="病况因人而异 建议先咨询"
            consultationLabel.font=UIFont(name: "heiti SC", size: 12)
            consultationLabel.textColor=UIColor.grayColor()
            self.tableHeaderView.addSubview(consultationLabel)
            var consultionButton:UIButton=UIButton.buttonWithType(UIButtonType.Custom)as! UIButton
            consultionButton.tag=200
            consultionButton.setTitleColor(UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1), forState: UIControlState.Normal)
            consultionButton.setTitle("咨询", forState: UIControlState.Normal)
            consultionButton.setImage(UIImage(named: "image_2"), forState: UIControlState.Normal)
            consultionButton.titleEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0)
            consultionButton.frame=CGRectMake(IPHONE_WIDTH-100, height1+30, 80, 40)
            consultionButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
            height1 += CGRectGetHeight(imgView.frame)+20
            var grayImgView=UIImageView(frame: CGRectMake(0, height1+20, IPHONE_WIDTH, 40))
            grayImgView.image=UIImage(named: "gray")
            self.tableHeaderView.addSubview(grayImgView)
            experienceLabel.frame = CGRectMake(20, 0, IPHONE_WIDTH-40, 40)
            experienceLabel.text="打嗝"
            experienceLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
            grayImgView.addSubview(experienceLabel)
            
            self.tableHeaderView.addSubview(consultionButton)
            height1 += CGRectGetHeight(grayImgView.frame)+20
            
            self.sytomView=UIView(frame: CGRectMake(0, height1+10, IPHONE_WIDTH, 50))
            self.tableHeaderView.addSubview(self.sytomView)
            //height1 += CGRectGetHeight(self.sytomView.frame)
            
            grayImgView2.frame=CGRectMake(0, height1+10, self.IPHONE_WIDTH, 40)
            grayImgView2.image=UIImage(named: "gray")
            self.tableHeaderView.addSubview(grayImgView2)
            typeLabel.frame=CGRectMake(20, 0, IPHONE_WIDTH-40, 40)
            grayImgView2.addSubview(typeLabel)
            typeLabel.text="消化科"
            typeLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
            
            
           
        }else if IPHONE_HEIGHT==667
        {
            var frame=self.tableHeaderView.frame
            frame.size.height=410
            self.tableHeaderView.frame=frame
            var width:CGFloat
            self.personTypeLabel=UILabel(frame: CGRectMake(0, 0, 90, height))
            bgImgView.addSubview(self.personTypeLabel)
            width=CGRectGetWidth(self.personTypeLabel.frame)
            var imageView=UIImageView(frame: CGRectMake(width, 0, 20, height))
            imageView.image=image
            bgImgView.addSubview(imageView)
            width += CGRectGetWidth(imageView.frame)
            self.bodyTypeLabel=UILabel(frame: CGRectMake(width, 0, 90, height))
            bgImgView.addSubview(self.bodyTypeLabel)
             width += CGRectGetWidth(self.bodyTypeLabel.frame)
            var imageView1=UIImageView(frame: CGRectMake(width, 0, 20, height))
            imageView1.image=image
            bgImgView.addSubview(imageView1)
            width += CGRectGetWidth(imageView1.frame)
            self.symptomTypeLabel=UILabel(frame: CGRectMake(width, 0, IPHONE_WIDTH-width, height))
            bgImgView.addSubview(self.symptomTypeLabel)
            height1 += CGRectGetHeight(bgImgView.frame)
            
            
            
            
            var imgView=UIImageView(frame: CGRectMake(10, height1+20, 60, 60))
            imgView.image=UIImage(named: "image_1")
            self.tableHeaderView.addSubview(imgView)
            departmentLabel.frame = CGRectMake(CGRectGetWidth(imgView.frame)+20, height1+20, IPHONE_WIDTH-180, 30)
            departmentLabel.text="参考科室：消化内科"
            departmentLabel.font=UIFont(name: "heiti SC", size: 17)
            self.tableHeaderView.addSubview(departmentLabel)
            var consultationLabel:UILabel=UILabel(frame: CGRectMake(CGRectGetWidth(imgView.frame)+20, height1+20+30, IPHONE_WIDTH-150, 30))
            consultationLabel.text="病况因人而异 建议先咨询"
            consultationLabel.font=UIFont(name: "heiti SC", size: 15)
            consultationLabel.textColor=UIColor.grayColor()
            self.tableHeaderView.addSubview(consultationLabel)
            var consultionButton:UIButton=UIButton.buttonWithType(UIButtonType.Custom)as! UIButton
            consultionButton.tag=200
            consultionButton.setTitleColor(UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1), forState: UIControlState.Normal)
            consultionButton.setTitle("咨询", forState: UIControlState.Normal)
            consultionButton.setImage(UIImage(named: "image_2"), forState: UIControlState.Normal)
            consultionButton.titleEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0)
            consultionButton.frame=CGRectMake(IPHONE_WIDTH-100, height1+30, 80, 40)
            consultionButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
            height1 += CGRectGetHeight(imgView.frame)+20
            var grayImgView=UIImageView(frame: CGRectMake(0, height1+20, IPHONE_WIDTH, 40))
            grayImgView.image=UIImage(named: "gray")
            self.tableHeaderView.addSubview(grayImgView)
            experienceLabel.frame=CGRectMake(20, 0, IPHONE_WIDTH-40, 40)
            experienceLabel.text="打嗝"
            experienceLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
            
            grayImgView.addSubview(experienceLabel)
            
            self.tableHeaderView.addSubview(consultionButton)
            height1 += CGRectGetHeight(grayImgView.frame)+20
            
            
            
            
            self.sytomView=UIView(frame: CGRectMake(0, height1, IPHONE_WIDTH, 50))
            self.tableHeaderView.addSubview(self.sytomView)
            //height1 += CGRectGetHeight(self.sytomView.frame)
            
            grayImgView2.frame=CGRectMake(0, height1+10, self.IPHONE_WIDTH, 40)
            grayImgView2.image=UIImage(named: "gray")
            self.tableHeaderView.addSubview(grayImgView2)
            typeLabel.frame=CGRectMake(20, 0, IPHONE_WIDTH-40, 40)
            grayImgView2.addSubview(typeLabel)
            typeLabel.text="消化科"
            typeLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
            
            
        }else
        {
            var frame=self.tableHeaderView.frame
            frame.size.height=420
            self.tableHeaderView.frame=frame
            var width:CGFloat
            self.personTypeLabel=UILabel(frame: CGRectMake(0, 0, 110, height))
            bgImgView.addSubview(self.personTypeLabel)
            width=CGRectGetWidth(self.personTypeLabel.frame)
            var imageView=UIImageView(frame: CGRectMake(width, 0, 20, height))
            imageView.image=image
            bgImgView.addSubview(imageView)
            width += CGRectGetWidth(imageView.frame)
            self.bodyTypeLabel=UILabel(frame: CGRectMake(width, 0, 110, height))
            bgImgView.addSubview(self.bodyTypeLabel)
             width += CGRectGetWidth(self.bodyTypeLabel.frame)
            var imageView1=UIImageView(frame: CGRectMake(width, 0, 20, height))
            imageView1.image=image
            bgImgView.addSubview(imageView1)
            width += CGRectGetWidth(imageView1.frame)
            self.symptomTypeLabel=UILabel(frame: CGRectMake(width, 0, IPHONE_WIDTH-width, height))
            bgImgView.addSubview(self.symptomTypeLabel)
            height1 += CGRectGetHeight(bgImgView.frame)
            
            
            var imgView=UIImageView(frame: CGRectMake(10, height1+20, 60, 60))
            imgView.image=UIImage(named: "image_1")
            self.tableHeaderView.addSubview(imgView)
            departmentLabel.frame=CGRectMake(CGRectGetWidth(imgView.frame)+20, height1+20,IPHONE_WIDTH-80, 30)
            departmentLabel.text="参考科室：消化内科"
            departmentLabel.font=UIFont(name: "heiti SC", size: 17)
            self.tableHeaderView.addSubview(departmentLabel)
            var consultationLabel:UILabel=UILabel(frame: CGRectMake(CGRectGetWidth(imgView.frame)+20, height1+20+30, IPHONE_WIDTH-80, 30))
            consultationLabel.text="病况因人而异 建议先咨询"
            consultationLabel.font=UIFont(name: "heiti SC", size: 15)
            consultationLabel.textColor=UIColor.grayColor()
            self.tableHeaderView.addSubview(consultationLabel)
            var consultionButton:UIButton=UIButton.buttonWithType(UIButtonType.Custom)as! UIButton
            consultionButton.tag=200
            consultionButton.setTitleColor(UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1), forState: UIControlState.Normal)
            consultionButton.setTitle("咨询", forState: UIControlState.Normal)
            consultionButton.setImage(UIImage(named: "image_2"), forState: UIControlState.Normal)
            consultionButton.titleEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0)
            consultionButton.frame=CGRectMake(IPHONE_WIDTH-100, height1+30, 80, 40)
            consultionButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
            height1 += CGRectGetHeight(imgView.frame)+20
            var grayImgView=UIImageView(frame: CGRectMake(0, height1+20, IPHONE_WIDTH, 40))
            grayImgView.image=UIImage(named: "gray")
            self.tableHeaderView.addSubview(grayImgView)
            experienceLabel.frame=CGRectMake(20, 0, IPHONE_WIDTH-40, 40)
            experienceLabel.text="打嗝"
            experienceLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
            grayImgView.addSubview(experienceLabel)
            
            self.tableHeaderView.addSubview(consultionButton)
            height1 += CGRectGetHeight(grayImgView.frame)+20
            
            
            
            
            self.sytomView=UIView(frame: CGRectMake(0, height1, IPHONE_WIDTH, 50))
            self.tableHeaderView.addSubview(self.sytomView)
            //height1 += CGRectGetHeight(self.sytomView.frame)
           
            grayImgView2.frame=CGRectMake(0, height1+10, self.IPHONE_WIDTH, 40)
            grayImgView2.image=UIImage(named: "gray")
            self.tableHeaderView.addSubview(grayImgView2)
            typeLabel.frame=CGRectMake(20, 0, IPHONE_WIDTH-40, 40)
            grayImgView2.addSubview(typeLabel)
            typeLabel.text="消化科"
            typeLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
            
            
        }
        self.sendBock={
            (titleArr:NSArray)->() in
            self.personTypeLabel.text=titleArr.objectAtIndex(0) as? String
            self.personTypeLabel.textColor=UIColor.whiteColor()
            self.bodyTypeLabel.text=titleArr.objectAtIndex(1) as? String
            self.bodyTypeLabel.textColor=UIColor.whiteColor()
            self.symptomTypeLabel.text=titleArr.objectAtIndex(2) as? String
            self.symptomTypeLabel.textColor=UIColor.whiteColor()
        }
        self.bodyTypeLabel.textAlignment=NSTextAlignment.Center
        self.personTypeLabel.textAlignment=NSTextAlignment.Center
        self.symptomTypeLabel.textAlignment=NSTextAlignment.Center
        self.tableView=UITableView(frame: CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-64), style: UITableViewStyle.Plain)
        self.addSubview(self.tableView)
        
        self.sendDepartment={
            (depatrment:String,relateArr:NSArray)->() in
            departmentLabel.text=NSString.localizedStringWithFormat("参考科室：%@",depatrment) as String
            experienceLabel.text=depatrment
            var statusString:NSString=depatrment
            var frame=experienceLabel.frame
            var size=statusString.sizeWithAttributes([NSFontAttributeName:experienceLabel.font])
            var exLabel=UILabel(frame: CGRectMake(size.width+10, 0, 80, 40))
            exLabel.text="相关经验"
            experienceLabel.addSubview(exLabel)
            
            
            typeLabel.text=depatrment;
            var docLabel=UILabel(frame: CGRectMake(size.width+10, 0, 80, 40))
            docLabel.text="医生推荐"
            typeLabel.addSubview(docLabel);
            var y:CGFloat=0.0;
            
            for var i=0;i<relateArr.count;i++
            {
                var label=UILabel(frame: CGRectMake(20, y, self.IPHONE_WIDTH-40, 30))
                var model:XGJYModel=relateArr.objectAtIndex(i) as! XGJYModel
                label.text=model.asktitle
                if self.IPHONE_HEIGHT <= 568
                {
                    label.font=UIFont(name: "heiti SC", size: 13)
                }else
                {
                    label.font=UIFont(name: "heiti SC", size: 15)
                }
                
                label.textColor=UIColor.grayColor()
                label.userInteractionEnabled=true
                var button=UIButton.buttonWithType(UIButtonType.Custom) as!UIButton
                button.frame = CGRectMake(0, 0, CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))
                button.addTarget(self, action:Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
                label.addSubview(button)
                self.sytomView.addSubview(label)
                y+=30
            }
            if relateArr.count==0
            {
                var label=UILabel(frame: CGRectMake(20, 0, self.IPHONE_WIDTH-40, 30))
                label.text="暂无相关经验，随便逛逛"
                label.userInteractionEnabled=true
                var button=UIButton.buttonWithType(UIButtonType.Custom) as!UIButton
                button.frame = CGRectMake(0, 0, CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))
                button.addTarget(self, action:Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
                label.addSubview(button)
                self.sytomView.addSubview(label)
                y=30
            }
            frame=self.sytomView.frame
            frame.size.height = y
            self.sytomView.frame=frame
            self.tableHeaderView.addSubview(self.sytomView)
            height1 += CGRectGetHeight(self.sytomView.frame)
            frame=grayImgView2.frame
            frame.origin.y=height1+10
            grayImgView2.frame=frame
            frame = self.tableHeaderView.frame
            frame.size.height = height1+50
            self.tableHeaderView.frame=frame
            self.tableView.tableHeaderView=self.tableHeaderView
        }
        self.tableView.tableHeaderView=self.tableHeaderView
        self.tableView.registerNib(UINib(nibName: "GuideViewCell", bundle: nil), forCellReuseIdentifier:"cell")
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.None
        self.tableView.showsVerticalScrollIndicator=false
    }
    func btnClick(sender:UIButton)
    {
        if (self.sendButtonBlock != nil)
        {
            self.sendButtonBlock!(sender)
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
