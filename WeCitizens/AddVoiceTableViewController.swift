//
//  AddVoiceTableViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/21/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import Parse
import Photos
import MBProgressHUD
import BSImagePicker
import CoreLocation
import PromiseKit

class AddVoiceTableViewController: UITableViewController,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

  
    @IBOutlet weak var TitleCell: UITableViewCell!
    @IBOutlet weak var VoiceTitle: UITextField!
    
    @IBOutlet weak var TagsLabel: UILabel!
    @IBOutlet weak var Content: UITextView!
    
    @IBOutlet var Images: [UIImageView]!
    
    var tags = [String]()
    var isFullScreen:Bool = false
    var currentLocation:String? = nil
    var newImages = [UIImage](){
        didSet{
            for (index,image) in newImages.enumerate()
            {
                Images[index].image = image
                Images[index].setNeedsDisplay()
            }
        }
    }
   
    let imagePickerController = UIImagePickerController()
    let voiceModel = VoiceModel()
    let activityModel = ActivityModel()
    
    var locationManager:CLLocationManager? = nil
    var pointLocation:CLLocation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Content.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let authorityStatus = CLLocationManager.authorizationStatus()
        if getAuthorizationFromUser(authorityStatus) {
            startStandardUpdates()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        VoiceTitle.backgroundColor = UIColor.clearColor()
        Content.backgroundColor = UIColor.clearColor()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //MARK:- Tags
        if indexPath.row == 1 {
            let tag = ["消费", "教育", "环境", "食品", "居住", "就业", "医疗卫生", "其他", "安全", "交通"]
            RRTagController.displayTagController(self, tagsString: tag, blockFinish:
                { (selectedTags, unSelectedTags) -> () in
                    self.TagsLabel.text = "类型\t"
                    for tag in selectedTags {
                        self.tags.append(tag.textContent)
                        self.TagsLabel.text?.appendContentsOf("\(tag.textContent) \t")
                    }
                }){ () -> () in}
        }
        //MARK:- Photos
        if indexPath.row == 2 {
            PickImages()
        }
        
    }
    
    
    func startStandardUpdates() {
        if (locationManager == nil) {
            locationManager = CLLocationManager()
        }
        
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        locationManager!.startUpdatingLocation()
    }
    
    func getAuthorizationFromUser(status: CLAuthorizationStatus) -> Bool {
        
        var userIsAgreeUseLocaiton = false
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            //允许使用定位
            userIsAgreeUseLocaiton = true
        case .Denied, .Restricted:
            //没有获得授权，不允许使用定位
            //给用户提示，请求获得授权
            let alertController = UIAlertController(
                title: "定位权限被禁用",
                message: "请打开app的定位权限以获得当前位置信息",
                preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "设置", style: .Default) { (action) in
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            alertController.addAction(openAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        case .NotDetermined:
            //向用户申请授权
            locationManager = CLLocationManager()
            self.locationManager!.requestWhenInUseAuthorization()
            
            userIsAgreeUseLocaiton = true
        }
        return userIsAgreeUseLocaiton
    }
    
    
    
    @IBAction func PublishVoice(sender: UIBarButtonItem) {
                
        let title = VoiceTitle.text!
        let content = Content.text
        
        var abstract = content
        if content.characters.count >= 140 {
            let endIndex = content.startIndex.advancedBy(140)
            abstract = content.substringToIndex(endIndex)
        }
        let userName = PFUser.currentUser()!.username!
        let userEmail = PFUser.currentUser()!.email!
        let voiceType = TagsLabel.text
        
        if let locaiton = pointLocation {
            let newVoice = Voice(emailFromLocal: userEmail, name: userName, title: title, abstract: abstract, content: content, classify: voiceType!, city: "shanghai", latitude: locaiton.coordinate.latitude, longitude: locaiton.coordinate.longitude, images: newImages)
            
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.labelText = "发布中"
            hud.show(true)
            
            let user = PFUser.currentUser()!
            let activity = Activity(email: user.email!, name: user.username!, title: "\(user.username!)推送了一条新的Voice", content: newVoice.content)
            
            //TODO: 发布新Voice时需要为用户增加一个voice
            voiceModel.addNewVoice(newVoice).then { result in
                return self.activityModel.addNewActivity(activity)
            } .then { isSuccess -> Void in
                print("add new activity succes")
                hud.hide(true)
            } .error { err in
                print("add new voice error:\(err)")
                hud.mode = .Text
                
                let errorMessage:(label:String, detail:String) = convertPFNSErrorToMssage(101)
                hud.labelText = errorMessage.label
                hud.detailsLabelText = errorMessage.detail
                hud.hide(true, afterDelay: 1.5)
            }
        } else {
            print("还没有获取到定位数据")
        }
    }
    
    @IBAction func PickImages() {
     ts_presentImagePickerController(
            maxNumberOfSelections: 4,
            select: { (asset: PHAsset) -> Void in
            }, deselect: { (asset: PHAsset) -> Void in
            }, cancel: { (assets: [PHAsset]) -> Void in
            }, finish: { (assets: [PHAsset]) -> Void in
                self.newImages = []
                for (_,asset) in assets.enumerate()
                {
                    let image = asset.getUIImage()
                    self.newImages.append(image!)
                }
            }, completion: { () -> Void in
                print("completion")
        })
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        //停止定位定位更新以降低能耗
        locationManager?.stopUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            self.pointLocation = currentLocation
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        //当用户修改定位权限时给用户提示申请定位权限
        if getAuthorizationFromUser(status) {
            startStandardUpdates()
        }
    }
}