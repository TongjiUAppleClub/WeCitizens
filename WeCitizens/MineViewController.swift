//
//  MineViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 3/27/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import Parse

class MineViewController: UITableViewController {

    @IBOutlet weak var HeadView: UIView!
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Reputation: UILabel!
    @IBOutlet weak var VoiceStatisticsLabel: UILabel!
    
    let userModel = UserModel()
    var user:User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userEmail = PFUser.currentUser()?.email
        
        userModel.getUserInfo(userEmail!) { (currentUser, error) -> Void in
            print("Email:\(userEmail)")
            if nil == error {
                if let user = currentUser {
                    print("user:\(user)")
                    self.user = user
                    self.setUserData()
                } else {
                    //获取user信息失败，给用户提示
                    print("获取user信息失败")
                }
            } else {
                //获取信息失败，给用户提示
                print("获取user信息失败：\(error)")
            }
        }
    }
    
    func setUserData() {
        UserName.text = self.user!.userName
        VoiceStatisticsLabel.text = "已发布\(self.user!.voiceNum)个心声，获得\(self.user!.focusNum)个关注"
        Reputation.text = "\(self.user!.resume)"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UIconfigure()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func UIconfigure() {
      tableView.backgroundView = UIImageView(image: UIImage(named: "mine_view_background"))

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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        switch indexPath.row {
        case 0:
            let controller = storyboard?.instantiateViewControllerWithIdentifier("MyActivity") as! MyActivitiesTableViewController
            // TODO:初始化数据

            self.navigationController?.pushViewController(controller, animated: true)
            
            break
        case 1:
            
            let controller = storyboard?.instantiateViewControllerWithIdentifier("EditInfo") as! EditUserInfoControler
            controller.user = self.user
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 2:
            navigationController?.pushViewController((storyboard?.instantiateViewControllerWithIdentifier("About"))!, animated: true)
            break
        case 3:
            PFUser.logOut()
            presentViewController((storyboard?.instantiateViewControllerWithIdentifier("WelcomeView"))!, animated: true, completion: nil)
            break
        default:
            break
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        let titles                            = ["我的动态", "编辑个人信息", "关于", "退出登陆"]
        let images                            = ["time", "personal_info",  "about", "exit"]
        let imgWidthScale = 16 / (UIImage(named: images[indexPath.row])?.size.width)!
        let imgHeightScale = 16 / (UIImage(named: images[indexPath.row])?.size.height)!
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.text = titles[indexPath.row]
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        cell.imageView?.transform = CGAffineTransformMakeScale(imgWidthScale, imgHeightScale)
       
        
        return cell
    }
    
}
