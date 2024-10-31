//
//  FirstViewController.swift
//  KimBilir
//
//  Created by Sevde Aydın on 17.10.2024.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var adultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout() {
        
        let metrics = LayoutConstants(view: self.view)
        childButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(metrics.buttonHeight)
            make.leading.trailing.equalToSuperview().inset(metrics.sidePadding + 80)
        }
        
        childButton.titleLabel?.font = .systemFont(ofSize: metrics.labelFontSize)
        adultButton.titleLabel?.font = .systemFont(ofSize: metrics.labelFontSize)
        
        adultButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(metrics.buttonHeight)
            make.top.equalTo(childButton.snp.bottom).offset(metrics.buttonSpacing + 20)
            make.leading.trailing.equalToSuperview().inset(metrics.sidePadding + 80)
        }
    }

    @IBAction func childButton(_ sender: Any) {
        performSegue(withIdentifier: "toQuestionView", sender: nil)
    }
    
    @IBAction func adultButton(_ sender: Any) {
        performSegue(withIdentifier: "toQuestionView", sender: nil)
    }
    
    
}
