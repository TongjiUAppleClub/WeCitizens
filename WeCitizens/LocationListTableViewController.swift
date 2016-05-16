//
//  LocationListTableViewController.swift
//  WeCitizens
//
//  Created by Teng on 4/20/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//  城市列表tableview

import UIKit
import MJRefresh

protocol NewLocationDelegate {
    func setNewLocation(newLocation: String)
}

class LocationListTableViewController: UITableViewController {
    
    var cityModel = CityModel()
    var cityList = [City]()
    let queryNums = 20
    var queryTimes = 0
    
    var delegate:NewLocationDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            print("RefreshingHeader")
            //上拉刷新，在获取数据后清空旧数据，并做缓存
            self.cityList = []
            self.queryTimes = 0
            self.getCityFromRemote()
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                
                self.tableView.mj_header.endRefreshing()
            }
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () -> Void in
            print("RefreshingFooter")
            //1.下拉加载数据，将新数据append到数组中，不缓存
            self.getCityFromRemote()
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.tableView.mj_footer.endRefreshing()
            }
        })
        
        tableView.mj_header.automaticallyChangeAlpha = true
        getCityFromRemote()
    }
    
    func getCityFromRemote() {
        self.cityModel.getCityList(self.queryNums, queryTimes: self.queryTimes, resultHandler: { (results, error) -> Void in
            if let _ = error {
                //有错误，给用户提示
                print("get voice fail with error:\(error!.userInfo)")
            } else {
                if let cities = results {
                    self.cityList.appendContentsOf(cities)
                    self.tableView.reloadData()
                    self.queryTimes += 1
                } else {
                    //没取到数据
                    print("no data in refreshing header")
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath)

        cell.textLabel?.text = cityList[indexPath.row].name

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.setNewLocation(cityList[indexPath.row].name)
        self.navigationController?.popToRootViewControllerAnimated(true)
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
