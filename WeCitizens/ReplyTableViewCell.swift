//
//  ReplyTableViewCell.swift
//  WeCitizens
//
//  Created by  Harold LIU on 2/24/16.
//  Copyright © 2016 Tongji Apple Club. All rights reserved.
//

import UIKit
import FoldingCell

class ReplyTableViewCell: FoldingCell,SSRadioButtonControllerDelegate{

//Foreground View
    
    @IBOutlet weak var Back: UIView!
    @IBOutlet weak var Favatar: UIImageView!
    @IBOutlet weak var imgContainer: UIView!
    @IBOutlet weak var ResponseTitle: UILabel!
    @IBOutlet weak var FAgency: UILabel!
    @IBOutlet weak var ResponseTime: UILabel!
    @IBOutlet weak var SupportPercent: UILabel!

//Container View
//First
    @IBOutlet weak var CAvatar: UIImageView!
    @IBOutlet weak var CAgency: UILabel!
    @IBOutlet weak var CTitle: UILabel!
    @IBOutlet weak var CContent: UITextView!
//Second
    @IBOutlet weak var CimgContainer: UIView!
    @IBOutlet weak var CResponseTime: UILabel!
    @IBOutlet weak var CResponseButton: UIButton!
//Third 
    @IBOutlet weak var ThirdView: RotatedView!
    @IBOutlet weak var EvaluateButton: UIButton!
    @IBOutlet weak var CheckHistoryButton: UIButton!


    @IBOutlet var CommentButtons: [SSRadioButton]!
// Fourth
    
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var CSupport: UILabel!
    

    
    var radioButtonController:SSRadioButtonsController?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        setButtons()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
    func configureUI()
    {
        foregroundView.layer.cornerRadius = 8
        Back.layer.cornerRadius = 8
        Favatar = UIImageView.lxd_CircleImage(Favatar, borderColor: UIColor.clearColor(), borderWidth: 0)
        imgContainer.layer.cornerRadius = 5
        containerView.layer.cornerRadius = 8
        CAvatar = UIImageView.lxd_CircleImage(CAvatar, borderColor: UIColor.clearColor(), borderWidth: 0)
        
        CimgContainer.layer.cornerRadius = 5
        CContent.backgroundColor = UIColor.clearColor()
        CResponseButton.layer.borderColor = UIColor.lxd_MainBlueColor().CGColor
        CResponseButton.layer.borderWidth = 1.3
        CResponseButton.layer.cornerRadius = CResponseButton.frame.height/2
        
        SubmitButton.layer.cornerRadius = SubmitButton.frame.height/2
        SubmitButton.layer.borderColor = UIColor.lxd_MainBlueColor().CGColor
        SubmitButton.layer.borderWidth = 1.3
        
    }
    
    
    func drawBarChart(radios:[CGFloat])
    {
        for (index,radio) in radios.enumerate()
        {
            let width :CGFloat = 20.0+radio*300
            let y:CGFloat = EvaluateButton.layer.frame.origin.y+CGFloat(35*index+64)
            let frame = CGRect(x: -20, y:y, width:width , height: 20)
            
            let barView = UIView(frame: frame)
            barView.backgroundColor = UIColor.lxd_YellowColor()
            barView.layer.cornerRadius = barView.frame.size.height/2
            
            var labelFrame = frame
            labelFrame.size.width -= 10
            
            let markLabel = UILabel(frame: labelFrame)
            markLabel.text = "\(radio)"
            markLabel.textColor = UIColor.whiteColor()
            markLabel.textAlignment = .Right
            
            ThirdView.addSubview(barView)
            ThirdView.addSubview(markLabel)
        }
    }
    
    func setButtons()
    {
      radioButtonController = SSRadioButtonsController()
      for button in CommentButtons
      {
        radioButtonController?.addButton(button)
      }
        radioButtonController?.shouldLetDeSelect = true
    }
    
    
}
