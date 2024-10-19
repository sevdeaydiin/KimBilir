//
//  ScoreViewController.swift
//  KimBilir
//
//  Created by Sevde Aydın on 19.10.2024.
//

import UIKit

class ScoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func toHomeView(_ sender: Any) {
        performSegue(withIdentifier: "toHomeView", sender: nil)
    }
    
}
