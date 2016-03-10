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
    let testAvatar =  UIImage(named: "avatar")
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
        tableView.reloadData()
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
        return COMMENT_NUM
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
      let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentTableViewCell
        
        cell.VoiceTitle.text = testTitle
        cell.Avatar.image = testAvatar
        cell.CommentUser.text = testCommentUser
        cell.UpdateTime.text = testTime
        cell.Abstract.text = testAbstract
        cell.Classify.text = testClassify
        cell.Reputation.text = testReputaion

   //  Uncomment This Line and Delete the line above to bind the data to cell
   //  dataBinder(cell,issues[indexPath.row])
       imagesBinder(cell.ImgesContainer, images: testImages )
       return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "ShowDetail")
        {
            let controller = segue.destinationViewController as! VoiceDetailTableViewController
            //let row = ( sender as! NSIndexPath ).row
            controller.title = testTitle
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

//MARK:- Data Binder
    func dataBinder(cell:CommentTableViewCell,comment:Issue)
    {
        cell.VoiceTitle.text = comment.issueTitle
        cell.Avatar.image = comment.userAvatar
        cell.CommentUser.text = comment.userName
        cell.UpdateTime.text = comment.issueTime
        cell.Abstract.text = comment.issueAbstract
        cell.Classify.text = comment.issueClassify
        cell.ClassifyKind = UIImageView(image: UIImage(named: comment.issueClassify))
        cell.Reputation.text = comment.userResume
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

