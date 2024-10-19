//
//  LaunchScreenViewController.swift
//  KimBilir
//
//  Created by Sevde Aydın on 19.10.2024.
//

import UIKit

class FirstViewController: UIViewController {
    
    let animatedImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "astronot"))
        //imageView.frame.size.height = 400
        //imageView.frame.size.width = 400
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(animatedImageView)
        view.backgroundColor = .answerButton
        
        animatedImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animatedImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        animatedImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 5).isActive = true
        animatedImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 5).isActive = true
        
        startTimer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.animateImage()
        }
    }
    
    var currentTime = 1
    var timer: Timer?
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeDecrease), userInfo: nil, repeats: true)
    }
    
    @objc func timeDecrease() {
        if currentTime > 0 {
            currentTime = currentTime - 1
        } else {
            timer?.invalidate()
            timer = nil
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let mainViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                mainViewController.modalPresentationStyle = .fullScreen
                self.present(mainViewController, animated: true, completion: nil)
            }
        }
    }
    
    func animateImage() {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.animatedImageView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.size.height)
        }) { _ in
            self.animatedImageView.removeFromSuperview()
        }
    }
    

}
