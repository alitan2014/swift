//
//  DepartmentViewController.swift
//  Heath
//
//  Created by TCL on 15/7/16.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit

class DepartmentViewController: UIViewController,UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="中美儿科"
        createUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createUI()
    {
        var heiht:CGFloat = 0.0
        var backBtn = UIButton.buttonWithType(UIButtonType.Custom)as!UIButton
        backBtn.frame = CGRectMake(0, 0, 40, 40)
        backBtn.tag=100
        backBtn.setImage(UIImage(named: "back"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(customView: backBtn)
        var scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        scrollView.showsVerticalScrollIndicator=false
        self.view.addSubview(scrollView)
        //点赞按钮
        var loveBtn = DOFavoriteButton(frame: CGRectMake(self.view.frame.width/2-22, 0, 44, 44), image: UIImage(named: "heart"), imageFrame: CGRectMake(12, 12, 20, 20))
        loveBtn.imageColorOn = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        loveBtn.circleColor = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        loveBtn.lineColor = UIColor(red: 226/255, green: 96/255, blue: 96/255, alpha: 1.0)
        //loveBtn.frame=CGRectMake(self.view.frame.width/2-15, 0, 30, 30)
        loveBtn.tag=10
        loveBtn.setImage(UIImage(named: "red_fav_image"), forState: UIControlState.Normal)
        loveBtn.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        scrollView.addSubview(loveBtn)
        heiht += CGRectGetHeight(loveBtn.frame)
        var loveLabel = UILabel(frame: CGRectMake(CGRectGetWidth(self.view.frame)/2-20, heiht, 40, 25))
        loveLabel.text="+333"
        loveLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
        scrollView.addSubview(loveLabel)
        heiht += CGRectGetHeight(loveLabel.frame)
        
        
        var contentLabel = UILabel(frame: CGRectMake(10, heiht, CGRectGetWidth(self.view.frame)-20, 180))
        contentLabel.text="儿科是以北京儿童医院专家做技术支撑成长起来的中带你科室。科室发挥我院多科协作的整体优势，在儿科各类疾病的诊治方面临床经验丰富，可为不同年龄段的儿科疑难病得诊治方面，在京东儿科系统据宇先进之列。在危重新生儿的急 彤居于先进之列。在危重新生儿的急"
        contentLabel.textColor=UIColor.grayColor()
        contentLabel.numberOfLines=0
//        let statusText:NSString = contentLabel.text!
//        var size = statusText.sizeWithAttributes([statusText:NSFontAttributeName])
//        var frame = contentLabel.frame
//        frame.size.height=size.height
//        contentLabel.frame=frame
        scrollView.addSubview(contentLabel)
        heiht += CGRectGetHeight(contentLabel.frame)
        
        var expertLabel = UILabel(frame: CGRectMake(10, heiht+10, CGRectGetWidth(self.view.frame)-20, 30))
        expertLabel.text="专家团队"
        expertLabel.font=UIFont(name: "heiti SC", size: 25)
        scrollView.addSubview(expertLabel)
        heiht += CGRectGetHeight(expertLabel.frame)+10
        
        
        var index:CGFloat = 0.0
        var x:CGFloat
        var expertScrollView = UIScrollView(frame: CGRectMake(0, heiht+10, self.view.frame.width, 190))
        scrollView.addSubview(expertScrollView)
        for x=0;x<4;x++
        {
            var bigBgView = UIView(frame: CGRectMake(self.view.frame.width * x, 0, self.view.frame.width, 190))
            expertScrollView.addSubview(bigBgView)
            for index = 0; index<2;index++
            {
                var height1 :CGFloat = 0.0
                var bgView = UIView(frame: CGRectMake(0, 80*index+5, self.view.frame.width, 80))
                var imgView = UIImageView(frame: CGRectMake(10, 5, 90, 70))
                imgView.image=UIImage(named: "doctor")
                bgView.addSubview(imgView)
                var nameLabel = UILabel(frame: CGRectMake(110,5,70,20))
                nameLabel.text="吕亚杰"
                nameLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
                nameLabel.font=UIFont(name: "", size: 20)
                bgView.addSubview(nameLabel)
                var positionLabel = UILabel(frame: CGRectMake(170, 10, self.view.frame.width-180, 15))
                positionLabel.text="产科 副主任医师"
                bgView.addSubview(positionLabel)
                height1 += CGRectGetHeight(nameLabel.frame)+5
                var goodLabel = UILabel(frame: CGRectMake(110, height1, 40, 20))
                goodLabel.text="擅长"
                bgView.addSubview(goodLabel)
                var goodContentLabel = UILabel(frame: CGRectMake(150, height1+3, self.view.frame.width-160, 15))
                goodContentLabel.text="糖尿病，糖尿病，糖尿病，糖尿病"
                goodContentLabel.textColor=UIColor.grayColor()
                goodContentLabel.font=UIFont(name: "", size: 15)
                goodContentLabel.textAlignment=NSTextAlignment.Center
                bgView.addSubview(goodContentLabel)
                height1 += CGRectGetHeight(goodLabel.frame)
            
                var outLabel = UILabel(frame: CGRectMake(110, height1, 40, 20))
                outLabel.text = "出诊"
                bgView.addSubview(outLabel)
                var outContentLabel=UILabel(frame: CGRectMake(150, height1+3, self.view.frame.width-160, 15))
                outContentLabel.text="周一，周二，周三，周四，周六"
                outContentLabel.textAlignment=NSTextAlignment.Center
                outContentLabel.textColor=UIColor.grayColor()
                outContentLabel.font=UIFont(name: "", size: 15)
                bgView.addSubview(outContentLabel)
                bigBgView.addSubview(bgView)
                var bgImgView = UIImageView(frame: CGRectMake(10, index*80+80, self.view.frame.width-20, 1))
                bgImgView.image=UIImage(named: "gray")
                expertScrollView.addSubview(bgImgView)
            }
        }
        expertScrollView.showsVerticalScrollIndicator=false
        expertScrollView.showsHorizontalScrollIndicator=false
        expertScrollView.pagingEnabled=true
        expertScrollView.delegate=self
        heiht += CGRectGetHeight(expertScrollView.frame)+10
        expertScrollView.contentSize=CGSizeMake(self.view.frame.width*4, 190)
        var characteristicLabel = UILabel(frame: CGRectMake(10, heiht+15, self.view.frame.width-20, 25))
        characteristicLabel.text="特色医疗"
        scrollView.addSubview(characteristicLabel)
        characteristicLabel.font=UIFont(name: "heiti SC", size: 25)
        heiht += CGRectGetHeight(characteristicLabel.frame)+15
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.translucent = true

        var  charaterView = NSBundle.mainBundle().loadNibNamed("CharaterView", owner: self, options: nil)[0] as! CharaterView
        var charaterFrame = charaterView.frame
        charaterFrame.origin.y = heiht+15
        charaterView.frame=charaterFrame
        scrollView.addSubview(charaterView)
        heiht += CGRectGetHeight(charaterView.frame)+15
        
        
        var medicalLabel = UILabel(frame: CGRectMake(10, heiht+20, self.view.frame.width-20, 30))
        medicalLabel.text="特色医疗"
        medicalLabel.font = UIFont(name: "heiti SC", size: 25)
        scrollView.addSubview(medicalLabel)
        heiht += CGRectGetHeight(medicalLabel.frame)+20
        var noDiseaseLabel = UILabel(frame: CGRectMake(10, heiht+20, self.view.frame.width-20, 100))
        noDiseaseLabel.text="新生儿无病陪房：尤其擅长围产期高危壬辰诊治以及壬辰合并症，并发症等危重病得抢救，如壬辰期高血压疾病壬辰合并肝炎，糖尿病，肾病，先心病，胎儿生长受限，监测，管熟练处理疑难助产技能"
        noDiseaseLabel.numberOfLines=0
        
        var nodiseaseStr:NSString = noDiseaseLabel.text!
        var range = nodiseaseStr .rangeOfString("：")
        
        var attribute = NSMutableAttributedString(string: nodiseaseStr as String )
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], range: NSMakeRange(0, range.location))
        scrollView.addSubview(noDiseaseLabel)
        heiht += CGRectGetHeight(noDiseaseLabel.frame)+20
        noDiseaseLabel.attributedText=attribute
        
        var IntensiveLabel = UILabel(frame: CGRectMake(10, heiht+10, self.view.frame.width-20, 100))
        IntensiveLabel.text="新生儿无病陪房：尤其擅长围产期高危壬辰诊治以及壬辰合并症，并发症等危重病得抢救，如壬辰期高血压疾病壬辰合并肝炎，糖尿病，肾病，先心病，胎儿生长受限，监测，管熟练处理疑难助产技能"
        IntensiveLabel.numberOfLines=0;
        nodiseaseStr=IntensiveLabel.text!
        range = nodiseaseStr .rangeOfString("：")
        attribute = NSMutableAttributedString(string: nodiseaseStr as String )
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], range: NSMakeRange(0, range.location))
        IntensiveLabel.attributedText=attribute
        scrollView.addSubview(IntensiveLabel)
        heiht += CGRectGetHeight(IntensiveLabel.frame)+10
        
        var roundsLabel = UILabel(frame: CGRectMake(10, heiht+10, self.view.frame.width-20,
        100))
        roundsLabel.text="产科新生儿查房：尤其擅长围产期高危壬辰诊治以及壬辰合并症，并发症等危重病得抢救，如壬辰期高血压疾病壬辰合并肝炎，糖尿病，肾病，先心病，胎儿生长受限，监测，管熟练处理疑难助产技能"
        roundsLabel.numberOfLines=0
        nodiseaseStr=roundsLabel.text!
        range = nodiseaseStr .rangeOfString("：")
        attribute = NSMutableAttributedString(string: nodiseaseStr as String )
        attribute.addAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], range: NSMakeRange(0, range.location))
        roundsLabel.attributedText=attribute
        scrollView.addSubview(roundsLabel)
        
        heiht += CGRectGetHeight(roundsLabel.frame)+10
        
        
        var environmentalLabel = UILabel(frame: CGRectMake(10, heiht+20, self.view.frame.width-20, 30))
        environmentalLabel.text="科室环境"
        environmentalLabel.font=UIFont(name: "heiti SC", size: 25)
        scrollView.addSubview(environmentalLabel)
        heiht += CGRectGetHeight(environmentalLabel.frame)+20
        
        var index1:CGFloat
        var environmentalScrollView = UIScrollView(frame: CGRectMake(10, heiht+20, self.view.frame.width-20, 200))
        
        for index1=0;index1<3;index1++
        {
            var imgView = UIImageView(frame: CGRectMake(index1 * (self.view.frame.width-20), 0, self.view.frame.width-20, 200))
            imgView.image=UIImage(named: "environment")
            environmentalScrollView.addSubview(imgView)
        }
        environmentalScrollView.showsVerticalScrollIndicator=false
        environmentalScrollView.showsHorizontalScrollIndicator=false
        environmentalScrollView.contentSize=CGSizeMake((self.view.frame.width-20)*3, 200)
        environmentalScrollView.pagingEnabled=true
        heiht += CGRectGetHeight(environmentalScrollView.frame)+20
        var notiLabel = UILabel(frame: CGRectMake(10, heiht+10, self.view.frame.width-20, 20))
        notiLabel.text="左右滑动查看更多消息"
        notiLabel.textColor=UIColor.grayColor()
        notiLabel.font=UIFont(name: "heiti SC", size: 15)
        scrollView.addSubview(notiLabel)
        heiht += CGRectGetHeight(notiLabel.frame)
        scrollView.addSubview(environmentalScrollView)
        scrollView.contentSize=CGSizeMake(self.view.frame.width, heiht+80)
    }
    
    func btnClick(sender:DOFavoriteButton)
    {
        var tag = sender.tag
        switch tag
        {
        case 10 ://点击了点赞按钮
           
            if sender.selected {
                sender.deselect()
            } else {
                sender.select()
            }
            println("你点击了点赞按钮")
        case 100 :
            self.navigationController?.popViewControllerAnimated(true)
        default :
            println()
        }
    }
    
    //scrollView  代理方法
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var index = scrollView.contentOffset.x / self.view.frame.width
        if index==3
        {
            scrollView.contentOffset = CGPointMake(self.view.frame.width, 0)
        }else if index == 0
        {
            scrollView.contentOffset = CGPointMake(self.view.frame.width*2, 0)
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
