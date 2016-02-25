//
//  ReplyTableViewController.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/24/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import FoldingCell

class ReplyTableViewController: UITableViewController,SSRadioButtonControllerDelegate {

    let kRowsCount = 10
    let kCloseCellHeight:CGFloat = 168
    let kOpenCellHeight:CGFloat = 850
    
    var cellHeights = [CGFloat]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell is FoldingCell {
            let foldingCell = cell as! FoldingCell
            foldingCell.backgroundColor = UIColor.clearColor()
            
            if cellHeights[indexPath.row] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoldingCell", forIndexPath: indexPath) as! ReplyTableViewCell
        
        let vc = BarsExample()
        addChildViewController(vc)
        vc.view.frame = cell.ThirdView.frame
        vc.view.frame.origin.y -= 32
        cell.ThirdView.addSubview(vc.view)
        let radioButtonController = SSRadioButtonsController(buttons: cell.L1_Button, cell.L2_Button, cell.L3_Button,cell.L4_Button)

        radioButtonController.delegate = self
        radioButtonController.shouldLetDeSelect = true
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    // MARK: Table vie delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
        
        
    }

    func didSelectButton(aButton: UIButton?) {
        print(aButton)
    }

    

}
