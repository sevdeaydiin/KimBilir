//
//  ViewController.swift
//  KimBilir
//
//  Created by Sevde Aydın on 14.10.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerALabel: UIButton!
    @IBOutlet weak var answerBLabel: UIButton!
    @IBOutlet weak var answerCLabel: UIButton!
    @IBOutlet weak var answerDLabel: UIButton!
    
    var questions: [String] = [
        "Hasbihal ne demektir?",
        "Ryan Gosling ve Michelle Williams'ın başrolde yer aldığı, 2010'da vizyona giren romantik filmin adı hangisidir?",
        "Yağı alınmış süt veya yoğurdun kaynatılmasıyla elde edilen, çökelek adıyla da bilinen peynirin diğer adı nedir?"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        questionLabel.backgroundColor = .saturn.withAlphaComponent(0.9)
        questionLabel.layer.cornerRadius = 15
        questionLabel.layer.masksToBounds = true
        questionLabel.text = "Ölçüsü 180 derece olan açıya ne denir?"
        answerALabel.configuration?.title = "A: "
        answerBLabel.configuration?.title = "B: "
        answerCLabel.configuration?.title = "C: "
        answerDLabel.configuration?.title = "D: "
    }

    @IBAction func answerA(_ sender: UIButton) {
        //self.answerA.backgroundColor = .green
        rightAnswer(buttonName: answerALabel)
        moveToNextQuestion(after: 1.5)
        
    }
    
    @IBAction func answerB(_ sender: UIButton) {
        wrongAnswer(buttonName: answerBLabel)
        moveToNextQuestion(after: 1.5)
    }
    
    @IBAction func answerC(_ sender: UIButton) {
    }
    
    @IBAction func answerD(_ sender: UIButton) {
        
    }
    
    func rightAnswer(buttonName: UIButton) {
        var config = buttonName.configuration
        config?.background.backgroundColor = .systemGreen
        buttonName.configuration = config
    }
    
    func wrongAnswer(buttonName: UIButton) {
        var config = buttonName.configuration
        config?.background.backgroundColor = .systemRed
        buttonName.configuration = config
    }
    
    func newSoru() {
        resetButtonsColors()
        
        questionLabel.text = questions[Int.random(in: 0..<questions.count)]
        answerALabel.configuration?.title = "Yeni a"
        answerBLabel.configuration?.title = "Yeni b"
        answerCLabel.configuration?.title = "Yeni c"
        answerDLabel.configuration?.title = "Yeni d"
    }
    
    func resetButtonsColors() {
        resetButtonColor(buttonName: answerALabel)
        resetButtonColor(buttonName: answerBLabel)
        resetButtonColor(buttonName: answerCLabel)
        resetButtonColor(buttonName: answerDLabel)
    }
    
    func resetButtonColor(buttonName: UIButton) {
        var config = buttonName.configuration
        config?.background.backgroundColor = UIColor.answerButton
        buttonName.configuration = config
    }
    
    func moveToNextQuestion(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.newSoru()
        }
    }
    
}

