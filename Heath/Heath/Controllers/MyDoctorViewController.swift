//
//  MyDoctorViewController.swift
//  Heath
//
//  Created by TCL on 15/7/14.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit

class MyDoctorViewController: UIViewController {

    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var serverLabel: UILabel!
    @IBOutlet weak var outLineLabel: UILabel!
    @IBOutlet weak var heathServerLabel: UILabel!
    @IBOutlet weak var niceLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        // Do any additional setup after loading the view.
    }
    
    func createUI()
    {
        self.serverLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
        self.outLineLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
        self.heathServerLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
        self.niceLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
    }
    
    @IBAction func btnClick(sender: AnyObject) {
        var tag = sender.tag
        switch tag
        {
        case 10 ://你点击了QQ
            println("你点击了QQ")
        case 20 ://你点击了电话
            println("你点击了电话")
        case 30 ://你点击了手机
            println("你点击了手机")
        case 40 ://你点击了预约挂号
            var reservation = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ReservationController") as! ReservationController
            self.tabBarController?.tabBar.hidden=true
            self.navigationController?.pushViewController(reservation, animated: true)
            println("你点击了预约挂号")
        case 50 ://你点击了健康顾问
            println("你点击了健康顾问")
        case 60 ://你点击了离线回答
            println("你点击了离线回答")
        case 70 ://你点击了消息
            println("你点击了消息")
            
        default :
            println("你点击了其他")
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.hidden=false
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
