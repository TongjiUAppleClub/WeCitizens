//
//  CommentTableViewCell.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/11/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import SnapKit

class CommentTableViewCell: UITableViewCell,UITextViewDelegate,UIScrollViewDelegate{

    
    var pageImages = [UIImage(named: "logo")!,UIImage(named: "logo")!,UIImage(named: "logo")!]
    var pageViews: [UIImageView?] = []
    
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var CommentUser: UILabel!
    @IBOutlet weak var Reputation: UILabel!
    @IBOutlet weak var Classify: UILabel!
    @IBOutlet weak var UpdateTime: UILabel!
    @IBOutlet weak var BrowseNum: UILabel!
    @IBOutlet weak var Abstract: UITextView!
    @IBOutlet weak var ClassifyKind: UIImageView!
    
    
    @IBOutlet weak var imageContainter: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIconfigure()
        
        imageContainter.delegate = self
        
        let pageCount = pageImages.count
        
        
        // 3
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        
        // 4
        let pagesScrollViewSize = imageContainter.frame.size
        imageContainter.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count),
            height: pagesScrollViewSize.height)
        
        // 5
        loadVisiblePages()
        
        print(imageContainter.contentSize)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//MARK:- Configure UI
    func UIconfigure()
    {
        //make avatar circle
        Avatar.layer.masksToBounds = false
        Avatar.layer.borderWidth = 1
        Avatar.layer.borderColor = UIColor.clearColor().CGColor
        Avatar.layer.cornerRadius = Avatar.frame.height/2
        Avatar.clipsToBounds = true
        
        // Adjust the height of the textview
        let contentSize = self.Abstract.sizeThatFits(self.Abstract.bounds.size)
        var frame = self.Abstract.frame
        frame.size.height = contentSize.height
        self.Abstract.frame = frame
        
        let aspectRatioTextViewConstraint = NSLayoutConstraint(item: self.Abstract, attribute: .Height, relatedBy: .Equal, toItem: self.Abstract, attribute: .Width, multiplier: Abstract.bounds.height/Abstract.bounds.width, constant: 1)
        self.Abstract.addConstraint(aspectRatioTextViewConstraint)

    }
    
    
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // 1
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
        } else {
            // 2
            var frame = imageContainter.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            // 3
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            imageContainter.addSubview(newPageView)
            
            // 4
            pageViews[page] = newPageView
        }
    }
    
    func loadVisiblePages() {
        // First, determine which page is currently visible
        let pageWidth = imageContainter.frame.size.width
        let page = Int(floor((imageContainter.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        // Load pages in our range
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Load the pages that are now on screen
        loadVisiblePages()
    }
    
    func purgePage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    

}
