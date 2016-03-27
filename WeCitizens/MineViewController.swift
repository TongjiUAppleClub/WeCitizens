//
//  MineViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 3/27/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {

    @IBOutlet weak var HeadView: UIView!
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Reputation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UIconfigure()
    }
    
    func UIconfigure()
    {
      tableView.backgroundView = UIImageView(image: UIImage(named: "mine_view_background"))
      self.navigationController?.navigationBar.hidden = true
      HeadView.backgroundColor = UIColor.lxd_MainBlueColor()
      Avatar = UIImageView.lxd_CircleImage(Avatar, borderColor: UIColor.clearColor(), borderWidth: 1.0)
      Reputation.backgroundColor = UIColor.lxd_YellowColor()
      Reputation.clipsToBounds = true
      Reputation.layer.cornerRadius = Reputation.frame.height/2
        
    }
   
//MARK:- TableView Delegate && DataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        let titles                            = ["我的动态", "编辑个人信息", "设置", "关于", "退出登陆"]
        let images                            = ["time", "personal_info", "setting", "about", "exit"]
        let imgWidthScale = 16 / (UIImage(named: images[indexPath.row])?.size.width)!
        let imgHeightScale = 16 / (UIImage(named: images[indexPath.row])?.size.height)!
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.text = titles[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        cell.imageView?.transform = CGAffineTransformMakeScale(imgWidthScale, imgHeightScale)
       
        
        return cell
    }
    
}
