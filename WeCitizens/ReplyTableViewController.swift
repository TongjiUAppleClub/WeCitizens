//
//  ReplyTableViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/24/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import MJRefresh
import FoldingCell
import MBProgressHUD

class ReplyTableViewController: UITableViewController,SSRadioButtonControllerDelegate{

    let kCloseCellHeight:CGFloat = 280
    let kOpenCellHeight:CGFloat = 940
    
    var cellHeights = [CGFloat]()
    var currentUserChoose:String?{
        didSet{
            print(currentUserChoose)
        }

    }
    
    var replyList = [Reply]()
    var replyModel = ReplyModel()
    var userModel = UserModel()
    var queryTimes = 0
    let number = 10

//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            print("RefreshingHeader")
            
            //上拉刷新，在获取数据后清空旧数据，并做缓存
            self.queryTimes = 0
            self.getReplyFromRemote()
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                
                self.tableView.mj_header.endRefreshing()
            }
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () -> Void in
            print("RefreshingFooter")
            
            //1.下拉加载数据，将新数据append到数组中，不缓存
            self.replyModel.getReply(self.number, queryTimes: self.queryTimes, cityName: "shanghai", needStore: false, resultHandler: { (results, error) -> Void in
                if let _ = error {
                    //有错误，给用户提示
                    print("get reply fail with error:\(error!.userInfo)")
                    self.processError(error!.code)
                } else {
                    if let replies = results {
                        replies.forEach({ (reply) -> () in
                            self.replyList.append(reply)
                        })
                        self.cellHeights = [CGFloat](count: self.replyList.count, repeatedValue: self.kCloseCellHeight)
                        self.tableView.reloadData()
                        self.queryTimes++
                    } else {
                        print("no data in refreshing footer")
                    }
                }
            })
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.tableView.mj_footer.endRefreshing()
            }
        })
        
        tableView.mj_header.automaticallyChangeAlpha = true
        
        //1.读缓存，如果有数据的话在tableView中填数据
        self.replyModel.getReply("shanghai") { (results, error) -> () in
            if let _ = error {
                //有错误，给用户提示
                print("get reply from local fail with error:\(error!.userInfo)")
                self.processError(error!.code)
            } else {
                if let replies = results {
                    self.replyList = replies
                    self.cellHeights = [CGFloat](count: self.replyList.count, repeatedValue: self.kCloseCellHeight)
                    self.tableView.reloadData()
                } else {
                    //没取到数据
                    print("no data from local")
                }
            }
        }
        
        //2.向后台请求数据，返回数据时做缓存
        getReplyFromRemote()
    }
    
    func getReplyFromRemote() {
        self.replyModel.getReply(self.number, queryTimes: self.queryTimes, cityName: "shanghai", needStore: true, resultHandler: { (results, error) -> Void in
            if let _ = error {
                //有错误，给用户提示
                print("get voice fail with error:\(error!.userInfo)")
                self.processError(error!.code)
            } else {
                if let replies = results {
                    self.replyList = replies
                    self.cellHeights = [CGFloat](count: self.replyList.count, repeatedValue: self.kCloseCellHeight)
                    self.tableView.reloadData()
                    self.queryTimes++
                } else {
                    //没取到数据
                    print("no data in refreshing header")
                }
            }
        })
    }
    
    func processError(errorCode:Int) {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = .Text
        let errorMessage:(label:String, detail:String) = convertPFNSErrorToMssage(errorCode)
        hud.labelText = errorMessage.label
        hud.detailsLabelText = errorMessage.detail
        hud.hide(true, afterDelay: 2.0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
    }
    
//MARK:- TableView Data Source & Delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return replyList.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
        
        imagesBinder(cell.imgContainer, images: [UIImage(named: "logo")!,UIImage(named: "logo")!])
        imagesBinder(cell.CimgContainer, images: [UIImage(named: "logo")!,UIImage(named: "logo")!])
        
        dataBinder(cell, reply: self.replyList[indexPath.section])
        
    
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
    func CheckResponse(sender:UIButton) {
        print("查看相关提议\(sender.tag)")
        
    }
    
    func CheckHistory(sender:UIButton) {
        print("查看过往\(sender.tag)")
    }
    
    func Submit(sender:UIButton) {
        print("提交\(sender.tag)")
        print("当前选择:\(currentUserChoose)")
    }
    
    func didSelectButton(aButton: UIButton?) {
        // print(aButton?.titleLabel?.text)
        currentUserChoose = aButton?.titleLabel?.text
    }

    func ScrollToEvaluate(sender:UIButton) {
        let indexPath = NSIndexPath(forRow: 0, inSection: sender.tag)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
    }
    
//MARK:- Data Binder
    func dataBinder(cell:ReplyTableViewCell,reply: Reply) {
        let user = reply.user!
        
        if let image = user.avatar {
            cell.Favatar.image = image
            cell.CAvatar.image = image
        } else {
            cell.Favatar.image = UIImage(named: "avatar")
            cell.CAvatar.image = UIImage(named: "avatar")
        }

        
        cell.FAgency.text = user.userName
        cell.CAgency.text = user.userName
        cell.ResponseTitle.text = reply.title
        cell.CTitle.text = reply.title
        cell.SupportPercent.text = "\(reply.satisfyLevel.satisfaction)%"//满意率
        cell.CSupport.text = "本回应的当前满意率为 \(reply.satisfyLevel.satisfaction)%"
        cell.CContent.text = reply.content
        let dateStr = reply.dateStr
        cell.ResponseTime.text = dateStr
        cell.CResponseTime.text = dateStr

        //投票这个功能不简单，让我再想想
//        if let attitude = reply.satisfyLevel!.attitude {
//            //这人有态度，把态度值填上，提交按钮禁用
//        } else {
//            //还未投票
//        }
        
        var tmp = [CGFloat]()
        tmp.append(CGFloat(reply.satisfyLevel.level1))
        tmp.append(CGFloat(reply.satisfyLevel.level2))
        tmp.append(CGFloat(reply.satisfyLevel.level3))
        tmp.append(CGFloat(reply.satisfyLevel.level4))
        
        cell.drawBarChart(tmp)
        
    }

    func imagesBinder(containter:UIView,images:[UIImage]) {
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
