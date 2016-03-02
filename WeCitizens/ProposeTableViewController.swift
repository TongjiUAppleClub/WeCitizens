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
    let testCommentUser = "Harold"
    let testAbstract = "懵逼快出图！！！"
    let testTime = "2016.2.14"
    let testBrowser = "10247"
    let testClassify = "Education"
    let testReputaion = "452"
    let testImages = [UIImage(named: "logo")!,UIImage(named: "logo")!,UIImage(named: "logo")!]
    
    
    
    let locationManager = CLLocationManager()
    var currentLocal:String = "－－－－"
    
    
//MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        self.clearsSelectionOnViewWillAppear = false
        initLocation()
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
        return COMMENT_NUM
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
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
   //     cell.imageContainter.delegate = self
        //TODO:- Set every cell from the data
        cell.VoiceTitle.text = testTitle
        cell.Avatar.image = testAvatar
        cell.CommentUser.text = testCommentUser
        cell.UpdateTime.text = testTime
        cell.Abstract.text = testAbstract
        cell.Classify.text = testClassify
        cell.Reputation.text = testReputaion
        cell.BrowseNum.text = testBrowser
   //     imagesLayout(cell, images: testImages)
        return cell
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowDetail")
        {
            let controller = segue.destinationViewController as! VoiceDetailTableViewController
            //let row = ( sender as! NSIndexPath ).row
            controller.title = testAbstract
            
        }
    }
    
    
//MARK:- UIConfigure
    
    func configureUI()
    {
        tableView.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
        
        let titleView = UIView(frame: (CGRectMake(0, 0, 150, 44)))
        let switchButton = UIButton(frame: CGRectMake(105, 0, 30, 44))
        let locationLabel = UILabel(frame: (CGRectMake(0, 0, 110, 44)))
        
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
                        print(city)
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

//MARK:- Data Blinder
//    func imagesLayout(cell:CommentTableViewCell,images:[UIImage])
//    {
//        var size = cell.imageContainter.frame.size
//        size.width  = size.width/2 *  CGFloat(images.count)
//        cell.imageContainter.contentSize = size
//        cell.imageContainter.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
//        for view in cell.subviews
//        {
//            if view.tag == 1
//            {
//                view.removeFromSuperview()
//            }
//        }
//    
//        for (index,image) in images.enumerate()
//        {
//            var commentImg:UIImageView!
//            commentImg = UIImageView(image: image)
//            commentImg.tag = 1
//            var imageF = cell.imageContainter.frame
//            imageF.origin.y = 0
//            imageF.size.width /= 2
//            imageF.origin.x = CGFloat(index) * (imageF.size.width)
//            
//            commentImg.frame = imageF
//            cell.imageContainter.addSubview(commentImg)
//        }
//    }

    
}

