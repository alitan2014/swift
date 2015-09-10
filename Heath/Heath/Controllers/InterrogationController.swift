//
//  InterrogationController.swift
//  Heath
//
//  Created by Mac on 15/7/13.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit
import Alamofire
import SpriteKit
class InterrogationController: UIViewController,UIScrollViewDelegate,UIPageViewControllerDelegate {
    var imgPageView:UIPageControl?
    let width = UIScreen.mainScreen().bounds.width
    var scrollView:UIScrollView = UIScrollView()
    let imgUrl = "http://app.zmyy.cn/Api_inc/Resource/Json/jkys.php"
    var urlStr:String = ""
    var height:CGFloat = 0
    var urlArr:NSMutableArray = []
    var index:CGFloat = 0.0
    var count:CGFloat = 0
    var pageControl:UIPageControl?
    var scrollView1:UIScrollView=UIScrollView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView = UIScrollView()
        var height = UIScreen.mainScreen().bounds.height
        if height==480
        {
            self.scrollView.frame=CGRectMake(0, 0, self.view.frame.width, self.view.frame.height*0.32)
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width*7, self.view.frame.height*0.32)
        }else if height==568
        {
            self.scrollView.frame=CGRectMake(0, 0, self.view.frame.width, self.view.frame.height*0.3)
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width*7, self.view.frame.height*0.3)
        }else if height==667
        {
            self.scrollView.frame=CGRectMake(0, 0, self.view.frame.width, self.view.frame.height*0.35)
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width*7, self.view.frame.height*0.35)
        }else
        {
            self.scrollView.frame=CGRectMake(0, 0, self.view.frame.width, self.view.frame.height*0.28)
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width*7, self.view.frame.height*0.28)
        }
        
        
        self.height += CGRectGetHeight(self.scrollView.frame)
        
        self.view.addSubview(self.scrollView)
        self.navigationItem.title="健康养生"
        self.view.backgroundColor=UIColor.whiteColor()
        //createData()
//        loadData()
//        createUI()
        
        self.scrollView.pagingEnabled=true
        self.scrollView.contentOffset=CGPointMake(self.view.frame.width, 0)
        self.scrollView.delegate=self
       
        
        
        timerOpen()
        // Do any additional setup after loading the view.
    }
    func timerOpen()
    {
        var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("timer:"), userInfo: nil, repeats: true)
        timer.fire()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.hidden=false
    }
    //从网络中加载数据
    func loadData()
    {
        var request = NSURLRequest(URL: NSURL(string: "http://app.zmyy.cn/Api_inc/Resource/Json/jkys.php")!)
        var loadDataQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: loadDataQueue, completionHandler: { response, data, error in
            if (error != nil)
            {
                println(error)
                dispatch_async(dispatch_get_main_queue(), {
                    //                    self.refreshControl?.endRefreshing()
                })
            }
            else
            {
                let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSArray
               self.urlArr = NSMutableArray(array: json)
                self.createImgView()
                
            }
        })
    }
    //创建 imgView
    func createImgView()
    {
        
        
        var index:Int
        for index = 0;index < self.urlArr.count+2 ;index++
        {
            var url:String
            if index==0
            {
                url = self.urlArr.objectAtIndex(4)as!String
            }else if index==6
            {
                url = self.urlArr.objectAtIndex(0)as!String
            }else
            {
                url = self.urlArr.objectAtIndex(index-1)as!String
            }
            
            var imgView=UIImageView()
            imgView.userInteractionEnabled=true
            imgView.tag=index+1
            
            imgView.frame=CGRectMake(self.view.frame.width * self.index, 0, self.view.frame.width, self.scrollView.frame.height)
            var tap = UITapGestureRecognizer(target: self, action: Selector("tap:"))
            imgView.addGestureRecognizer(tap)
            var activity=UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
            activity.color=UIColor.redColor()
            activity.frame=CGRectMake(0, 0, imgView.frame.width, imgView.frame.height)
            
            //activity.backgroundColor=UIColor.redColor()
            imgView.sd_setImageWithURL(NSURL(string: url), placeholderImage: nil, options: nil, progress: { (x, y) -> Void in
                imgView.addSubview(activity)
                activity.startAnimating()
               UIApplication.sharedApplication().networkActivityIndicatorVisible=true
                
                }) { (image, _, _, _) -> Void in
                    imgView.image=image
                    println(image)
                    activity.stopAnimating()
                    activity.removeFromSuperview()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible=false
            }
            
                self.scrollView.showsHorizontalScrollIndicator=false
                dispatch_async(dispatch_get_main_queue(), {
                self.scrollView.addSubview(imgView)
                
                })
            
                self.index++
        }
        
    }
    
    //创建UI
    func createUI()
    {
        self.imgPageView=UIPageControl(frame: CGRectMake(self.view.frame.width-100, self.scrollView.frame.height-20, 100, 20))as UIPageControl
        
        self.imgPageView!.numberOfPages=5
        self.imgPageView!.currentPageIndicatorTintColor=UIColor.whiteColor()
        self.imgPageView!.pageIndicatorTintColor=UIColor.grayColor()
        self.imgPageView?.addTarget(self, action:Selector("change:"), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(self.imgPageView!)
        
        var rightBtn = UIButton.buttonWithType(UIButtonType.Custom)as!UIButton;
        rightBtn.frame = CGRectMake(0, 0, 40, 40)
        rightBtn.tag=100
        rightBtn.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        rightBtn.setImage(UIImage(named:"themes_18_unselect" ), forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        var image = UIImage(named: "textBackgroud")
        var imageView = UIImageView(frame: CGRectMake(30, self.height+10, self.view.frame.width-60, 40))
        imageView.image=image
        imageView.userInteractionEnabled=true
        var searchImage=UIImage(named: "search")
        var searchImageView=UIImageView(frame: CGRectMake(imageView.frame.width-35, 8, 25, 25))
        searchImageView.image=searchImage
        imageView.addSubview(searchImageView)
        var searchTextFiled=UITextField(frame: CGRectMake(5, 0, CGRectGetWidth(self.view.frame)-90, 40))
        imageView.addSubview(searchTextFiled)
        
        searchTextFiled.borderStyle=UITextBorderStyle.None
        
        searchTextFiled.placeholder="文章搜索"
        self.view.addSubview(imageView)
        self.height += CGRectGetHeight(imageView.frame)+10
        self.scrollView1=UIScrollView(frame: CGRectMake(0, self.height, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-self.height-140))
        scrollView1.delegate=self;
        self.view.addSubview(scrollView1)
        
        let titleArr=["饮食健康","运动养生","中医养生","老年养生","两性养生","中医养生"]
        let imgArr=["btn_share_qq","btn_share_qq","btn_share_qq","btn_share_weibo","btn_share_weixin_timeline","btn_share_weixin"]
        
        var x:Int
        var y:Int
        var index:CGFloat = 0.0
        for x = 0;x<5;x++
        {
            
            var bgView=UIView(frame: CGRectMake(CGRectGetWidth(self.view.frame)*index, 0,CGRectGetWidth(self.view.frame), scrollView1.frame.height))
            bgView.tag=x+1
            var array:NSMutableArray = NSMutableArray()
            scrollView1.addSubview(bgView)
            var yy:CGFloat=0.0
            var kk:CGFloat=0.0
            if x==0||x==3
            {
                for y=0;y<titleArr.count-1;y++
                {
                    
                    var btn = TLDragButton.buttonWithType(UIButtonType.Custom) as! TLDragButton
                    
                    btn.frame=CGRectMake(yy*(CGRectGetWidth(self.view.frame)-60)/3+20+yy*5, kk*scrollView1.frame.height/2, (CGRectGetWidth(self.view.frame)-40)/3, scrollView1.frame.height/2)
                    btn.tag=y+1;
                    
                    btn.lineCount=3
                    btn.setTitle(titleArr[y], forState: UIControlState.Normal)
                    btn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
                    
                    //btn.titleLabel?.font=UIFont(name: "heiti SC", size: 14)
                    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignment.Center
                    btn.contentVerticalAlignment=UIControlContentVerticalAlignment.Fill
                    
                    var size = UIScreen.mainScreen().bounds.height
                    if size == 568
                    {
                        btn.titleEdgeInsets=UIEdgeInsetsMake(CGRectGetHeight(btn.frame)-30, 10, 0, CGRectGetWidth(btn.frame)-12)
                        btn.imageEdgeInsets=UIEdgeInsetsMake(15, 15, 25, 15)
                    }else if size == 480
                    {
                        btn.titleEdgeInsets=UIEdgeInsetsMake(CGRectGetHeight(btn.frame)-30, 0, 0, CGRectGetWidth(btn.frame)-15)
                        btn.imageEdgeInsets=UIEdgeInsetsMake(0, 25, 25, 25)
                    }else if size == 667
                    {
                        btn.titleEdgeInsets=UIEdgeInsetsMake(CGRectGetHeight(btn.frame)-40, 0, 0, CGRectGetWidth(btn.frame)-20)
                        btn.imageEdgeInsets=UIEdgeInsetsMake(10, 20, 40, 20)
                    }else
                    {
                        
                        btn.titleEdgeInsets=UIEdgeInsetsMake(CGRectGetHeight(btn.frame)-40, 0, 0, CGRectGetWidth(btn.frame)-25)
                        btn.imageEdgeInsets=UIEdgeInsetsMake(25, 8, 30, 8)
                    }
                    
                    btn.setImage(UIImage(named: imgArr[y]), forState: UIControlState.Normal)
                    btn.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
                    var longpressGesutre = UILongPressGestureRecognizer(target: self, action: Selector("dragAction:"))
                    //长按时间为1秒
                    longpressGesutre.minimumPressDuration = 0.5
                    //允许15秒运动
                    longpressGesutre.allowableMovement = 15
                    //所需触摸1次
                    longpressGesutre.numberOfTouchesRequired = 1
                    //btn.addGestureRecognizer(longpressGesutre)
                    array.addObject(btn)
                    btn.btnArray=array
                    bgView.addSubview(btn)
                    if yy<2
                    {
                        yy++
                    }else
                    {
                        ++kk
                        yy=0.0
                    }
                }
                index++
            }else
            {
                for y=0;y<titleArr.count;y++
                {
                    
                    var btn = TLDragButton.buttonWithType(UIButtonType.Custom) as! TLDragButton
                    
                    btn.frame=CGRectMake(yy*(CGRectGetWidth(self.view.frame)-60)/3+20+yy*5, kk*scrollView1.frame.height/2, (CGRectGetWidth(self.view.frame)-40)/3, scrollView1.frame.height/2)
                    btn.tag=y+1;
                    
                    btn.lineCount=3
                    btn.setTitle(titleArr[y], forState: UIControlState.Normal)
                    btn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
                    
                    //btn.titleLabel?.font=UIFont(name: "heiti SC", size: 14)
                    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignment.Center
                    btn.contentVerticalAlignment=UIControlContentVerticalAlignment.Fill
                    
                    var size = UIScreen.mainScreen().bounds.height
                    if size == 568
                    {
                        btn.titleEdgeInsets=UIEdgeInsetsMake(CGRectGetHeight(btn.frame)-30, 10, 0, CGRectGetWidth(btn.frame)-12)
                        btn.imageEdgeInsets=UIEdgeInsetsMake(15, 15, 25, 15)
                    }else if size == 480
                    {
                        btn.titleEdgeInsets=UIEdgeInsetsMake(CGRectGetHeight(btn.frame)-30, 0, 0, CGRectGetWidth(btn.frame)-15)
                        btn.imageEdgeInsets=UIEdgeInsetsMake(0, 25, 25, 25)
                    }else if size == 667
                    {
                        btn.titleEdgeInsets=UIEdgeInsetsMake(CGRectGetHeight(btn.frame)-40, 0, 0, CGRectGetWidth(btn.frame)-20)
                        btn.imageEdgeInsets=UIEdgeInsetsMake(10, 20, 40, 20)
                    }else
                    {
                        
                        btn.titleEdgeInsets=UIEdgeInsetsMake(CGRectGetHeight(btn.frame)-40, 0, 0, CGRectGetWidth(btn.frame)-25)
                        btn.imageEdgeInsets=UIEdgeInsetsMake(25, 8, 30, 8)
                    }
                    
                    btn.setImage(UIImage(named: imgArr[y]), forState: UIControlState.Normal)
                    btn.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
                   
                   
                    array.addObject(btn)
                    btn.btnArray=array
                    bgView.addSubview(btn)
                    if yy<2
                    {
                        yy++
                    }else
                    {
                        ++kk
                        yy=0.0
                    }
                }
                index++
            }
            
            
        }
        scrollView1.contentSize=CGSizeMake(CGRectGetWidth(self.view.frame)*5, scrollView1.frame.height)
        scrollView1.contentOffset=CGPointMake(self.view.frame.width, 0)
        self.height += CGRectGetHeight(scrollView1.frame)
        scrollView1.pagingEnabled=true
        scrollView1.showsHorizontalScrollIndicator=false
        scrollView1.showsVerticalScrollIndicator=false
        scrollView1.contentOffset=CGPointMake(self.view.frame.width, 0)
        self.pageControl=UIPageControl(frame: CGRectMake(self.view.frame.width/2-40, self.height, 80, 20))
        self.pageControl?.numberOfPages=3
        self.pageControl?.currentPageIndicatorTintColor=UIColor.orangeColor()
        self.pageControl?.pageIndicatorTintColor=UIColor.grayColor()
        self.pageControl?.addTarget(self, action: Selector("change:"), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(self.pageControl!)
        
        scrollView.contentOffset=CGPointMake(0, 0)
    }
    //点击触发事件
    func btnClick(sender:UIButton)
    {
        var tag = sender.tag
        switch tag
        {
        case 100 ://点击rightBtn触发事件
            var myDoctor = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MyDoctorViewController")as! MyDoctorViewController
            myDoctor.navigationController?.navigationBar.hidden=true
            self.navigationController?.pushViewController(myDoctor, animated: true)
        case 1 ://健康饮食
            var expertDocto = ExpertDoctoController()
            self.tabBarController?.tabBar.hidden=true
            self.navigationController?.pushViewController(expertDocto, animated: true)
            
            println()
        case 2 ://运动养生
            var department = DepartmentViewController.alloc()
            self.tabBarController?.tabBar.hidden=true
            self.navigationController?.pushViewController(department, animated: true)
            println()
        case 3 ://中医养生
            println()
        case 4 ://老年养生
            println()
        case 5 ://两性养生
            println()
        case 6 ://中医养生
            println()
        default :
           
                println(sender.titleLabel?.text)
           
            
        }
        
    }
    //点击 pageControl触发事件
    func change(sender:UIPageControl)
    {
        if sender == self.pageControl
        {
            var page = self.scrollView1.contentOffset.x/self.view.frame.width
            var x=self.pageControl?.currentPage
            var index = CGFloat(x!)
            if page==4
            {
                self.pageControl?.currentPage=0
                self.scrollView1.setContentOffset(CGPointMake(self.view.frame.width, 0), animated: false)
            }else if page == 0
            {
                self.scrollView1.setContentOffset(CGPointMake(self.view.frame.width*3, 0), animated: true)
                self.pageControl?.currentPage=2
            }else
            {
                self.scrollView1.setContentOffset(CGPointMake(self.view.frame.width*(index+1), 0), animated: true)
            }
        }else
        {
            var page = self.scrollView.contentOffset.x/self.view.frame.width
            var x=self.imgPageView?.currentPage
            var index = CGFloat(x!)
            if page==6
            {
                self.imgPageView?.currentPage=0
                self.scrollView.setContentOffset(CGPointMake(self.view.frame.width, 0), animated: false)
            }else if page == 0
            {
                self.scrollView.setContentOffset(CGPointMake(self.view.frame.width*5, 0), animated: true)
                self.imgPageView?.currentPage=4
            }else
            {
                self.scrollView.setContentOffset(CGPointMake(self.view.frame.width*(index+1), 0), animated: true)
            }
            
        }
        
    }
    //点击图片触发事件
    func tap(sender:UITapGestureRecognizer)
    {
        var imgView = sender.view
        var tag = imgView?.tag
        if tag > 1
        {
            println("点击了第\(tag!-1)张图片")
        }else if tag < 6
        {
            println("点击了第\(tag!-1)张图片")
        }
    }
    //自动翻转图片
    func timer(time:NSTimer)
    {
        self.count++
        self.count=self.scrollView.contentOffset.x/self.view.frame.width+1
        if self.count==6
        {
            
            self.scrollView.setContentOffset(CGPointMake(CGRectGetWidth(self.view.frame)*1, 0), animated: false)
            
            self.imgPageView?.currentPage=0
            self.count=0
        }else
        {
             scrollView.setContentOffset(CGPointMake(CGRectGetWidth(self.view.frame)*self.count, 0), animated: true)
            self.imgPageView?.currentPage=Int(count-1)
        }
        
    }
     func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var index = scrollView.contentOffset.x/self.view.frame.width
        if  scrollView == self.scrollView
        {
            var page:Int = Int(index)
            println("page=\(page)")
            println("index=\(index)")
            if (index == 0)
            {
                scrollView.setContentOffset(CGPointMake(CGRectGetWidth(self.view.frame)*5, 0), animated: false)
                self.imgPageView?.currentPage=4
                
            }else if (page == 6)
            {
                scrollView.setContentOffset(CGPointMake(CGRectGetWidth(self.view.frame)*1, 0), animated: false)
                self.imgPageView?.currentPage=0
            }else
            {
                self.imgPageView?.currentPage=page-1
            }
            
        }else
        {
        
            var page = Int(index)
            self.pageControl?.currentPage=page-1
                if (index == 0)
                {
            scrollView.setContentOffset(CGPointMake(CGRectGetWidth(self.view.frame)*3, 0), animated: false)
                    self.pageControl?.currentPage=2
            
                }else if (index == 4)
                {
            scrollView.setContentOffset(CGPointMake(CGRectGetWidth(self.view.frame)*1, 0), animated: false)
                    self.pageControl?.currentPage=0
                }
            
        }
    
    }
    func dragAction(sender:UILongPressGestureRecognizer)
    {
        var btn:TLDragButton=sender.view as!TLDragButton
        var view:UIView=btn.superview!
        if view.tag==4
        {
            var array = view.subviews
            var btn:TLDragButton=array[0]as!TLDragButton
            println(btn.titleLabel?.text)
        }
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
