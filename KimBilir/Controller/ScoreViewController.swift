//
//  ScoreViewController.swift
//  KimBilir
//
//  Created by Sevde Aydın on 19.10.2024.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var homeViewButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var cloudView: UIImageView!
    
    var score: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.alpha = 0
        cloudView.alpha = 0
        yourScoreLabel.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
        homeViewButton.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
        scoreLabel.text = String(score!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateViews()
    }
    
    func animateViews() {
        UIView.animate(withDuration: 1.0, delay: 0.01, options: .curveEaseOut, animations: {
            self.yourScoreLabel.transform = .identity
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0) {
            self.scoreLabel.alpha = 1
            self.cloudView.alpha = 1
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.01, options: .curveEaseOut, animations: {
            self.homeViewButton.transform = .identity
        }, completion: nil)
    }
   
    @IBAction func toHomeView(_ sender: Any) {
        performSegue(withIdentifier: "toHomeView", sender: nil)
    }
    
}
