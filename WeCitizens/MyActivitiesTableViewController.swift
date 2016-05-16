//
//  MyActivitiesTableViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 4/9/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import MJRefresh


class MyActivitiesTableViewController: UITableViewController {

    var activityList:NSArray? = nil
    
    override func viewDidLoad()
    {
     super.viewDidLoad()
     navigationController?.title = "我的动态"
     tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            print("Refreshing")
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.tableView.mj_header.endRefreshing()
            }
        })

     tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () -> Void in
            print("Refreshing")
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.tableView.mj_footer.endRefreshing()
            }
        })

     tableView.mj_header.automaticallyChangeAlpha = true

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as! MyActivityCell
    
        return cell
    }
}
