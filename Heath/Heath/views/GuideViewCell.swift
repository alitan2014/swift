//
//  GuideViewCell.swift
//  Heath
//
//  Created by TCL on 15/8/22.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

import UIKit
typealias senderButtonClickBlock=(UIButton)->Void
class GuideViewCell: UITableViewCell {
    var sendButtonClick:senderButtonClickBlock!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var doctorTitleLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var outTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLabel.textColor=UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1)
        self.orderButton.setTitleColor(UIColor(red: 251/255.0, green: 78/255.0, blue: 10/255.0, alpha: 1), forState: UIControlState.Normal)
        self.headImageView.layer.cornerRadius=8
        self.headImageView.contentMode=UIViewContentMode.ScaleAspectFill
        self.headImageView.clipsToBounds=true
        self.orderButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    func refreshCellWihtDoctorModel(model:DoctorModel)
    {
    
        var url=NSURL(string: model.expertpicpath)
        self.headImageView.sd_setImageWithURL(url)
        self.nameLabel.text=model.expertname
        self.doctorTitleLabel.text=model.experttitle
        self.outTimeLabel.text=model.expertvisittime
    }
    @IBAction func btnClick(sender: AnyObject) {
        if (self.sendButtonClick != nil)
        {
            self.sendButtonClick(sender as! UIButton)
        }
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
