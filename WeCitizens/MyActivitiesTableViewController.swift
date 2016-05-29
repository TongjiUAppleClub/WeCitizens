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

    var activityList = [Activity]()
    let activityModel = ActivityModel()
    var userEmail:String?
    var queryNum = 10
    var queryTimes = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "我的动态"
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            print("RefreshingHeader")
            
            self.queryTimes = 0
            self.activityList = []
            self.getActivityFromRemote()
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.tableView.mj_header.endRefreshing()
            }
        })

        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () -> Void in
            print("RefreshingFooter")
            
            self.getActivityFromRemote()
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.tableView.mj_footer.endRefreshing()
            }
        })

        tableView.mj_header.automaticallyChangeAlpha = true
        self.getActivityFromRemote()
    }
    
    func getActivityFromRemote() {
        if let email = userEmail {
            activityModel.getUserActivitiesFromRemote(queryNum, queryTimes: queryTimes, userEmail: email, resultHandler: { (objects, error) in
                if nil == error {
                    if let activities = objects {
                        self.activityList += activities
                        self.queryTimes += 1
                        self.tableView.reloadData()
                    } else {
                        print("没有获取到Activity")
                    }
                } else {
                    print("Error: \(error!) \(error!.userInfo)")
                }
                
            })
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return activityList.count
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as! MyActivityCell
    
        cell.Activity.text = activityList[indexPath.section].content
        cell.Title.text = activityList[indexPath.section].title
        cell.Username.text = activityList[indexPath.section].userName
        cell.Time.text = activityList[indexPath.section].dateStr
        
        return cell
    }
}
