//
//  HeathTabBarcontroller.swift
//  Heath
//
//  Created by Mac on 15/7/13.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit

class HeathTabBarcontroller: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let imagesArr = ["themes_01_unselect","themes_02_unselect","themes_03_unselect","themes_04_unselect"]
        let titlesArr = ["问诊","智能导航","健康","账户"]
        //var interrogation = InterrogationController.alloc()
        
        var interrogation=InterrogationController.alloc()
        var nav1=UINavigationController(rootViewController: interrogation)
        nav1.tabBarItem = UITabBarItem(title: "问诊", image:UIImage(named: imagesArr[0]), selectedImage: UIImage(named: imagesArr[0]))
        var treatment = TreatViewController(nibName: "TreatViewController", bundle: nil)
        treatment.tabBarItem = UITabBarItem(title: "智能导航", image: UIImage(named: imagesArr[1]), selectedImage: UIImage(named: imagesArr[1]))
        treatment.tabBarItem = UITabBarItem(title: "智能导航", image: UIImage(named: imagesArr[1]), tag: 0)
        var nav2 = UINavigationController(rootViewController: treatment)
//        nav2.navigationBar.tintColor=UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1)
//        nav2.navigationBar.backgroundColor=UIColor(red: 64/255.0, green: 193/255.0, blue: 218/255.0, alpha: 1)
        
        var heath = HeathViewController.alloc()
        var image = UIImage(named: "themes_03_unselect")
        heath.tabBarItem = UITabBarItem(title: "健康", image: image, selectedImage: image)
        var nav3 = UINavigationController(rootViewController: heath)
        
        
        var account = AccountViewController.alloc()
        account.tabBarItem = UITabBarItem(title: "账户", image: UIImage(named: imagesArr[3]), selectedImage: UIImage(named: imagesArr[3]))
        var nav4 = UINavigationController(rootViewController: account)
        
        let viewControllers = [nav1,nav2,nav3,nav4]
        self.view.backgroundColor=UIColor.whiteColor()
        self.viewControllers=viewControllers
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
