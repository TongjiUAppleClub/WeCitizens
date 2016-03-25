//
//  ProposeTableViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/11/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import CoreLocation

class ProposeTableViewController: UITableViewController,CLLocationManagerDelegate{

//TODO:- Get the comment list  
// I will give the example data and show how to use it
    let COMMENT_NUM = 3
    
    let testTitle = "XX中学体罚学生情况严重"
    let tmpAvatar =  UIImage(named: "avatar")
    let testCommentUser = "名字"
    let testAbstract = "dsafadfdjflsjladjlfkjlajlgdsdfasdfal柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是l柔周乔布斯成功的主要原因是sfafafdafdsgfdfdfafdafaffafafafafafaffdafafafaffafslskjljlakgjljl柔周乔布斯成功的主要原因是什么？"
    let testTime = "2016.2.14"
    let testBrowser = "10247"
    let testClassify = "教育"
    let testReputaion = "452"
    let testImages = [UIImage(named: "logo")!,UIImage(named: "logo")!]
// Delete the line above & give the real data
    
    
    let locationManager = CLLocationManager()
    let locationLabel = UILabel(frame: (CGRectMake(0, 0, 110, 44)))
    var currentLocal:String = "－－－－"{
        didSet{
            locationLabel.text = currentLocal
        }
    }
    
    var issueList = [Issue]()
    let dataModel = DataModel()
    let userModel = UserModel()
    var queryTimes = 0
    
    
//MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        self.clearsSelectionOnViewWillAppear = false
        initLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//TODO:- Reloaddata here
        
//        //获取当前城市或用户设置城市
        let cityName = "shanghai"
        
        if 0 == issueList.count {
            dataModel.getIssue(20, queryTimes: self.queryTimes, cityName: cityName, resultHandler: { (issues, error) -> Void in
                if error == nil {
                    if let list = issues {
                        self.issueList = list
                        var userList = [String]()
                        for object in list {
                            print("Issue内容:\(object.userEmail)")
                            userList.append(object.userEmail)
                        }
                        self.userModel.getUsersAvatar(userList, resultHandler: { (objects, error) -> Void in
                            if nil == error {
                                if let results = objects {
                                    for issue in self.issueList {
                                        for user in results {
                                            if issue.userEmail == user.email {
                                                issue.user = user
                                            }
                                        }
                                    }
                                    self.tableView.reloadData()
                                    self.queryTimes++;
                                } else {
                                    print("no users")
                                }
                            } else {
                                print("Get User info Propose Error: \(error!) \(error!.userInfo)")
                            }
                        })
                    }
                } else {
                    print("Get Issue info Propose Error: \(error!) \(error!.userInfo)")
                }
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
        
    }
    
// MARK:- Table view data source && delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return issueList.count
//        return 3
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 7
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("ShowDetail", sender: indexPath)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let view = UIView(frame: (CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 7)) )
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentTableViewCell
        
//        cell.VoiceTitle.text = testTitle//测试数据
//        cell.Avatar.image = tmpAvatar
//        cell.CommentUser.text = testCommentUser
//        cell.UpdateTime.text = testTime
//        cell.Abstract.text = testAbstract
//        cell.Classify.text = testClassify
//        cell.Reputation.text = testReputaion
        
        cell.VoiceTitle.text = issueList[indexPath.row].title
        if let image = issueList[indexPath.row].user!.avatar {
            cell.Avatar.image = image
        } else {
            cell.Avatar.image = tmpAvatar
        }
        cell.Reputation.text = "\(issueList[indexPath.row].user!.resume)"
        cell.CommentUser.text = "\(issueList[indexPath.row].focusNum)"
        cell.UpdateTime.text = issueList[indexPath.row].getDateString()
        cell.Abstract.text = issueList[indexPath.row].abstract
        cell.Classify.text = issueList[indexPath.row].classify.rawValue
        

   //  Uncomment This Line and Delete the line above to bind the data to cell
   //  dataBinder(cell,issues[indexPath.row])
       imagesBinder(cell.ImgesContainer, images: testImages )
       return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowDetail") {
            let controller = segue.destinationViewController as! VoiceDetailTableViewController
            let row = ( sender as! NSIndexPath ).row
            controller.title = self.issueList[row].title
            controller.issue = self.issueList[row]
        
        } else if (segue.identifier == "PushVoice") {
            let controller = segue.destinationViewController as! AddVoiceTableViewController
            controller.currentLocation = self.currentLocal
        }
    }
    
    
//MARK:- UIConfigure
    
    func configureUI()
    {
        tableView.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
        
        let titleView = UIView(frame: (CGRectMake(0, 0, 150, 44)))
        let switchButton = UIButton(frame: CGRectMake(105, 0, 30, 44))
        
        
        locationLabel.text = currentLocal
        locationLabel.textColor = UIColor(red: 237.0/255, green: 78/255, blue: 48/255, alpha: 1.0)
        locationLabel.textAlignment = NSTextAlignment.Right
        
        switchButton.setImage(UIImage(named: "switch"), forState: .Normal)
        switchButton.addTarget(self, action: "ChangeLocation:", forControlEvents: UIControlEvents.TouchUpInside)
        
        titleView.addSubview(locationLabel)
        titleView.addSubview(switchButton)

        self.navigationItem.titleView = titleView
    }
    
    func ChangeLocation(sender:UIButton)
    {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("LocationTable")
        self.navigationController?.pushViewController(controller!, animated: true)
        
    }
    
//MARK:- Location Init
    func initLocation()
    {
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.distanceFilter = 1000
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let currentLocation = locations.last {
            let long = currentLocation.coordinate.longitude
            let lat = currentLocation.coordinate.latitude
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: lat, longitude:long)
            
            geoCoder.reverseGeocodeLocation(location) { (placemark, error) -> Void in
                if let validPlacemark = placemark?[0]{
                    let placemark = validPlacemark as CLPlacemark;
                    if let city = placemark.addressDictionary!["City"] as? NSString {
                        self.currentLocal = city as String
                    }
                }
            }
        }
        else
        {
            print("No location")
        }
    }

//MARK:- Data Binder这个是干啥的？
    func dataBinder(cell:CommentTableViewCell,comment:Issue)
    {
        cell.VoiceTitle.text = comment.title
//        cell.Avatar.image = comment.avatar//使用UserModel请求头像
        cell.CommentUser.text = comment.userName
        cell.UpdateTime.text = "今天"//comment.time
        cell.Abstract.text = comment.abstract
//        cell.Classify.text = comment.classify
//        cell.ClassifyKind = UIImageView(image: UIImage(named: comment.classify))
//        cell.Reputation.text = "\(comment.userResume)"//使用UserModel请求用户信誉度
    }
    
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

