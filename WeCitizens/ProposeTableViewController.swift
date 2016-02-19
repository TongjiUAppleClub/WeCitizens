//
//  ProposeTableViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/11/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit

class ProposeTableViewController: UITableViewController {

//TODO:- Get the comment list  
// I will give the example data and show how to use it
    let COMMENT_NUM = 5
    let testAvatar =  UIImage(named: "avatar")
    let testCommentUser = "Harold"
    let testAbstract = "懵逼快出图！！！"
    let testTime = "2016.2.14"
    let testBrowser = "10247"
    let testClassify = "Education"
    let testReputaion = "452"
    let testImages = [UIImage(named: "logo")!,UIImage(named: "logo")!,UIImage(named: "logo")!]
  
    
    
//MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableView.estimatedRowHeight = tableView.rowHeight
       // tableView.rowHeight = UITableViewAutomaticDimension
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
// MARK:- Table view data source && delegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return COMMENT_NUM
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentTableViewCell
        
        cell.imageContainter.delegate = self
        
        
        //TODO:- Set every cell from the data
        cell.Avatar.image = testAvatar
        cell.CommentUser.text = testCommentUser
        cell.UpdateTime.text = testTime
        cell.Abstract.text = testAbstract
        cell.Classify.text = testClassify
        cell.Reputation.text = testReputaion
        cell.BrowseNum.text = testBrowser
        imagesLayout(cell, images: testImages)
        
        return cell
    }

    
    
//MARK:- Images Layout
    func imagesLayout(cell:CommentTableViewCell,images:[UIImage])
    {
        
        var size = cell.imageContainter.frame.size
        
        size.width  = size.width/2 *  CGFloat(images.count)
        cell.imageContainter.contentSize = size
        cell.imageContainter.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        for view in cell.subviews
        {
            if view.tag == 1
            {
                view.removeFromSuperview()
            }
        }
    
        for (index,image) in images.enumerate()
        {
            var commentImg:UIImageView!
            commentImg = UIImageView(image: image)
            commentImg.tag = 1
            var imageF = cell.imageContainter.frame
            imageF.origin.y = 0
            imageF.size.width /= 2
            imageF.origin.x = CGFloat(index) * (imageF.size.width)
            
            //commentImg.sizeThatFits(imageF.size)
            
            print(imageF.origin.x)
            commentImg.frame = imageF
            cell.imageContainter.addSubview(commentImg)
        }
    }

    
}
