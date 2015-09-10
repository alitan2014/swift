//
//  ReservationController.swift
//  Heath
//
//  Created by TCL on 15/7/15.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit

class ReservationController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dataPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden=false
        createUI()
    }
    func createUI()
    {
        self.navigationItem.title="预约挂号"
        self.dataPicker.dataSource=self
        self.dataPicker.delegate=self
        var backBtn = UIButton.buttonWithType(UIButtonType.Custom)as!UIButton
        backBtn.frame = CGRectMake(0, 0, 40, 40)
        backBtn.tag=100
         backBtn.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.setImage(UIImage(named: "back"), forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(customView: backBtn)
    }
    @IBAction func btnClick(sender: AnyObject) {
        var tag = sender.tag
        switch tag
        {
        case 10 :
            println("你点击了上午")
        case 20 :
            println("你点击了下午")
        case 30 :
            println("你点击了提交")
        case 100 :
            self.navigationController?.popViewControllerAnimated(true)
        default :
            println()
        }
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var timeLabel = UILabel(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame)/2-10, 40))
        if component == 0
        {
            timeLabel.text = NSString(string: "\(row+15)日") as String
        }
        else
        {
            timeLabel.text = NSString(string: "星期\(row+1)") as String
        }
        timeLabel.textAlignment=NSTextAlignment.Center
        return timeLabel
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return NSString(string: "第\(row)行") as String
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
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
