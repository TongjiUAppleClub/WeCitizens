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
    let testImages = [UIImage(named: "07")!,UIImage(named: "07")!,UIImage(named: "07")!]    
  
    
    
//MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.redColor()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
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
        for (index,image) in images.enumerate()
        {
            var commentImg:UIImageView!
            let imgFrame = CGRectMake(cell.Abstract.frame.origin.x + CGFloat(index * 72), cell.Abstract.frame.origin.y + cell.Abstract.bounds.size.height, 64, 64)
            commentImg = UIImageView(image: image)
            commentImg.frame = imgFrame
            cell.addSubview(commentImg)
        }
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
