//
//  SymptomViewController.swift
//  Heath
//
//  Created by TCL on 15/8/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration
class SymptomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var bgView:UIView!
    var activity:UIActivityIndicatorView!
    
    var position:String!
    var personType:String!
    var IPHONE_WIDTH:CGFloat=UIScreen.mainScreen().bounds.width
    var IPHONE_HEIGHT:CGFloat=UIScreen.mainScreen().bounds.height
    var symptomTableView:UITableView!
    var bodyTableView:UITableView!
    var symptomArray:NSMutableArray!
    var bodyArray:NSMutableArray!
    var typeNum:NSNumber!
    var index:Int!
    var personString:String!
    var bodyString:String!
    var dataArr:NSMutableArray!
    var bodyArr:NSMutableArray!
    var nameArr:NSMutableArray!
    var idArr:NSMutableArray!
    var sex:String!
    internal class Reachability {
        class func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
                SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
                
            }
            var flags: SCNetworkReachabilityFlags = 0
            
            if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
                return false
                
            }
            let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
            
            let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            
            return (isReachable && !needsConnection) ? true : false
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.userInteractionEnabled=true
        self.dataArr=NSMutableArray()
        
        if Reachability.isConnectedToNetwork(){
            
            createUI()
            loadData()
            initData()
            println("网络连接正常，继续...")
            
        }else{
            println("网络异常...")
            //            initData()
            createUI()
            //            loadData()
            readWithFile()
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden=true
        
    }
      override  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed=true
    }

      required init(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    //从网络中加载数据
    func loadData()
    {
        self.view.addSubview(self.bgView)
        self.activity.startAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible=true
        bodyArr=NSMutableArray()
        nameArr=NSMutableArray()
        idArr=NSMutableArray()
        if self.personType=="男性"
        {
            
            sex="1"
            
        }else if self.personType=="女性"
        
        {
           sex="2"
        }
        
        Alamofire.request(.POST, "http://app.zmyy.cn/Api_inc/daozhen/datasource.php", parameters: ["sex":sex]).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (_, _, JSON, _) -> Void in
            
            let refudeArray=JSON!.objectForKey("data")as!NSArray
            for dic in refudeArray
            {
                var model = PositionModel()
                model.setValuesForKeysWithDictionary(dic as![NSObject:AnyObject])
                self.dataArr.addObject(model)
                self.bodyArr.addObject(model.jbname)
                
                var sytomArr=NSMutableArray()
                var idArray=NSMutableArray()
                for var i=0;i<model.jblistArr.count;i++
                {
                    var jbModel:JBModel=model.jblistArr.objectAtIndex(i) as!JBModel
                    sytomArr.addObject(jbModel.jbname)
                    self.idArr.addObject(jbModel.id)
                }
                self.nameArr.addObject(sytomArr)
                self.idArr.addObject(idArray)
            }
            
            self.saveWithFile()
            self.bodyTableView.reloadData()
            for var x=0;x<self.dataArr.count;x++
            {
                
                if self.position != nil
                {
                    var model=self.dataArr.objectAtIndex(x)as!PositionModel
                    if model.jbname==self.position
                    {
                        self.index=x
                        self.bodyString=model.jbname
                    }
                }else
                {
                    var model=self.dataArr.objectAtIndex(0)as!PositionModel
                    self.bodyString=model.jbname
                }
                
            }
            var indexPath=NSIndexPath(forRow: self.index, inSection: 0)
            
            var array:NSArray=[indexPath]
            
            self.bodyTableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Middle)
            self.symptomTableView.reloadData()
            self.bgView.removeFromSuperview()
            self.activity.stopAnimating()
            UIApplication.sharedApplication().networkActivityIndicatorVisible=false
            
        }
       

        
    }
    func initData()
        
    {
        symptomArray=NSMutableArray()
        bodyArray=NSMutableArray()
        
       
        
        //
        var manPath=NSBundle.mainBundle().pathForResource("TCLMan", ofType: "plist")
        var woManPath=NSBundle.mainBundle().pathForResource("TCLWoman", ofType: "plist")
        var kidPath=NSBundle.mainBundle().pathForResource("TCLChild", ofType: "plist")
        var manArr:NSMutableArray=NSMutableArray()
        
        if typeNum==1
        {
            manArr=NSMutableArray(contentsOfFile: manPath!)!
        }else if typeNum==2
        {
            manArr=NSMutableArray(contentsOfFile: woManPath!)!
        }else if typeNum==3
        {
            manArr=NSMutableArray(contentsOfFile: kidPath!)!
        }
        
        
        for var i=0;i<manArr.count;i++
        {
            var symptomDic: NSDictionary=manArr.objectAtIndex(i) as! NSDictionary
            var symptomArr: AnyObject?=symptomDic.objectForKey("arr")
            var bodyString: AnyObject?=symptomDic.objectForKey("first")
            bodyArray.addObject(bodyString!)
            var array=NSMutableArray()
            for var j=0;j<symptomArr?.count;j++
            {
                var dic: AnyObject=symptomArr!.objectAtIndex(j)
                var model=SymptomModel()
                model.setValuesForKeysWithDictionary(dic as! [NSObject : AnyObject])
                array.addObject(model)
            }
            symptomArray.addObject(array)
        }
        
       
        
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
        self.tabBarController?.tabBar.userInteractionEnabled=true
        self.navigationItem.title="症状列表";
        var backButton:UIButton=UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        backButton.frame=CGRectMake(0, 0, 40, 40)
        backButton.tag=100
        backButton.setImage(UIImage(named: "back"), forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        index=0
        var width:CGFloat=100.0;
        
        
        if IPHONE_HEIGHT==480
        {
            width=120.0
            bodyTableView=UITableView(frame: CGRectMake(0, 0, width, IPHONE_HEIGHT-64), style:UITableViewStyle.Plain)
        }else if IPHONE_HEIGHT==568
        {
            width=120.0
            bodyTableView=UITableView(frame: CGRectMake(0, 0, width, IPHONE_HEIGHT-64), style:UITableViewStyle.Plain)
        }else if IPHONE_HEIGHT==667
        {
            width=140
            bodyTableView=UITableView(frame: CGRectMake(0, 0, width, IPHONE_HEIGHT-64), style:UITableViewStyle.Plain)
        }else
        {
            width=160
            bodyTableView=UITableView(frame: CGRectMake(0, 0, width, IPHONE_HEIGHT-64), style:UITableViewStyle.Plain)
        }
        bodyTableView.separatorStyle=UITableViewCellSeparatorStyle.None
        bodyTableView.delegate=self
        bodyTableView.dataSource=self
        bodyTableView.showsVerticalScrollIndicator=false
        self.view.addSubview(bodyTableView)
        symptomTableView=UITableView(frame: CGRectMake(width, 0, IPHONE_WIDTH-width, IPHONE_HEIGHT-64), style: UITableViewStyle.Plain)
        symptomTableView.separatorStyle=UITableViewCellSeparatorStyle.None
        symptomTableView.delegate=self
        symptomTableView.showsVerticalScrollIndicator=false
        symptomTableView.dataSource=self
        self.view.addSubview(symptomTableView)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView==bodyTableView
        {
            return 106
        }else
        {
            return 106
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView==bodyTableView
        {
            if dataArr.count==0
            {
                if bodyArr.count != 0
                {
                    return bodyArr.count
                }
                return 0
                
            }else
            {
                
                return dataArr.count
            }
            
        }else
        {
            if self.dataArr.count != 0
            {
                var model=self.dataArr.objectAtIndex(index)as! PositionModel
                return model.jblistArr.count
            }else
            {
                if nameArr.count != 0
                {
                    return nameArr.objectAtIndex(index).count
                }
                return 0
                
            }
            
        }
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView==bodyTableView
        {
            index=indexPath.row
            symptomTableView.reloadData()
            if dataArr.count == 0
            {
                self.bodyString=self.bodyArr.objectAtIndex(indexPath.row) as! String
            }else
            {
                var model=self.dataArr.objectAtIndex(indexPath.row) as! PositionModel
                self.bodyString=model.jbname
            }
            
        }else
        {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            var guide:GuideViewController=GuideViewController()
            guide.personType=self.personType
            if dataArr.count != 0
            {
                var posiModel=self.dataArr.objectAtIndex(index) as!PositionModel
                println(self.symptomArray.count)
                var array:NSArray=self.symptomArray.objectAtIndex(index) as! NSArray
                var model=posiModel.jblistArr.objectAtIndex(indexPath.row) as!JBModel
                guide.bodyType=self.bodyString
                guide.symptomType=model.jbname
                guide.id=model.id
            }else
            {
                 guide.bodyType=self.bodyString
                guide.symptomType=nameArr.objectAtIndex(index).objectAtIndex(indexPath.row) as! String
                guide.id=idArr.objectAtIndex(index).objectAtIndex(indexPath.row) as! String
            }
            
            self.navigationController?.pushViewController(guide, animated: true)
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView==bodyTableView
        {
            var cell: UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            var bgViwe=UIImageView()
            bgViwe.image=UIImage(named: "cell")
            cell.backgroundView=bgViwe
            if dataArr.count != 0
            {
                var model=self.dataArr.objectAtIndex(indexPath.row)as!PositionModel
                cell.textLabel?.text=model.jbname
            }else
            {
                cell.textLabel?.text=bodyArr.objectAtIndex(indexPath.row) as? String
            }
            
             return cell
        }else
        {
            var cell: UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            if dataArr.count != 0
            {
                var posiModel=self.dataArr.objectAtIndex(index)as! PositionModel
                var model=posiModel.jblistArr.objectAtIndex(indexPath.row) as!JBModel
                
                cell.textLabel?.text=model.jbname
            }else
            {
                cell.textLabel?.text=nameArr.objectAtIndex(index).objectAtIndex(indexPath.row) as? String
            }
            
           
             return cell
            
        }
        
        
      
    }
    func btnClick(sender:UIButton)
    {
        var tag:NSInteger=sender.tag
        switch tag
        {
        case 100:
            self.navigationController?.popViewControllerAnimated(true)
            
        default :
            return
        }
    }
    
    
    
    func saveWithFile() {
        /// 1、获得沙盒的根路径
        let home = NSHomeDirectory() as NSString;
        /// 2、获得Documents路径，使用NSString对象的stringByAppendingPathComponent()方法拼接路径
        let docPath = home.stringByAppendingPathComponent("Documents") as NSString;
        /// 3、获取文本文件路径
        let filePath = docPath.stringByAppendingPathComponent("data.plist");
        let namePath=docPath.stringByAppendingPathComponent("name.plist")
        let idPath=docPath.stringByAppendingPathComponent("id.plist")
        var dataSource = NSMutableArray();
        dataSource.addObject("衣带渐宽终不悔");
        dataSource.addObject("为伊消得人憔悴");
        dataSource.addObject("故国不堪回首明月中");
        dataSource.addObject("人生若只如初见");
        dataSource.addObject("暮然回首，那人却在灯火阑珊处");
        // 4、将数据写入文件中
        //dataSource.writeToFile(filePath, atomically: true);
        self.bodyArr.writeToFile(filePath, atomically: true)
        self.nameArr.writeToFile(namePath, atomically: true)
        self.idArr.writeToFile(idPath, atomically: true)
    }
    func readWithFile() {
        /// 1、获得沙盒的根路径
        let home = NSHomeDirectory() as NSString;
        /// 2、获得Documents路径，使用NSString对象的stringByAppendingPathComponent()方法拼接路径
        let docPath = home.stringByAppendingPathComponent("Documents") as NSString;
        /// 3、获取文本文件路径
        let filePath = docPath.stringByAppendingPathComponent("data.plist");
        let namePath=docPath.stringByAppendingPathComponent("name.plist")
        let idPath=docPath.stringByAppendingPathComponent("id.plist")
        let dataSource:NSArray = NSArray(contentsOfFile: filePath)!;
        self.bodyArr=NSMutableArray()
        for str in dataSource
        {
            self.bodyArr.addObject(str)
        }
        let nameSource:NSArray = NSArray(contentsOfFile: namePath)!
        self.nameArr=NSMutableArray()
        for str in nameSource
        {
            self.nameArr.addObject(str)
        }
        let idSource:NSArray = NSArray(contentsOfFile: idPath)!
        self.idArr=NSMutableArray(object: idSource)
        for str in idSource
        {
            self.idArr.addObject(str)
        }
        //self.dataArr=NSMutableArray(array: dataSource)
        self.bodyTableView.reloadData()
        for var x=0;x<self.bodyArr.count;x++
        {
            
            if self.position != nil
            {
                var str=self.bodyArr.objectAtIndex(x)as!String
                if str==self.position
                {
                    self.index=x
                    self.bodyString=str
                }
            }else
            {
                var model=self.bodyArr.objectAtIndex(0)as!String
                self.bodyString=model
            }
            
        }
        var indexPath=NSIndexPath(forRow: self.index, inSection: 0)
        
        var array:NSArray=[indexPath]
        
        self.bodyTableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Middle)
        self.symptomTableView.reloadData()
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
