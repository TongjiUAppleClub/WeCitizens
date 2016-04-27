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

class AddVoiceTableViewController: UITableViewController,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Content.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        VoiceTitle.backgroundColor = UIColor.clearColor()
        Content.backgroundColor = UIColor.clearColor()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //MARK:- Tags
        if indexPath.row == 1
        {
            let tag = ["教育", "安全", "民生", "哈哈", "Belgique", "Bulgarie", "Danemark"]
            RRTagController.displayTagController(self, tagsString: tag, blockFinish:
                { (selectedTags, unSelectedTags) -> () in
                    self.TagsLabel.text = "类型\t"
                    for tag in selectedTags
                    {
                        self.tags.append(tag.textContent)
                        self.TagsLabel.text?.appendContentsOf("\(tag.textContent) \t")
                    }
                }){ () -> () in}
        }
        //MARK:- Photos
        if indexPath.row == 2
        {
            PickImages()
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
}