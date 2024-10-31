//
//  LayoutConstants.swift
//  KimBilir
//
//  Created by Sevde Aydın on 31.10.2024.
//

import UIKit

struct LayoutConstants {

    let labelFontSize: CGFloat
    let timeLabelTopPadding: CGFloat
    let timeLabelLeadingPadding: CGFloat
    let buttonBottomPadding: CGFloat
    let buttonHeight: CGFloat
    let sidePadding: CGFloat
    let buttonSpacing: CGFloat
    let height: CGFloat
    let width: CGFloat
    
    init(view: UIView) {
        height = view.bounds.height
        width = view.bounds.width
        sidePadding = width * 0.08
        buttonSpacing = height * 0.02
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.labelFontSize = FontSizes.labelLargeFontSize
            timeLabelTopPadding = height * 0.085
            buttonBottomPadding = height * 0.15
            timeLabelLeadingPadding = width * 0.15
            buttonHeight = height * 0.06
        } else if height < 668 {
            labelFontSize = FontSizes.labelSmallFontSize
            timeLabelTopPadding = height * 0.06
            buttonBottomPadding = height * 0.15
            timeLabelLeadingPadding = width * 0.1
            buttonHeight = height * 0.07
        } else {
            labelFontSize = FontSizes.labelMediumFontSize
            timeLabelTopPadding = width * 0.065
            buttonBottomPadding = height * 0.15
            timeLabelLeadingPadding = width * 0.1
            buttonHeight = height * 0.06
        }
    }

}
