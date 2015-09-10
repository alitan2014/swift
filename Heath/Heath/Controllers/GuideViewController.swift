//
//  GuideViewController.swift
//  Heath
//
//  Created by TCL on 15/8/17.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration
class GuideViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var guideView:GuideView!
    var IPHONE_WIDTH:CGFloat=UIScreen.mainScreen().bounds.width
    var IPHONE_HEIGHT:CGFloat=UIScreen.mainScreen().bounds.height
    var personType:String!
    var bodyType:String!
    var symptomType:String!
    var id:String!
    var jbzzModel:JBZZModel!
    var docArr=NSMutableArray()
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
        
        // Do any additional setup after loading the view.
       
        if Reachability.isConnectedToNetwork(){
            
            createUI()
            loadData()
           
            println("网络连接正常，继续...")
            
        }else{
            println("网络异常...")
            
            createUI()
           
        }
    }
    func createUI()
    {
        self.navigationItem.title="智能导诊"
        self.jbzzModel=JBZZModel.alloc()
        self.guideView=GuideView(frame: CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT))
        self.view.addSubview(self.guideView)
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(customView: self.guideView.backButton)
        
        self.guideView.tableView.delegate=self
        self.guideView.tableView.dataSource=self
        self.guideView.sendButtonBlock={
            (sender:UIButton)->() in
            self.btnClick(sender)
        }
        var array=[self.personType,self.bodyType,self.symptomType]
        if self.guideView.sendBock != nil
        {
            self.guideView.sendBock!(titleArr: array)
        }
    }
    func loadData()
    {
       
        self.view.addSubview(self.guideView.bgView)
        self.guideView.activity.startAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible=true
        println(self.id)
        Alamofire.request(.POST, "http://app.zmyy.cn/Api_inc/daozhen/fenzhen.php", parameters: ["jbzzid":self.id]).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (_, _, JSON, _) -> Void in
            
            let dataDic=JSON!.objectForKey("data")as!NSDictionary
            self.jbzzModel.setValuesForKeysWithDictionary(dataDic as [NSObject : AnyObject])
            if (self.guideView.sendDepartment != nil)
            {
                self.guideView.sendDepartment(self.jbzzModel.ksname,self.jbzzModel.xgjyArr)
            }
            
            for docDic in self.jbzzModel.ystj
            {
                var docModel=DoctorModel.alloc()
                docModel.setValuesForKeysWithDictionary(docDic as! [NSObject : AnyObject])
                self.docArr.addObject(docModel)
                
            }
            self.guideView.tableView.reloadData()
            self.guideView.bgView.removeFromSuperview()
            UIApplication.sharedApplication().networkActivityIndicatorVisible=false
            self.guideView.activity.stopAnimating()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func btnClick(sender:UIButton)
    {
        
        var index:NSInteger=sender.tag
        switch index
        {
        case 100:
            self.navigationController?.popViewControllerAnimated(true)
        case 200:
            println("你点击了预约")
        default:
            println("你点击了相关经验")
        }
    }
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.docArr.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:GuideViewCell?=tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? GuideViewCell
        cell?.sendButtonClick={
            (sender:UIButton)->() in
            self.btnClick(sender)
        }
        var model=self.docArr.objectAtIndex(indexPath.row)as!DoctorModel
        cell?.refreshCellWihtDoctorModel(model)
        return cell!
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
