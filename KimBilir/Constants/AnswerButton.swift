//
//  AnswerButton.swift
//  KimBilir
//
//  Created by Sevde Aydın on 28.10.2024.
//

import UIKit
import SnapKit

class AnswerButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        let buttonFontSize: CGFloat
        let height: CGFloat = UIScreen.main.bounds.height
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            buttonFontSize = 24
        } else {
            if height < 668 {
                buttonFontSize = 14
            } else {
                buttonFontSize = 18
            }
        }
        
        backgroundColor = .answerButton
        layer.cornerRadius = frame.size.height / 4
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        setTitleColor(.white, for: .normal)
        
        titleLabel?.font = UIFont.systemFont(ofSize: buttonFontSize, weight: .medium)
        
        self.configurationUpdateHandler = { button in
            var config = button.configuration ?? UIButton.Configuration.plain()
            config.baseForegroundColor = .white
            config.background.backgroundColor = UIColor.answerButton
            config.background.cornerRadius = button.frame.size.height / 4
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont.systemFont(ofSize: buttonFontSize, weight: .medium)
                return outgoing
            }
            button.configuration = config
        }
    }
}
