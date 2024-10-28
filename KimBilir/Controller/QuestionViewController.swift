//
//  ViewController.swift
//  KimBilir
//
//  Created by Sevde Aydın on 14.10.2024.
//

import UIKit
import SnapKit
import AVFoundation

class QuestionViewController: UIViewController {
    let backgroundImage = UIImageView.init(image: UIImage(named: "background"))
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var answerButtons: [AnswerButton]!
    
    private var currentQuestionIndex: Int = 0
    private var currentQuestion: Question? { questions[currentQuestionIndex] }
    private var currentScore: Int = 0
    
    private var timer: Timer?
    private let initialTime = 60
    
    private var player: AVAudioPlayer!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //questionLabel.backgroundColor = .saturn.withAlphaComponent(0.9)
        //questionLabel.layer.cornerRadius = 15
        //questionLabel.layer.masksToBounds = true
        timeLabel.layer.masksToBounds = true
        timeLabel.textAlignment = .center
        setupLayout()
        setupUI()
        startTimer()
        loadNewQuestion()
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard let selectedIndex = answerButtons.firstIndex(of: sender as! AnswerButton) else { return }
        checkAnswer(selectedIndex: selectedIndex, button: sender)
    }
    
    private func setupUI() {
        questionLabel.configureQuestionLabel()
        resetTimeLabel()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeDecrease), userInfo: nil, repeats: true)
    }
    
    private func resetTimeLabel() {
        timeLabel.text = "\(initialTime)"
    }
    
    @objc func timeDecrease() {
        guard let currentTime = Int(timeLabel.text ?? ""), currentTime > 0 else {
            timer?.invalidate()
            performSegue(withIdentifier: "toScoreView", sender: nil)
            return
        }
        timeLabel.text = "\(currentTime - 1)"
    }
    
    private func loadNewQuestion() {
        
        currentQuestionIndex = Int.random(in: 0..<questions.count)
        updateQuestionUI()
        resetAnswerButtons()
    }
    
    private func updateQuestionUI() {
        guard let currentQuestion = currentQuestion else { return }
        questionLabel.text = currentQuestion.questionText
        for (index, button) in answerButtons.enumerated() {
            button.setTitle("\(["A", "B", "C", "D"][index]): \(currentQuestion.answers[index])", for: .normal)
        }
    }
    
    func checkAnswer(selectedIndex: Int, button: UIButton) {
        guard let correctAnswer = currentQuestion?.correctAnswer else { return }
        let isCorrect = currentQuestion?.answers[selectedIndex] == correctAnswer
        updateScore(isCorrect: isCorrect)
        updateButtonAppearance(button, isCorrect: isCorrect)
        playAnswerSound(isCorrect: isCorrect)
        moveToNextQuestion(after: 1.0)
    }
    
    private func updateScore(isCorrect: Bool) {
        currentScore += isCorrect ? 5 : 0
    }
    
    private func updateButtonAppearance(_ button: UIButton, isCorrect: Bool) {
        button.configuration?.background.backgroundColor = isCorrect ? .systemGreen : .systemRed
    }
    
    private func playAnswerSound(isCorrect: Bool) {
        let soundFileName = isCorrect ? "correct" : "error"
        playSound(named: soundFileName)
    }
    
    private func playSound(named soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
                player = try? AVAudioPlayer(contentsOf: url)
                player?.play()
    }
    
    private func resetAnswerButtons() {
        answerButtons.forEach { button in
            button.configuration?.background.backgroundColor = .answerButton
        }
    }
    
    private func moveToNextQuestion(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.loadNewQuestion()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ScoreViewController else { return }
        destinationVC.score = currentScore
    }
    
    func setupLayout() {
        
        let height: CGFloat = view.bounds.height
        let width: CGFloat = view.bounds.width
        let sidePadding: CGFloat = width * 0.08
        let buttonSpacing: CGFloat = height * 0.02
        let buttonHeight: CGFloat
        let buttonBottomPadding: CGFloat
        let labelFontSize: CGFloat
        let timeLabelTopPadding: CGFloat
        let timeLabelLeadingPadding: CGFloat
        
        view.addSubview(backgroundImage)
        view.addSubview(questionLabel)
        view.addSubview(timeLabel)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad { // iPad
            labelFontSize = 32
            timeLabelTopPadding = height * 0.085
            buttonBottomPadding = height * 0.15
            timeLabelLeadingPadding = width * 0.25
            buttonHeight = height * 0.06
        } else {
            if height < 668 { // iPhone SE
                labelFontSize = 16
                timeLabelTopPadding = height * 0.06
                buttonBottomPadding = height * 0.15
                timeLabelLeadingPadding = width * 0.21
                buttonHeight = height * 0.07
            } else {
                labelFontSize = 20
                timeLabelTopPadding = width * 0.065
                buttonBottomPadding = height * 0.15
                timeLabelLeadingPadding = width * 0.215
                buttonHeight = height * 0.06
            }
        }
        
        questionLabel.font = UIFont.systemFont(ofSize: labelFontSize, weight: .semibold)
        timeLabel.font = UIFont.systemFont(ofSize: labelFontSize, weight: .bold)
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(timeLabelTopPadding)
            make.leading.equalTo(timeLabelLeadingPadding)
            make.width.height.equalTo(50)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(sidePadding)
            make.height.equalTo(height * 0.25)
        }
        
        answerButtons.enumerated().forEach { index, button in
            view.addSubview(button)
            
            button.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(sidePadding)
                make.height.equalTo(buttonHeight)
                
                if index == 0 {
                    make.top.equalTo(questionLabel.snp.bottom).offset(30)
                } else {
                    make.top.equalTo(answerButtons[index - 1].snp.bottom).offset(buttonSpacing)
                }
                
                if index == answerButtons.count - 1 {
                    make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(buttonBottomPadding)
                }
            }
        }
        
        
        
    }
    
}

private extension UILabel {
    func configureQuestionLabel() {
        backgroundColor = .saturn.withAlphaComponent(0.9)
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
}
