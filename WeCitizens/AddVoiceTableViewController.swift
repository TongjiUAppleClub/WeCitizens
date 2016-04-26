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

class AddVoiceTableViewController: UITableViewController,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  
    @IBOutlet weak var TitleCell: UITableViewCell!
    @IBOutlet weak var BodyCell: UITableViewCell!
    @IBOutlet weak var VoiceTitle: UITextField!
    @IBOutlet weak var Content: UITextView!
    var currentLocation:String? = nil
    
    var newImages = [UIImage]()
    
    let imagePickerController = UIImagePickerController()
    var isFullScreen:Bool = false
    let voiceModel = VoiceModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Content.delegate = self
        // self.clearsSelectionOnViewWillAppear = false
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureUI() {

     VoiceTitle.backgroundColor = UIColor.clearColor()
     Content.backgroundColor = UIColor.clearColor()
    
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1
        {
            let tag = ["Albanie", "Allemagne", "Andorre", "Autriche-Hongrie", "Belgique", "Bulgarie", "Danemark", "Espagne", "France", "Grèce", "Italie", "Liechtenstein", "Luxembourg", "Monaco", "Monténégro", "Norvège", "Pays-Bas", "Portugal", "Roumanie", "Royaume-Uni", "Russie", "Saint-Marin", "Serbie", "Suède", "Suisse"]
            
            RRTagController.displayTagController(self, tagsString: tag, blockFinish: { (selectedTags, unSelectedTags) -> () in
            }) { () -> () in
            }

        }
    }
    
    
    @IBAction func PublishVoice(sender: UIBarButtonItem) {
        
        let title = VoiceTitle.text!
        let content = Content.text
        
        var abstract = content
        if content.characters.count >= 140 {
            let endIndex = content.startIndex.advancedBy(-140)
            abstract = content.substringWithRange(Range<String.Index>(start: content.startIndex, end: endIndex))
        }
        let userName = PFUser.currentUser()!.username!
        let userEmail = PFUser.currentUser()!.email!
        let voiceType = "教育"
        
        let newVoice = Voice(emailFromLocal: userEmail, name: userName, title: title, abstract: abstract, content: content, classify: voiceType, city: "shanghai", images: newImages)
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//        hud.mode = .AnnularDeterminate
        hud.labelText = "发布中"
        hud.show(true)
        
        voiceModel.addNewVoice(newVoice) { (success, error) -> Void in
            if nil == error {
                if success {
                    print("Add new voice success")
                    hud.hide(true)
                    self.navigationController?.popViewControllerAnimated(true)
                    //给用户提示
                }
            } else {
                hud.mode = .Text
                print("Add new voice Error: \(error!) \(error!.userInfo)")
                let errorMessage:(label:String, detail:String) = convertPFNSErrorToMssage(error!.code)
                hud.labelText = errorMessage.label
                hud.detailsLabelText = errorMessage.detail
                hud.hide(true, afterDelay: 1.5)
                //给用户提示
            }
        }
        
    }
    
    @IBAction func PickImages(sender: UIBarButtonItem) {
        
//        self.ts_presentImagePickerController(
//            maxNumberOfSelections: 4,
//            select: { (asset: PHAsset) -> Void in
//            }, deselect: { (asset: PHAsset) -> Void in
//            }, cancel: { (assets: [PHAsset]) -> Void in
//            }, finish: { (assets: [PHAsset]) -> Void in
//                for (index,asset) in assets.enumerate()
//                {
//                    let image = asset.getUIImage()
//                    self.newImages.append(image!)
//                    print(image)
//                }
//                
//            }, completion: { () -> Void in
//                print("completion")
//        })
//        
        
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.defaultManager()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.synchronous = true
        manager.requestImageForAsset(asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }

}

public extension UIViewController {
    /**
     封装一下 BSImagePickerViewController ，改变 UINavigationBar 的颜色
     
     - parameter maxNumberOfSelections: 最多选 多少个
     - parameter select:                选中的图片
     - parameter deselect:              反选中的图片
     - parameter cancel:                取消按钮
     - parameter finish:                完成按钮
     - parameter completion:            dimiss回掉完成
//     */
//    func ts_presentImagePickerController(maxNumberOfSelections maxNumberOfSelections: Int, select: ((asset: PHAsset) -> Void)?, deselect: ((asset: PHAsset) -> Void)?, cancel: (([PHAsset]) -> Void)?, finish: (([PHAsset]) -> Void)?, completion: (() -> Void)?) {
//        
//        let viewController = BSImagePickerViewController()
//        viewController.maxNumberOfSelections = maxNumberOfSelections
//        viewController.albumButton.tintColor = UIColor.redColor()
//        viewController.cancelButton.tintColor = UIColor.redColor()
//        viewController.doneButton.tintColor = UIColor.redColor()
//        
//        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: false)
//        self.bs_presentImagePickerController(viewController, animated: true,
//            select: select, deselect: deselect, cancel: cancel, finish: finish, completion:nil)
//    }
    
}

extension PHAsset {
    func getUIImage() -> UIImage? {
        let manager = PHImageManager.defaultManager()
        let options = PHImageRequestOptions()
        options.synchronous = true
        options.networkAccessAllowed = true
        options.version = .Current
        options.deliveryMode = .HighQualityFormat
        options.resizeMode = .Exact
        
        var image: UIImage?
        manager.requestImageForAsset(
            self,
            targetSize: CGSize(width: CGFloat(self.pixelWidth), height: CGFloat(self.pixelHeight)),
            contentMode: .AspectFill,
            options: options,
            resultHandler: {(result, info)->Void in
                if let theResult = result {
                    image = theResult
                } else {
                    image = nil
                }
        })
        return image
    }
    
}