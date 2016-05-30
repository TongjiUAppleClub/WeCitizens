//
//  FocusTableViewController.swift
//  WeCitizens
//
//  Created by Teng on 5/27/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import Parse
import PromiseKit

class FocusTableViewController: UITableViewController {
    
    let userModel = UserModel()
    let voiceModel = VoiceModel()
    let replyModel = ReplyModel()
    
    var voiceArray = [(String, String)]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let user = PFUser.currentUser()!
        let focusIds = user.valueForKey("focusVoices") as! NSArray
        let idsArray = focusIds.map { id in
            return (id as! String)
        }
        voiceModel.getVoiceTitles(idsArray).then { (titleArray) -> Void in
                self.voiceArray = titleArray
                self.tableView.reloadData()
        } .error { err in
                print("获取voice title array时出错\(err)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voiceArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VoiceTitleCell", forIndexPath: indexPath)

        cell.textLabel?.text = voiceArray[indexPath.row].0

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("ReplyTableView") as! ReplyTableViewController
        controller.voiceId = voiceArray[indexPath.row].1
        controller.navigationItem.rightBarButtonItem = nil
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
