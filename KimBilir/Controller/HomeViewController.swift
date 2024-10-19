//
//  FirstViewController.swift
//  KimBilir
//
//  Created by Sevde Aydın on 17.10.2024.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func childButton(_ sender: Any) {
        performSegue(withIdentifier: "toQuestionView", sender: nil)
    }
    
    @IBAction func adultButton(_ sender: Any) {
        performSegue(withIdentifier: "toQuestionView", sender: nil)
    }
    
    
}
