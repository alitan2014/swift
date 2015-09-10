//
//  TreatViewController.swift
//  Heath
//
//  Created by TCL on 15/8/19.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit

class TreatViewController: UIViewController {
    var IPHONE_WIDTH:CGFloat=UIScreen.mainScreen().bounds.width
    var IPHONE_HEIGHT:CGFloat=UIScreen.mainScreen().bounds.height
    @IBOutlet weak var woManButton: UIButton!
    
    @IBOutlet weak var manButton: UIButton!
    @IBOutlet weak var faceButton: UIButton!
    
    @IBOutlet weak var otherButton: UIButton!
    
    @IBOutlet weak var bodyImgView: UIImageView!
    
    @IBOutlet weak var footImgView: UIImageView!//足部
    @IBOutlet weak var legImgView: UIImageView!//腿部
    @IBOutlet weak var reproductionImgView: UIImageView!//生殖部位
    @IBOutlet weak var abdominalImgView: UIImageView!//腹部
    @IBOutlet weak var chestImgView: UIImageView!//胸部
    @IBOutlet weak var handImgView: UIImageView!//手部
    @IBOutlet weak var limbImgView: UIImageView!//上肢
    @IBOutlet weak var neckImageView: UIImageView!//脖子
    var treatmentView:TreatmentView!//男性头部图
    var womenHeadView:WomenHeadView!//女性头部图
    var womenBodyView:WomenBodyView!//女性全图
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createUI()
        clickImage()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden=false
        self.treatmentView.createUI()
        self.womenBodyView.createUI()
        self.womenHeadView.createUI()
       
    }
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
     convenience init() {
        
        var nibNameOrNil = String?("TreatViewController")
        
        //考虑到xib文件可能不存在或被删，故加入判断
        
        if NSBundle.mainBundle().pathForResource(nibNameOrNil, ofType: "xib") == nil
            
        {
            
            nibNameOrNil = nil
            
        }
        
        self.init(nibName: nibNameOrNil, bundle: nil)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createUI()
    {
                var normalImage=UIImage(named: "gray_1")
        var selectedImage=UIImage(named: "gray_2")
        otherButton.setTitleColor(UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1), forState: UIControlState.Normal)
        manButton.setTitle("男性", forState: UIControlState.Normal)
        manButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        //manButton.frame=CGRectMake(manButton.frame.origin.x, manButton.frame.origin.y, 40, 40)
        
        manButton.selected=true
        
        manButton.titleLabel?.font=UIFont(name: "heiti SC", size: 15)
        //manButton.setTitleColor(UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1), forState: UIControlState.Normal)
        
        manButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        manButton.setBackgroundImage(selectedImage, forState: UIControlState.Selected)
        manButton.setBackgroundImage(normalImage, forState: UIControlState.Normal)
        
       if IPHONE_HEIGHT==480
       {
        
            
            manButton.clipsToBounds=true
        }
        
        woManButton.setTitle("女性", forState: UIControlState.Normal)
        woManButton.titleLabel?.font=UIFont(name: "heiti SC", size: 15)
        //woManButton.setTitleColor(UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1), forState: UIControlState.Normal)
        woManButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        woManButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        woManButton.setBackgroundImage(selectedImage, forState: UIControlState.Selected)
        woManButton.setBackgroundImage(normalImage, forState: UIControlState.Normal)
        woManButton.layer.cornerRadius=CGRectGetWidth(woManButton.frame)/2
        //woManButton.clipsToBounds=true
        
        
        
        //创建点击男性头部跳转页面
        treatmentView=NSBundle.mainBundle().loadNibNamed("TreatmentView", owner: self, options: nil).first as!TreatmentView
        treatmentView.createUI()
        treatmentView.frame=CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-100)
        treatmentView.sendTouchBlock={
            (touch:UITouch,state:String)->() in
            if state == "began"
            {
                self.imgViewBeganTouch(touch)
            }else if state == "ended"
            {
                self.imgViewEndedTouch(touch)
            }
            
        }
        self.treatmentView.sendButtonBlock={
            (sender:UIButton)->() in
            self.btbClick(sender)
        }
        
        //创建选择女性跳转页面
        womenBodyView=NSBundle.mainBundle().loadNibNamed("WomenBodyView", owner: self, options: nil).first as!WomenBodyView
        self.womenBodyView.frame=CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-113)
        womenBodyView.createUI()
        self.womenBodyView.sendTouch={
            (touch:UITouch,state:String)->() in
            if state=="began"
            {
                self.imgViewBeganTouch(touch)
            }else if state=="ended"
            {
                self.imgViewEndedTouch(touch)
            }
        }
        self.womenBodyView.sendButton={
            (sender:UIButton)->() in
            self.btbClick(sender)
        }
        
        //创建跳转女性头部图
        self.womenHeadView=NSBundle.mainBundle().loadNibNamed("WomenHeadView", owner: self, options: nil).first as! WomenHeadView
        self.womenHeadView.frame=CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-113)
        self.womenHeadView.sendTouchBlock={
            (touch:UITouch,state:String)->() in
            if state=="began"
            {
                self.imgViewBeganTouch(touch)
            }else if state == "ended"
            {
                self.imgViewEndedTouch(touch)
            }
        }
        self.womenHeadView.sendButtonBlock={
            (sender:UIButton)->() in
            self.btbClick(sender)
        }
    }
    func clickImage()
    {
        self.bodyImgView.userInteractionEnabled=true
        self.footImgView.image=nil
        self.footImgView.userInteractionEnabled=true
        self.legImgView.image=nil
        self.legImgView.userInteractionEnabled=true
        self.reproductionImgView.image=nil
        self.reproductionImgView.userInteractionEnabled=true
        self.abdominalImgView.image=nil
        self.abdominalImgView.userInteractionEnabled=true
        self.chestImgView.image=nil
        self.chestImgView.userInteractionEnabled=true
        self.handImgView.image=nil
        self.handImgView.userInteractionEnabled=true
        self.limbImgView.image=nil
        self.limbImgView.userInteractionEnabled=true
        self.neckImageView.image=nil
        self.neckImageView.userInteractionEnabled=true
    }
    //开始触摸图片
    func imgViewBeganTouch(touch:UITouch)
    {
        var view=touch.view
        let tag=view.tag
        if faceButton.selected==true || self.womenBodyView.faceButton.selected==true
        {
            switch tag
            {
            case 120://点击了屁股
                self.reproductionImgView.image=UIImage(named: "intelligence_highlight_0314")
            case 130://点击了腰部
                self.abdominalImgView.image=UIImage(named: "intelligence_highlight_0312")
            case 140://点击了腰部
                self.chestImgView.image=UIImage(named: "intelligence_highlight_0312")
            case 230://女性生殖部位
                self.womenBodyView.reproductionImgView.image=UIImage(named: "intelligence_highlight_0214")
            case 250://女性腹部
                self.womenBodyView.abdominalImgView.image=UIImage(named: "intelligence_highlight_0212")
            case 270://女性胸部
                self.womenBodyView.chestImgView.image=UIImage(named: "intelligence_highlight_0210")
            default:
                println()
            }
        }else
        {
            switch tag
            {
            case 10://点击了嘴巴
                self.treatmentView.mouthImageView.image=UIImage(named: "intelligence_highlight_0304.png")
            case 20://点击了眼睛
                self.treatmentView.eyesImageView.image=UIImage(named: "intelligence_highlight_0102")
            case 30://点击了耳朵
                self.treatmentView.earsImageView.image=UIImage(named: "intelligence_highlight_0105")
            case 40://点击了面部
                self.treatmentView.faceImageView.image=UIImage(named: "intelligence_highlight_0306")
            case 50://点击了耳朵
                self.treatmentView.noseImageView.image=UIImage(named: "intelligence_highlight_0103")
            case 60://点击了头部
                self.treatmentView.headImageView.image=UIImage(named: "intelligence_highlight_0301")
            case 100://点击了足部
                self.footImgView.image=UIImage(named: "intelligence_highlight_0317")
            case 110://腿部
                self.legImgView.image=UIImage(named: "intelligence_highlight_0116")
            case 120://点击了生殖部位
                self.reproductionImgView.image=UIImage(named: "intelligence_highlight_0315")
            case 130://点击了腹部
                self.abdominalImgView.image=UIImage(named: "intelligence_highlight_0311")
            case 140://点击了胸部
                self.chestImgView.image=UIImage(named: "intelligence_highlight_0310")
            case 150://点击了手
                self.handImgView.image=UIImage(named: "intelligence_highlight_0109")
            case 160://点击了上肢
                self.limbImgView.image=UIImage(named: "intelligence_highlight_0108")
            case 170://点击了脖子
                self.neckImageView.image=UIImage(named: "intelligence_highlight_0307")
            case 180://点击 跳转男性头部大图
                println("跳转头部界面")
                
                var views=self.view.subviews
                for view in views
                {
                    (view as! UIView).hidden=true
                }
                self.view.addSubview(treatmentView)
            case 210://女性足部
                self.womenBodyView.footImgView.image=UIImage(named: "intelligence_highlight_0217")
            case 220://女性腿部
                self.womenBodyView.legImgView.image=UIImage(named: "intelligence_highlight_0216")
            case 230://女性生殖部位
                self.womenBodyView.reproductionImgView.image=UIImage(named: "intelligence_highlight_0215")
            case 240://女性手部
                self.womenBodyView.handImgView.image=UIImage(named: "intelligence_highlight_0209")
            case 250://女性腹部
                self.womenBodyView.abdominalImgView.image=UIImage(named: "intelligence_highlight_0211")
            case 260://女性上肢
                self.womenBodyView.limbImgView.image=UIImage(named: "intelligence_highlight_0208")
            case 270://女性胸部
                self.womenBodyView.chestImgView.image=UIImage(named: "intelligence_highlight_0210")
            case 280://女性脖子
                self.womenBodyView.neckImageView.image=UIImage(named: "intelligence_highlight_0207")
            case 290://点击跳转女子头部图
                self.womenBodyView.hidden=true
                self.view.addSubview(self.womenHeadView)
                println("点击了女性头部")
            case 410://点击了女性 嘴巴
                self.womenHeadView.mouthImageView.image=UIImage(named: "intelligence_highlight_0206")
            case 420://点击了女性 鼻子
                self.womenHeadView.noseImageView.image=UIImage(named: "intelligence_highlight_0203")
            case 430://点击了女性 面部
                self.womenHeadView.faceImageView.image=UIImage(named: "intelligence_highlight_0206")
            case 440://点击了女性眼睛
                self.womenHeadView.eyesImageView.image=UIImage(named: "intelligence_highlight_0202")
            case 450://点击了女性耳朵
                self.womenHeadView.earsImageView.image=UIImage(named: "intelligence_highlight_0205")
            case 460://点击了女性头部
                self.womenHeadView.headImageView.image=UIImage(named: "intelligence_highlight_0201")
                
            default:
                println()
            }
        }
        
        
    }
    //结束触摸图片
    func imgViewEndedTouch(touch:UITouch)
    {
        var view=touch.view
        let tag=view.tag
        var symptom=SymptomViewController()
        
        if faceButton.selected==true || self.womenBodyView.faceButton.selected==true
        {
            if manButton.hidden==false
            {
                symptom.personType="男性"
                symptom.typeNum=1
            }else
            {
                symptom.personType="女性"
                symptom.typeNum=2
            }
            switch tag
            {
            case 120://点击了屁股
                self.reproductionImgView.image=nil
                symptom.position="臀部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 130://点击了腰部
                self.abdominalImgView.image=nil
                symptom.position="腰部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 140://点击了背部
                self.chestImgView.image=nil
                symptom.position="背部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 230://女性臀部
                self.womenBodyView.reproductionImgView.image=nil
                symptom.position="臀部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 250://女性腰部
                self.womenBodyView.abdominalImgView.image=nil
                symptom.position="腰部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 270://女性背部部
                self.womenBodyView.chestImgView.image=nil
                symptom.position="背部"
                self.navigationController?.pushViewController(symptom, animated: true)
            default:
                println()
            }
        }else
        {
            if manButton.hidden==false
            {
                symptom.personType="男性"
                symptom.typeNum=1
            }else
            {
                symptom.personType="女性"
                symptom.typeNum=2
            }
            switch tag
            {
            case 10://嘴巴
                self.treatmentView.mouthImageView.image=nil
                symptom.position="口腔"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 20://眼睛
                self.treatmentView.eyesImageView.image=nil
                symptom.position="眼部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 30://耳朵
                self.treatmentView.earsImageView.image=nil
                symptom.position="耳部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 40://面部
                self.treatmentView.faceImageView.image=nil
                symptom.position="面部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 50://鼻子
                self.treatmentView.noseImageView.image=nil
                symptom.position="鼻部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 60://头部
                self.treatmentView.headImageView.image=nil
                symptom.position="头部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 100://足部
                self.footImgView.image=nil
                symptom.position="足部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 110://腿部
                self.legImgView.image=nil
                symptom.position="腿部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 120://生殖部位
                self.reproductionImgView.image=nil
                symptom.position="生殖部位"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 130://腹部
                self.abdominalImgView.image=nil
                symptom.position="腹部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 140://胸部
                self.chestImgView.image=nil
                symptom.position="胸部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 150://手部
                self.handImgView.image=nil
                symptom.position="手部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 160://上肢
                self.limbImgView.image=nil
                symptom.position="上肢"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 170:
                self.neckImageView.image=nil
                symptom.position="颈部"
                self.navigationController?.pushViewController(symptom, animated: true)
            
            case 210://女性足部
                self.womenBodyView.footImgView.image=nil
                symptom.position="足部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 220://女性腿部
                self.womenBodyView.legImgView.image=nil
                symptom.position="腿部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 230://女性生殖部位
                self.womenBodyView.reproductionImgView.image=nil
                symptom.position="生殖部位"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 240://女性手部
                self.womenBodyView.handImgView.image=nil
                symptom.position="手部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 250://女性腹部
                self.womenBodyView.abdominalImgView.image=nil
                symptom.position="腹部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 260://女性上肢
                self.womenBodyView.limbImgView.image=nil
                symptom.position="上肢"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 270://女性胸部
                self.womenBodyView.chestImgView.image=nil
                symptom.position="胸部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 280://女性脖子
                self.womenBodyView.neckImageView.image=nil
                symptom.position="颈部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 410://点击了女性 嘴巴
                self.womenHeadView.mouthImageView.image=nil
                symptom.position="口腔"
                 self.navigationController?.pushViewController(symptom, animated: true)
            case 420://点击了女性 鼻子
                self.womenHeadView.noseImageView.image=nil
                symptom.position="鼻部"
                 self.navigationController?.pushViewController(symptom, animated: true)
            case 430://点击了女性 面部
                self.womenHeadView.faceImageView.image=nil
                symptom.position="面部"
                 self.navigationController?.pushViewController(symptom, animated: true)
            case 440://点击了女性眼睛
                self.womenHeadView.eyesImageView.image=nil
                symptom.position="眼部"
                 self.navigationController?.pushViewController(symptom, animated: true)
            case 450://点击了女性耳朵
                self.womenHeadView.earsImageView.image=nil
                symptom.position="耳部"
                self.navigationController?.pushViewController(symptom, animated: true)
            case 460://点击了女性头部
                self.womenHeadView.headImageView.image=nil
                symptom.position="头部"
                 self.navigationController?.pushViewController(symptom, animated: true)
           
            default:
                println()
            }
        }
        
        
    }
    //开始触摸
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        var set=touches as NSSet
        let touch:UITouch=set.anyObject() as! UITouch
        imgViewBeganTouch(touch)
    }
    //结束触摸
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        var set=touches as NSSet
        let touch:UITouch=set.anyObject() as! UITouch
        imgViewEndedTouch(touch)
    }
        @IBAction func btbClick(sender: AnyObject) {
        var tag=sender.tag
            var symptom=SymptomViewController()
            
        switch tag
        {
        case 10://点击了男性按钮
            manButton.selected = true
            woManButton.selected=false
            if faceButton.selected==false
            {
                bodyImgView.image=UIImage(named: "man_front")
            }else
            {
                bodyImgView.image=UIImage(named: "man_back_view")
            }
        case 20://点击了女性按钮
            var views=self.view.subviews
            for view  in views
            {
                (view as!UIView).hidden=true
            }
            self.view.addSubview(self.womenBodyView)
        case 30://点击了正反面按钮
            faceButton.selected = !faceButton.selected
            self.womenBodyView.faceButton.selected=faceButton.selected
            changeImage()
            if faceButton.selected==false
            {
                if manButton.selected==true
                {
                     bodyImgView.image=UIImage(named: "man_front")
                }else
                {
                     bodyImgView.image=UIImage(named: "woman_front")
                }
               
                
            }else
            {
                if manButton.selected==true
                {
                    bodyImgView.image=UIImage(named: "man_back_view")
                }else
                {
                    bodyImgView.image=UIImage(named: "woman_back_view")
                }
                
            }
        case 40:
            sender.setTitleColor(UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1), forState: UIControlState.Normal)
            symptom.personType="男性"
            symptom.typeNum=1
            self.navigationController?.pushViewController(symptom, animated: true)
        case 300://点击了女性图 男性按钮
            var views=self.view.subviews
            for view  in views
            {
                (view as!UIView).hidden=false
            }
             self.womenBodyView.removeFromSuperview()
        case 310://点击了女性图 女性按钮
            self.womenBodyView.woManButton.selected=true
        case 320://点击了女性图 正反面按钮
            self.womenBodyView.faceButton.selected = !self.womenBodyView.faceButton.selected
            faceButton.selected=self.womenBodyView.faceButton.selected
            changeImage()
            if faceButton.selected==false
            {
                bodyImgView.image=UIImage(named: "man_front")
            }else
            {
                bodyImgView.image=UIImage(named: "man_back_view")
            }
        case 330://点击了女性图 身体其他症状
           symptom.personType="女性"
           symptom.typeNum=2
           self.navigationController?.pushViewController(symptom, animated: true)
        case 470://点击了女性头像返回按钮
            self.womenHeadView.removeFromSuperview()
            self.womenBodyView.hidden=false
        case 1000://男头像点击了返回
            self.treatmentView.removeFromSuperview()
            var views=self.view.subviews
            for view in views
            {
                (view as! UIView).hidden=false
            }
            
        default:
            println()
        }
    }
    func changeImage()
    {
        if self.womenBodyView.faceButton.selected==false
        {
            self.womenBodyView.bodyImgView.image=UIImage(named: "woman_front")
            
        }else
        {
            self.womenBodyView.bodyImgView.image=UIImage(named: "woman_back_view")
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
