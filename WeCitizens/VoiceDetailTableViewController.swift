//
//  ProposeTableViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/11/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import SnapKit
import Parse

let toolBarMinHeight:CGFloat = 50
let textViewMaxHeight: (portrait: CGFloat, landscape: CGFloat) = (portrait: 272, landscape: 90)

class InputTextView: UITextView {
    
    
    
}

class VoiceDetailTableViewController: UITableViewController,UITextViewDelegate{
    
   
    var toolBar:UIToolbar!
    var textView:UITextView!
    var sendButton:UIButton!
    
    
    let commentModel = CommentModel()
    let userModel = UserModel()
    var queryTimes = 0
    var voice:Voice?
    var commentList = [Comment]()
    
    
    override var inputAccessoryView:UIView! {
        get{
            if toolBar == nil
            {
                toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: toolBarMinHeight-0.5))
                
                textView = InputTextView(frame: CGRectZero)
                textView.delegate = self
                textView.backgroundColor = UIColor(white: 250/255, alpha: 1.0)
                textView.font = UIFont.systemFontOfSize(17)
                textView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha: 1.0).CGColor
                textView.layer.borderWidth = 0.5
                textView.layer.cornerRadius = 5
                textView.scrollsToTop = false
                
                toolBar.addSubview(textView)
                
                sendButton = UIButton(type: .System)
                sendButton.enabled = false
                sendButton.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
                sendButton.setTitle("评论", forState: .Normal)
                sendButton.setTitleColor(UIColor(red: 243.0/255, green: 77/255, blue: 54/255, alpha: 1.0), forState: .Normal)
                sendButton.setTitleColor(UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1),forState: .Disabled)
                sendButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                sendButton.addTarget(self, action: "SendComment", forControlEvents: UIControlEvents.TouchUpInside)
                
                toolBar.addSubview(sendButton)
                
                textView.translatesAutoresizingMaskIntoConstraints = false
                sendButton.translatesAutoresizingMaskIntoConstraints = false
                
                textView.snp_makeConstraints(closure: { (make) -> Void in
                    make.left.equalTo(self.toolBar.snp_left).offset(8)
                    make.top.equalTo(self.toolBar.snp_top).offset(7.5)
                    make.right.equalTo(self.sendButton.snp_left).offset(-2)
                    make.bottom.equalTo(self.toolBar.snp_bottom).offset(-8)
                })
                
                sendButton.snp_makeConstraints(closure: { (make) -> Void in
                    make.bottom.equalTo(self.toolBar.snp_bottom).offset(-8)
                    make.right.equalTo(self.toolBar.snp_right).offset(-2)
                })
            }
            return toolBar
        }
    }
    
    
    
//MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.keyboardDismissMode = .Interactive
    
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if 0 == commentList.count {
            if let id = voice?.id {
                commentModel.getComment(20, queryTimes: self.queryTimes, voiceId: id, block: { (comments, error) -> Void in
                    if nil == error {
                        if let list = comments {
                            self.commentList = list
                            var userList = [String]()
                            for object in list {
                                userList.append(object.userEmail)
                            }
                            self.userModel.getUsersAvatar(userList, resultHandler: { (objects, error) -> Void in
                                if nil == error {
                                    if let results = objects {
                                        for comment in self.commentList {
                                            for user in results {
                                                print("User:\(user.userEmail)")
                                                if comment.userEmail == user.userEmail {
                                                    comment.user = user
                                                }
                                            }
                                        }
                                        self.tableView.reloadData()
                                        print("User List length:\(results.count)")//0
                                        self.queryTimes++;
                                    } else {
                                        print("no users")
                                    }
                                } else {
                                    print("Get User info Propose Error: \(error!) \(error!.userInfo)")
                                }
                            })
                        }
                    }
                })
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
// MARK:- Table view data source && delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 48
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section == 0 )
        {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 48))
            footerView.backgroundColor = UIColor.lxd_MainBlueColor()
            
            let likeButton = UIButton(type: .Custom)
            likeButton.frame = CGRect(x: 0, y: 8, width: 64, height: 32)
            likeButton.setImage(UIImage(named: "like"), forState: .Normal)
            likeButton.setImage(UIImage(named: "like_chosen"), forState: .Disabled)

            likeButton.backgroundColor = UIColor.whiteColor()
            likeButton.addTarget(self, action: "Like:", forControlEvents: .TouchUpInside)
            
            let dislikeButton = UIButton(frame: CGRect(x: 64, y: 8, width: 64, height: 32))
            dislikeButton.setImage(UIImage(named: "dislike"), forState: .Normal)
            dislikeButton.setImage(UIImage(named: "dislike_chosen"), forState: .Selected)
            dislikeButton.backgroundColor = UIColor.whiteColor()
            
            let followButton = UIButton(frame: CGRect(x: 64*2, y: 8, width: 64, height: 32))
            followButton.setImage(UIImage(named: "unwatched_eye"), forState: .Normal)
            followButton.setImage(UIImage(named: "watched_eye"), forState: .Highlighted)
            followButton.backgroundColor = UIColor.whiteColor()
            
            footerView.addSubview(likeButton)
            footerView.addSubview(dislikeButton)
            footerView.addSubview(followButton)
            
            return footerView
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0)
        {
            return 1
        }
        else
        {
          return commentList.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var identifier = ""
        
        if( indexPath.section == 0 ) {
            identifier = "DetailTitle"
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! VoiceTitleTableViewCell
            
            if let currentVoice = voice, voiceUser = voice?.user {
                cell.Abstract.text = currentVoice.content
                cell.CommentUser.text = voiceUser.userName
                cell.Reputation.text = "\(voiceUser.resume)"
                cell.Classify.text = currentVoice.classify.rawValue
                cell.UpdateTime.text = currentVoice.dateStr
                
                if let image = voiceUser.avatar {
                    cell.Avatar.image = image
                } else {
                    cell.Avatar.image = UIImage(named: "avatar")
                }
                //  cell.ClassifyKind.image = UIImage(named: "\(issue?.classify)")
                imagesBinder(cell.ImgesContainer, images: (voice?.images)!)
            } else {
                print("Current Voice is nil")
            }
            
            return cell

        } else {
            identifier = "DetailComment"
            let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! VoiceDetailTableViewCell
            dataBinder(cell, voiceComment: self.commentList[indexPath.row])
            return cell
        }
        
    }

    func SendComment() {
        print(self.textView.text)
        let content = self.textView.text
        let userEmail = PFUser.currentUser()?.email
        let userName = PFUser.currentUser()?.username
        let id = self.voice?.id
        let newComment = Comment(emailFromLocal: userEmail!, name: userName!, voiceId: id!, content: content)
        
        commentModel.addNewComment(newComment) { (isSuccess, error) -> Void in
            if nil == error {
                if isSuccess {
                    print("Successfully save comment")
                    self.textView.text = ""
                    self.commentList.append(newComment)
                } else {
                    print("Error save comment")
                }
            } else {
                print("Save Comment Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    
    @IBAction func Like(sender: UIButton)
    {
        sender.enabled = false
        print("Like")
    }

//MARK:- Data binder
//TODO:- bind every comment data to the view

    func dataBinder(cell: VoiceDetailTableViewCell,voiceComment:Comment) {
        cell.CommentContent.text = voiceComment.content
        cell.CommentTime.text = voiceComment.dateStr
        
        if let user = voiceComment.user {
            cell.CommentUserName.text = user.userName
            cell.CommentUserResume.text = "\(user.resume)"
            if let image = user.avatar {
                cell.CommentUserAvatar.image = image
            } else {
                cell.CommentUserAvatar.image = UIImage(named: "avatar")
            }
        } else {
            print("There is no comment user")
        }
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
    
    func keyboardWillShow(notification:NSNotification)
    {
        let userInfo = notification.userInfo as NSDictionary!
        let frameNew = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let insetNewBottom = tableView.convertRect(frameNew, fromView: nil).height
        let insetOld = tableView.contentInset
        let insetChange = insetNewBottom - insetOld.bottom
        let overflow = tableView.contentSize.height - (tableView.frame.height - insetOld.top - insetOld.bottom)
        
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animations: (() -> Void) = {
            if !(self.tableView.tracking || self.tableView.decelerating)
            {
                if overflow > 0
                {
                    self.tableView.contentOffset.y += insetChange
                    if self.tableView.contentOffset.y < -insetOld.top {
                        self.tableView.contentOffset.y = -insetOld.top
                    }
                }
                else if insetChange > -overflow
                {
                    self.tableView.contentOffset.y += insetChange + overflow
                }
                
            }
        }
        
        if duration > 0
        {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            UIView.animateWithDuration(duration, delay: 0, options: options, animations: animations, completion: nil)
            
        }
        else
        {
            animations()
        }
        
        
    }
    
    func keyboardDidShow(notification: NSNotification)
    {
        let userInfo = notification.userInfo as NSDictionary!
        let frameNew = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let insetNewBottom = tableView.convertRect(frameNew, fromView: nil).height
        
        let contentOffsetY = tableView.contentOffset.y
        tableView.contentInset.bottom = insetNewBottom
        tableView.scrollIndicatorInsets.bottom = insetNewBottom
        
        if self.tableView.tracking || self.tableView.decelerating
        {
            tableView.contentOffset.y = contentOffsetY
        }
    }
    
    func updateTextViewHeight()
    {
        let oldHeight = textView.frame.height
        let maxHeight = UIInterfaceOrientationIsPortrait(interfaceOrientation) ? textViewMaxHeight.portrait : textViewMaxHeight.landscape
        var newHeight = min(textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.max)).height, maxHeight)
        
        #if arch(x86_64) || arch(arm64)
            newHeight = ceil(newHeight)
        #else
            newHeight = CGFloat(ceilf(newHeight.native))
        #endif
        
        if newHeight != oldHeight
        {
            toolBar.frame.size.height = newHeight + 8*2 - 0.5
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    
    func textViewDidChange(textView: UITextView) {
        updateTextViewHeight()
        sendButton.enabled = textView.hasText()
    }

    
}
