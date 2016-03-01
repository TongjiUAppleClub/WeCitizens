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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//MARK:- Configure UI
    func UIconfigure()
    {
        self.backgroundColor = UIColor(red: 249/255, green: 251/255, blue: 255/255, alpha: 1.0)
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1.2
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.addBorder(edges: [.All],colour:UIColor(red: 124, green: 124, blue: 124, alpha: 1.0),thickness: 5)
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
        
        let aspectRatioTextViewConstraint = NSLayoutConstraint(item: self.Abstract, attribute: .Height, relatedBy: .Equal, toItem: self.Abstract, attribute: .Width, multiplier: Abstract.bounds.height/Abstract.bounds.width, constant: 8)
        self.Abstract.addConstraint(aspectRatioTextViewConstraint)
        
    }
    
    
    func addBorder(edges edges: UIRectEdge, colour: UIColor = UIColor.whiteColor(), thickness: CGFloat = 1) -> [UIView] {
        
        var borders = [UIView]()
        
        func border() -> UIView {
            let border = UIView(frame: CGRectZero)
            border.backgroundColor = colour
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }
        
        if edges.contains(.Top) || edges.contains(.All) {
            let top = border()
            addSubview(top)
            addConstraints(
                NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[top(==thickness)]",
                    options: [],
                    metrics: ["thickness": thickness],
                    views: ["top": top]))
            addConstraints(
                NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[top]-(0)-|",
                    options: [],
                    metrics: nil,
                    views: ["top": top]))
            borders.append(top)
        }
        
        if edges.contains(.Left) || edges.contains(.All) {
            let left = border()
            addSubview(left)
            addConstraints(
                NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[left(==thickness)]",
                    options: [],
                    metrics: ["thickness": thickness],
                    views: ["left": left]))
            addConstraints(
                NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[left]-(0)-|",
                    options: [],
                    metrics: nil,
                    views: ["left": left]))
            borders.append(left)
        }
        
        if edges.contains(.Right) || edges.contains(.All) {
            let right = border()
            addSubview(right)
            addConstraints(
                NSLayoutConstraint.constraintsWithVisualFormat("H:[right(==thickness)]-(0)-|",
                    options: [],
                    metrics: ["thickness": thickness],
                    views: ["right": right]))
            addConstraints(
                NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[right]-(0)-|",
                    options: [],
                    metrics: nil,
                    views: ["right": right]))
            borders.append(right)
        }
        
        if edges.contains(.Bottom) || edges.contains(.All) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(
                NSLayoutConstraint.constraintsWithVisualFormat("V:[bottom(==thickness)]-(0)-|",
                    options: [],
                    metrics: ["thickness": thickness],
                    views: ["bottom": bottom]))
            addConstraints(
                NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[bottom]-(0)-|",
                    options: [],
                    metrics: nil,
                    views: ["bottom": bottom]))
            borders.append(bottom)
        }
        
        return borders
    }
    
}
