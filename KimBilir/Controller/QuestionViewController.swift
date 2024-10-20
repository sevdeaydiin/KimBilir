//
//  ViewController.swift
//  KimBilir
//
//  Created by Sevde Aydın on 14.10.2024.
//

import UIKit
import AVFoundation

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerALabel: UIButton!
    @IBOutlet weak var answerBLabel: UIButton!
    @IBOutlet weak var answerCLabel: UIButton!
    @IBOutlet weak var answerDLabel: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var player: AVAudioPlayer!
    
    var questions: [Question] = [
        Question(questionText: "Azı dişi hangisinin eş anlamlısıdır?",
                 answers: ["Sindirici diş", "Öğütücü diş", "Koparıcı diş", "Kesici diş"],
                 correctAnswer: "Öğütücü diş"),
        Question(questionText: "Hasbihal, ne demektir?",
                 answers: ["Gürültü", "Geçmiş", "Sohbet", "Özlem"],
                 correctAnswer: "Sohbet"),
        Question(questionText: "\"Mavi, lacivert, mor ve bu renklerin tonları\" hangisinin sözlük tanımıdır?",
                 answers: ["Sıcak renkler", "Soğuk renkler", "Ilık renkler", "Serin renkler"],
                 correctAnswer: "Soğuk renkler"),
        Question(questionText: "Genellikle hangisinden bahsedilirken çivi gibi benzetmesi yapılır?",
                 answers: ["Denizin çok soğuk olmasından", "Havanın çok sıcak olmasından", "Toprağın çok kaygan olmasından", "Rüzgarın çok hafif olmasından"],
                 correctAnswer: "Denizin çok soğuk olmasından"),
        Question(questionText: "Altay Dağları'na tırmanan bir dağcı hangisinde olabilir?",
                 answers: ["İzmir", "Kahire", "Bombay", "Moğolistan"],
                 correctAnswer: "Moğolistan"),
        Question(questionText: "Kaçkar Dağı, hangi coğrafi bölgenin en yüksek dağıdır?",
                 answers: ["Ege", "Marmara", "Akdeniz", "Karadeniz"],
                 correctAnswer: "Karadeniz")
    ]
    
    var currentQuestionIndex: Int = 0
    var currentQuestion: Question?
    var currentScore: Int = 0
    
    var timer: Timer?
    var currentTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.backgroundColor = .saturn.withAlphaComponent(0.9)
        questionLabel.layer.cornerRadius = 15
        questionLabel.layer.masksToBounds = true
        startTimer()
        loadNewQuestion()
    }
    
    @IBAction func answerCheckButton(_ sender: UIButton) {
        
        switch sender.title(for: .normal)?.prefix(2) {
        case "A:":
            checkAnswer(selectedIndex: 0, button: sender)
        case "B:":
            checkAnswer(selectedIndex: 1, button: sender)
        case "C:":
            checkAnswer(selectedIndex: 2, button: sender)
        case "D:":
            checkAnswer(selectedIndex: 3, button: sender)
        default:
            print("error")
        }
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
    
    func checkAnswer(selectedIndex: Int, button: UIButton) {
        if let currentQuestion = currentQuestion {
            let selectedAnswer = currentQuestion.answers[selectedIndex]
            if selectedAnswer == currentQuestion.correctAnswer {
                currentScore += 5
                rightAnswer(buttonName: button)
                correctAnswer()
            } else {
                wrongAnswer(buttonName: button)
                errorAnswer()
            }
        }
        
        moveToNextQuestion(after: 1.0)
    }
    
    func correctAnswer(){
        let url = Bundle.main.url(forResource: "correct", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    func errorAnswer(){
        let url = Bundle.main.url(forResource: "error", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    func loadNewQuestion() {
        
        currentQuestionIndex = Int.random(in: 0..<questions.count)
        currentQuestion = questions[currentQuestionIndex]
        
        if let currentQuestion = currentQuestion {
            questionLabel.text = currentQuestion.questionText
            answerALabel.setTitle("A: \(currentQuestion.answers[0])", for: .normal)
            answerBLabel.setTitle("B: \(currentQuestion.answers[1])", for: .normal)
            answerCLabel.setTitle("C: \(currentQuestion.answers[2])", for: .normal)
            answerDLabel.setTitle("D: \(currentQuestion.answers[3])", for: .normal)
        }
        
        resetButtonsColors()
        
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
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeDecrease), userInfo: nil, repeats: true)
    }
    
    @objc func timeDecrease() {
        if let currentText = timeLabel.text, let currentTime = Int(currentText), currentTime > 0 {
            let newNumber = currentTime - 1
            timeLabel.text = String(newNumber)
        } else {
            timer?.invalidate()
            timer = nil
            performSegue(withIdentifier: "toScoreView", sender: nil)
            print(currentScore)
        }
    }
    
    func moveToNextQuestion(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.loadNewQuestion()
        }
    }
    
}

