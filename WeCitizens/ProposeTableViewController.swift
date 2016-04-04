//
//  ProposeTableViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/11/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import MJRefresh
import CoreLocation

class ProposeTableViewController: UITableViewController,CLLocationManagerDelegate{
  
    let tmpAvatar =  UIImage(named: "avatar")
    let testImages = [UIImage(named: "logo")!,UIImage(named: "logo")!]    
    
    let locationManager = CLLocationManager()
    let locationLabel = UILabel(frame: (CGRectMake(0, 0, 110, 44)))
    var currentLocal:String = "－－－－" {
        didSet{
            locationLabel.text = currentLocal
        }
    }
    
    var voiceList = [Voice]()
    let voiceModel = VoiceModel()
    let userModel = UserModel()
    let number = 10
    var queryTimes = 0
    
    
//MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        self.clearsSelectionOnViewWillAppear = false
        initLocation()
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            print("RefreshingHeader")
            
            //上拉刷新，在获取数据后清空旧数据，并做缓存
            self.queryTimes = 0
            self.getVoiceFromRemote()
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                
                self.tableView.mj_header.endRefreshing()
            }
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () -> Void in
            print("RefreshingFooter")
            
            //1.下拉加载数据，将新数据append到数组中，不缓存
            self.voiceModel.getVoice(self.number, queryTimes: self.queryTimes, cityName: "shanghai", needStore: false, resultHandler: { (results, error) -> Void in
                if let _ = error {
                    //有错误，给用户提示
                    print("get voice fail with error:\(error!.userInfo)")
                } else {
                    if let voices = results {
                        voices.forEach({ (voice) -> () in
                            self.voiceList.append(voice)
                        })
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
        self.voiceModel.getVoice("shanghai") { (results, error) -> Void in
            if let _ = error {
                //有错误，给用户提示
                print("get voice from local fail with error:\(error!.userInfo)")
            } else {
                if let voices = results {
                    self.voiceList = voices
                    self.tableView.reloadData()
                } else {
                    //没取到数据
                    print("no data from local")
                }
            }
        }
        
        //2.向后台请求数据，返回数据时做缓存
        getVoiceFromRemote()
    }
    
    func getVoiceFromRemote() {
        self.voiceModel.getVoice(self.number, queryTimes: self.queryTimes, cityName: "shanghai", needStore: true, resultHandler: { (results, error) -> Void in
            if let _ = error {
                //有错误，给用户提示
                print("get voice fail with error:\(error!.userInfo)")
            } else {
                if let voices = results {
                    self.voiceList = voices
                    self.tableView.reloadData()
                    self.queryTimes++
                } else {
                    //没取到数据
                    print("no data in refreshing header")
                }
            }
        })
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
        
    }
    
// MARK:- Table view data source && delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return voiceList.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ShowDetail", sender: indexPath)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: (CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 7)) )
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentTableViewCell
        
        dataBinder(cell, voice: self.voiceList[indexPath.section])
        imagesBinder(cell.ImgesContainer, images: testImages )
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowDetail") {
            let controller = segue.destinationViewController as! VoiceDetailTableViewController
            let row = ( sender as! NSIndexPath ).row
            controller.title = self.voiceList[row].title
            controller.voice = self.voiceList[row]
        
        } else if (segue.identifier == "PushVoice") {
            let controller = segue.destinationViewController as! AddVoiceTableViewController
            controller.currentLocation = self.currentLocal
        }
    }
    
    
//MARK:- UIConfigure
    
    func configureUI() {
        tableView.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
        
        let titleView = UIView(frame: (CGRectMake(0, 0, 150, 44)))
        let switchButton = UIButton(frame: CGRectMake(105, 0, 30, 44))
        
        
        locationLabel.text = currentLocal
        locationLabel.textColor = UIColor.lxd_MainBlueColor()
        locationLabel.textAlignment = NSTextAlignment.Right
        
        switchButton.setImage(UIImage(named: "switch"), forState: .Normal)
    
        switchButton.addTarget(self, action: "ChangeLocation:", forControlEvents: UIControlEvents.TouchUpInside)
        
        titleView.addSubview(locationLabel)
        titleView.addSubview(switchButton)

        self.navigationItem.titleView = titleView
    }
    
    func ChangeLocation(sender:UIButton) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("LocationTable")
        self.navigationController?.pushViewController(controller!, animated: true)
        
    }
    
//MARK:- Location Init
    func initLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.distanceFilter = 1000
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
                        print("location:\(self.currentLocal)")
                    }
                }
            }
        }
        else
        {
            print("No location")
        }
    }

    func dataBinder(cell:CommentTableViewCell,voice:Voice) {
        cell.VoiceTitle.text = voice.title
        if let image = voice.user?.avatar {
            cell.Avatar.image = image
        } else {
            cell.Avatar.image = tmpAvatar
        }
        cell.Reputation.text = "\(voice.user!.resume)"
        cell.CommentUser.text = "\(voice.user!.userName)"
        cell.UpdateTime.text = voice.dateStr
        cell.Abstract.text = voice.abstract
        cell.Classify.text = voice.classify.rawValue
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

