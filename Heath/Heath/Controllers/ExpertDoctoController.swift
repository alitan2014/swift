
//
//  ExpertDoctoController.swift
//  Heath
//
//  Created by TCL on 15/7/15.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit

class ExpertDoctoController: UIViewController {

     var scrollView: UIScrollView!
    @IBOutlet weak var topView: UIImageView!
    @IBOutlet weak var orderBtn: UIButton!
    @IBOutlet weak var treatView: UIView!
    @IBOutlet weak var treatTextView: UITextView!
    var loveLabel:UILabel!
    var height:CGFloat=0
    @IBOutlet weak var outView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        // Do any additional setup after loading the view.
    }
    func createUI()
    {
        self.navigationItem.title="专家医生"
        var backBtn = UIButton.buttonWithType(UIButtonType.Custom)as!UIButton
        backBtn.frame = CGRectMake(0, 0, 40, 40)
        backBtn.tag=100
        backBtn.setImage(UIImage(named: "back"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(customView: backBtn)
        self.scrollView=UIScrollView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.view.addSubview(self.scrollView)
        var headerImgView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height*0.35))
        headerImgView.userInteractionEnabled=true
        headerImgView.image=UIImage(named: "top")
        self.scrollView.addSubview(headerImgView)
        self.height += CGRectGetHeight(headerImgView.frame)
        var nameLabel = UILabel(frame: CGRectMake(20, headerImgView.frame.height-30, 90, 20))
        nameLabel.text="吕亚杰"
        nameLabel.textColor=UIColor.orangeColor()
        nameLabel.font=UIFont(name: "heiti SC", size: 20)
        headerImgView.addSubview(nameLabel)
        var jobLabel = UILabel(frame: CGRectMake(80, headerImgView.frame.height-25, 120, 15))
        jobLabel.text="产科 副主任医师"
        jobLabel.font=UIFont(name: "heiti SC", size: 15)
        headerImgView.addSubview(jobLabel)
        var loveBtn = DOFavoriteButton(frame: CGRectMake(200, headerImgView.frame.height-33, 30, 30), image: UIImage(named: "heart"), imageFrame: CGRectMake(6, 6, 20, 20))
        loveBtn.tag=10
        loveBtn.imageColorOn = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        loveBtn.circleColor = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        loveBtn.lineColor = UIColor(red: 226/255, green: 96/255, blue: 96/255, alpha: 1.0)
        loveBtn.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        loveBtn.setImage(UIImage(named: "red_fav_image"), forState: UIControlState.Normal)
        headerImgView.addSubview(loveBtn)
        self.loveLabel=UILabel(frame: CGRectMake(225, headerImgView.frame.height-25, 100, 15))
        self.loveLabel.textAlignment=NSTextAlignment.Left
        self.loveLabel.textColor=UIColor.orangeColor()
        self.loveLabel.text="+33"
        headerImgView.addSubview(self.loveLabel)
        var orderImgView = UIImageView(frame: CGRectMake(0, self.height+2, self.view.frame.width/2-1, 80))
        orderImgView.image=UIImage(named: "gray")
        orderImgView.userInteractionEnabled=true
        self.scrollView.addSubview(orderImgView)
        var imgView = UIImageView(frame: CGRectMake(orderImgView.frame.width/2-15, 10, 30, 30))
        imgView.image=UIImage(named: "order")
        orderImgView.addSubview(imgView)
        var orderLabel = UILabel(frame: CGRectMake(orderImgView.frame.width/2-20, 40, 40, 20))
        orderLabel.text="预约"
        orderLabel.textColor=UIColor.grayColor()
        orderImgView.addSubview(orderLabel)
        var orderBtn = UIButton.buttonWithType(UIButtonType.Custom)as!UIButton
        orderBtn.tag=20
        orderBtn.frame=CGRectMake(0, 0, orderImgView.frame.width, orderImgView.frame.height)
        orderBtn.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        orderImgView.addSubview(orderBtn)
        
        
        
        var requsetImgView = UIImageView(frame: CGRectMake(self.view.frame.width/2+1, self.height+2, self.view.frame.width/2-1, 80))
        requsetImgView.image=UIImage(named: "gray")
        requsetImgView.userInteractionEnabled=true
        self.scrollView.addSubview(requsetImgView)
        var imgView1 = UIImageView(frame: CGRectMake(requsetImgView.frame.width/2-15, 10, 30, 30))
        imgView1.image=UIImage(named: "request")
        requsetImgView.addSubview(imgView1)
        var requestLabel = UILabel(frame: CGRectMake(requsetImgView.frame.width/2-20, 40, 40, 20))
        requestLabel.text="咨询"
        requestLabel.textColor=UIColor.grayColor()
        requsetImgView.addSubview(requestLabel)
        var requsetBtn = UIButton.buttonWithType(UIButtonType.Custom)as!UIButton
        requsetBtn.tag=30
        requsetBtn.frame=CGRectMake(0, 0, requsetImgView.frame.width, requsetImgView.frame.height)
        requsetBtn.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        requsetImgView.addSubview(requsetBtn)
        self.height += CGRectGetHeight(requsetImgView.frame)+2
        
        
        
        var goodLabel = UILabel(frame: CGRectMake(10, self.height+10, 100, 30))
        goodLabel.text="擅长治疗"
        goodLabel.font=UIFont(name: "heiti SC", size: 23)
        self.scrollView.addSubview(goodLabel)
        var index:CGFloat
        for index=0;index<4;index++
        {
            var workLabel = UILabel(frame: CGRectMake(110+((self.view.frame.width-120)/4)*index+index*2, self.height+18, (self.view.frame.width-140)/4, 20))
            workLabel.text="糖尿病"
            workLabel.textAlignment=NSTextAlignment.Center
            workLabel.backgroundColor=UIColor.orangeColor()
            workLabel.font=UIFont(name: "heiti SC", size: 13)
            workLabel.textColor=UIColor.whiteColor()
            self.scrollView.addSubview(workLabel)
        }
        self.height += CGRectGetHeight(goodLabel.frame)+10
        var detailLabel = UILabel(frame: CGRectMake(10, self.height+10, self.view.frame.width-20, 140))
        detailLabel.text="    尤其擅长围产期高危壬辰诊治以及壬辰并合症等危重病的抢救，如壬辰期高血压疾病壬辰合并肝炎，糖尿病，肾病，先心病，胎儿生长受限，胎盘早剥，产科出血等监制，管理和治疗，熟练疑难产及娴熟应用助产科技"
        detailLabel.textColor=UIColor.grayColor()
        detailLabel.numberOfLines=0
        self.scrollView.addSubview(detailLabel)
        self.height += CGRectGetHeight(detailLabel.frame)
        
        self.scrollView.showsVerticalScrollIndicator=false
        var outTimeLabel = UILabel(frame: CGRectMake(10, self.height+20, 150, 30))
        outTimeLabel.text="出诊时间"
        outTimeLabel.font=UIFont(name: "heiti SC", size: 23)
        self.scrollView.addSubview(outTimeLabel)
        self.height += CGRectGetHeight(outTimeLabel.frame)+20
        var outView = NSBundle.mainBundle().loadNibNamed("OutTimeView", owner: self, options: nil)[0]as! OutTimeView
        var frame = outView.frame
        frame.origin.y=self.height+10
        outView.frame=frame
        self.scrollView.addSubview(outView)
        self.height += CGRectGetHeight(outView.frame)+10
        
        
        var expertLabel = UILabel(frame: CGRectMake(10, self.height+20, self.view.frame.width-20, 30))
        expertLabel.text="专家简介"
        expertLabel.font=UIFont(name: "heiti SC", size: 23)
        self.scrollView.addSubview(expertLabel)
        self.height += CGRectGetHeight(expertLabel.frame)+20
        var expertDetailLabel = UILabel(frame: CGRectMake(10, self.height+10, self.view.frame.width-20, 100))
        expertDetailLabel.text="中华妇产科分会会员，从事妇产科临床工作20余年，积累了丰富的临床经验。多学科协作，多次成功抢救基层医院转诊的危重孕产妇。大力……"
        expertDetailLabel.textColor=UIColor.grayColor()
        expertDetailLabel.numberOfLines=0
        self.scrollView.addSubview(expertDetailLabel)
        self.height += CGRectGetHeight(expertDetailLabel.frame)+10
        
        var doctorLabel = UILabel(frame: CGRectMake(10, self.height+10, self.view.frame.width-20, 30))
        doctorLabel.text="医生推荐"
        
        doctorLabel.font=UIFont(name: "heiti SC", size: 23)
        self.scrollView.addSubview(doctorLabel)
        self.height += CGRectGetHeight(doctorLabel.frame)
        var index1:CGFloat = 0.0
        var x:CGFloat
        var expertScrollView = UIScrollView(frame: CGRectMake(0, self.height+10, self.view.frame.width, 190))
        self.scrollView.addSubview(expertScrollView)
        for x=0;x<4;x++
        {
            var bigBgView = UIView(frame: CGRectMake(self.view.frame.width * x, 0, self.view.frame.width, 190))
            expertScrollView.addSubview(bigBgView)
            for index1 = 0; index1<2;index1++
            {
                var height1 :CGFloat = 0.0
                var bgView = UIView(frame: CGRectMake(0, 80*index1+5, self.view.frame.width, 80))
                var imgView = UIImageView(frame: CGRectMake(10, 5, 90, 70))
                imgView.image=UIImage(named: "doctor")
                bgView.addSubview(imgView)
                var nameLabel = UILabel(frame: CGRectMake(110,5,70,20))
                nameLabel.text="吕亚杰"
                nameLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
                nameLabel.font=UIFont(name: "heiti SC", size: 20)
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
                outContentLabel.font=UIFont(name: "heiti SC", size: 15)
                bgView.addSubview(outContentLabel)
                bigBgView.addSubview(bgView)
                var bgImgView = UIImageView(frame: CGRectMake(10, index*80+80, self.view.frame.width-20, 1))
                bgImgView.image=UIImage(named: "gray")
                expertScrollView.addSubview(bgImgView)
            }
        }
        expertScrollView.contentSize=CGSizeMake(self.view.frame.width*4, 190)
        expertScrollView.showsVerticalScrollIndicator=false
        expertScrollView.showsHorizontalScrollIndicator=false
        expertScrollView.pagingEnabled=true
        self.height += CGRectGetHeight(expertScrollView.frame)
        
        
        
        self.scrollView.contentSize=CGSizeMake(self.view.frame.width, self.height+60)
        
    }
     func btnClick(sender: DOFavoriteButton) {
        var tag = sender.tag
        switch tag
        {
        case 10 ://你点击了红星
            println("你点击了红星")
            if sender.selected {
                sender.deselect()
            } else {
                sender.select()
            }
        case 20 ://你点击了预约
            
            println("你点击了预约")
            var reservation = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ReservationController") as! ReservationController
            self.tabBarController?.tabBar.hidden=true
            self.navigationController?.pushViewController(reservation, animated: true)
        case 30 ://你点击了咨询
            println("你点击了咨询")
            println()
        case 100 ://返回上一层
            self.navigationController?.popViewControllerAnimated(true)
        default :
            println()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
