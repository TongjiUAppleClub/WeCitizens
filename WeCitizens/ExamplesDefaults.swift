//
//  ExamplesDefaults.swift
//  SwiftCharts
//
//  Created by ischuetz on 04/05/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit
import SwiftCharts

struct ExamplesDefaults {
    
    static var chartSettings: ChartSettings {
       
            return self.iPhoneChartSettings
    }

    private static var iPhoneChartSettings: ChartSettings {
        let chartSettings = ChartSettings()
        chartSettings.leading = 0
        chartSettings.top = 0
        chartSettings.trailing = 0
        chartSettings.bottom = 20
        chartSettings.labelsToAxisSpacingX = 0.2
        chartSettings.labelsToAxisSpacingY = 0.2
        chartSettings.axisTitleLabelsToLabelsSpacing = 0.4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 0.2
        chartSettings.spacingBetweenAxesY = 0.2
        return chartSettings
    }
    
    static func chartFrame(containerBounds: CGRect) -> CGRect {
        return CGRectMake(0, 70, containerBounds.size.width, containerBounds.size.height - 100)
    }
    
    static var labelSettings: ChartLabelSettings {
        return ChartLabelSettings(font: ExamplesDefaults.labelFont)
    }
    
    static var labelFont: UIFont {
        return ExamplesDefaults.fontWithSize(0)
    }
    
    static var labelFontSmall: UIFont {
        return ExamplesDefaults.fontWithSize(0)
    }
    
    static func fontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size) ?? UIFont.systemFontOfSize(size)
    }
    
    static var guidelinesWidth: CGFloat {
        return 0
    }
    
    static var minBarSpacing: CGFloat {
        return 4
    }
}
