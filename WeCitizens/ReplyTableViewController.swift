//
//  ReplyTableViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/24/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import FoldingCell

class ReplyTableViewController: UITableViewController,SSRadioButtonControllerDelegate{

    let kRowsCount = 10
    let kCloseCellHeight:CGFloat = 280
    let kOpenCellHeight:CGFloat = 940
    
    var cellHeights = [CGFloat]()
    var currentUserChoose:String?{
        didSet{
            print(currentUserChoose)
        }

    }
    
    var replyList = [Reply]()
    var dataModel = DataModel()
    var userModel = UserModel()
    var queryTimes = 0
    

//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //获取当前城市或用户设置城市
        let cityName = "shanghai"
        
        if 0 == replyList.count {
            dataModel.getReply(20, queryTimes: queryTimes, cityName: cityName, resultHandler: { (issues, error) -> Void in
                if error == nil {
                    if let list = issues {
                        self.replyList = list
                        var userList = [String]()
                        for reply in list {
                            userList.append(reply.userEmail)
                        }
                        self.userModel.getUsersAvatar(userList, resultHandler: { (objects, error) -> Void in
                            if nil == error {
                                if let results = objects {
                                    for reply in self.replyList {
                                        for user in results {
                                            if reply.userEmail == user.email {
                                                reply.user = user
                                            }
                                        }
                                    }
                                    self.tableView.reloadData()
                                    self.queryTimes++
                                }
                            }
                        })
                    }
                } else {
                    print("Propose Error: \(error!) \(error!.userInfo)")
                }
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
    }
    
//MARK:- TableView Data Source & Delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return kRowsCount
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 7
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let view = UIView(frame: (CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 7)) )
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell is FoldingCell {
            let foldingCell = cell as! FoldingCell
            foldingCell.backgroundColor = UIColor.clearColor()
            
            if cellHeights[indexPath.section] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoldingCell", forIndexPath: indexPath) as! ReplyTableViewCell
        
        //测试数据
        cell.CResponseButton.tag = indexPath.section
        cell.CResponseButton.addTarget(self, action: "CheckResponse:", forControlEvents: .TouchUpInside)
        cell.EvaluateButton.tag = indexPath.section
        cell.EvaluateButton.addTarget(self, action: "ScrollToEvaluate:", forControlEvents: .TouchUpInside)
        cell.CheckHistoryButton.tag = indexPath.section
        cell.CheckHistoryButton.addTarget(self, action: "CheckHistory:", forControlEvents: .TouchUpInside)
        cell.SubmitButton.tag = indexPath.section
        cell.SubmitButton.addTarget(self, action: "Submit:", forControlEvents: .TouchUpInside)
        cell.radioButtonController?.delegate = self
        
        imagesBinder(cell.imgContainer, images: [UIImage(named: "logo")!,UIImage(named: "logo")!])
        imagesBinder(cell.CimgContainer, images: [UIImage(named: "logo")!,UIImage(named: "logo")!])
        
//      dataBinder(cell,<#Response#>)
        
    
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.section]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if cellHeights[indexPath.section] == kCloseCellHeight { // open cell
            cellHeights[indexPath.section] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.section] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
        
        
    }
    
//MARK:- Actions
//TODO:- User Action Update to the server
    func CheckResponse(sender:UIButton)
    {
        print("查看相关提议\(sender.tag)")
        
    }
    
    func CheckHistory(sender:UIButton)
    {
        print("查看过往\(sender.tag)")
    }
    
    func Submit(sender:UIButton)
    {
        print("提交\(sender.tag)")
        print("当前选择:\(currentUserChoose)")
    }
    
    func didSelectButton(aButton: UIButton?) {
        // print(aButton?.titleLabel?.text)
        currentUserChoose = aButton?.titleLabel?.text
    }

    func ScrollToEvaluate(sender:UIButton)
    {
        let indexPath = NSIndexPath(forRow: 0, inSection: sender.tag)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
    }
    
//MARK:- Data Binder
//    func dataBinder(cell:ReplyTableViewCell,comment:<#Response#>)
//    {
//        cell.Favatar.image = <#User Avatar#>
//        cell.CAvatar.image = <#User Avatar#>
//        
//        cell.FAgency.text = <#AgencyName#>
//        cell.ResponseTitle.text = <#Response Title#>
//        cell.CTitle.text = <#Response Title#>
//        cell.SupportPercent.text = <#Support Percent#>
//        cell.CSupport.text = "本回应的当前满意率为 \(<#Support Percent#>>)%"
//        cell.CContent.text = <#Response Content#>
//        cell.CResponseTime.text = <#Response Time#>
//        
//    }

    func imagesBinder(containter:UIView,images:[UIImage])
    {
        let Xoffset = CGFloat(6)
        let Yoffset = CGFloat(4)
        for view in containter.subviews
        {
            if view.tag == 1
            {
                view.removeFromSuperview()
            }
        }
        switch images.count
        {
        case 1:
            let imgView = UIImageView(image: images.first)
            imgView.frame = containter.frame
            imgView.frame.origin = CGRectZero.origin
            imgView.frame.size.width = tableView.frame.width - 40
            containter.addSubview(imgView)
            break;
        case 2:
            let img1 = UIImageView(image: images[1])
            img1.frame = containter.frame
            img1.frame.origin = CGRectZero.origin
            img1.frame.size.width = tableView.frame.width - 30
            img1.frame.size.width /= 2
            containter.addSubview(img1)
            let img2 = UIImageView(image: images[0])
            img2.frame = img1.frame
            img2.frame.origin.x += (img2.frame.size.width + Xoffset)
            containter.addSubview(img2)
            break;
        case 3:
            let img1 = UIImageView(image: images[0])
            img1.frame = containter.frame
            img1.frame.size.width = tableView.frame.width - 40
            img1.frame.origin = CGRectZero.origin
            img1.frame.size.width /= 2
            img1.frame.size.height += Yoffset
            containter.addSubview(img1)
            let img2 = UIImageView(image: images[1])
            img2.frame = img1.frame
            img2.frame.origin.x += (img2.frame.size.width + Xoffset)
            img2.frame.size.height /= 2
            containter.addSubview(img2)
            let img3 = UIImageView(image: images[2])
            img3.frame = img2.frame
            img3.frame.origin.y += img3.frame.size.height + Yoffset
            containter.addSubview(img3)
            break;
        case 4:
            let img1 = UIImageView(image: images[0])
            img1.frame = containter.frame
            img1.frame.size.width = tableView.frame.width - 40
            img1.frame.origin = CGRectZero.origin
            img1.frame.size.width /= 2
            img1.frame.size.height /= 2
            
            containter.addSubview(img1)
            let img2 = UIImageView(image: images[1])
            img2.frame = img1.frame
            img2.frame.origin.x += (img2.frame.size.width + Xoffset)
            containter.addSubview(img2)
            let img3 = UIImageView(image: images[2])
            img3.frame = img2.frame
            img3.frame.origin.y += img3.frame.size.height + Yoffset
            containter.addSubview(img3)
            let img4 = UIImageView(image: images[3])
            img4.frame = img3.frame
            img4.frame.origin.x = img1.frame.origin.x
            containter.addSubview(img4)
            break;
        default:
            containter.removeFromSuperview()
            break;
        }
        for  view in containter.subviews
        {
            view.tag = 1
            view.layer.masksToBounds = false
            view.layer.cornerRadius = 5
            view.clipsToBounds = true
        }
    }

}
