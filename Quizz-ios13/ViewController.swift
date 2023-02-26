//
//  ViewController.swift
//  Quizz-ios13
//
//  Created by Sonata Girl on 20.02.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    let quiz = [
        Question(q: "A slug's blood is green.", a: "True"),
        Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
        Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
        Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
        Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
        Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
        Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
        Question(q: "Google was originally called 'Backrub'.", a: "True"),
        Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
        Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
        Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
        Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")
        
    ]
    
    var questionNumber = 0
    
    private var bubbleImageView: UIImageView = {
        var bubbleImageView = UIImageView()
        bubbleImageView.image = UIImage(named: "Background-Bubbles")
        bubbleImageView.clipsToBounds = true
        bubbleImageView.contentMode = .scaleAspectFill
        bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
        return bubbleImageView
    }()
    
    private var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.contentMode = .scaleAspectFill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        
        return stackView
    }()
    
    private var questionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 30)
        label.text = "Question text"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var trueButton: UIButton = {
        var trueButton = UIButton()
        trueButton.setTitleColor(.white, for: .normal)
        trueButton.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        trueButton.translatesAutoresizingMaskIntoConstraints = false
        trueButton.setTitle("True", for: .normal)
        return trueButton
    }()
    
    private var falseButton: UIButton = {
        var falseButton = UIButton()
        falseButton.setTitleColor(.white, for: .normal)
        falseButton.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        falseButton.translatesAutoresizingMaskIntoConstraints = false
        falseButton.setTitle("False", for: .normal)
        return falseButton
    }()
    
    private var progressView: UIProgressView = {
        var progressView = UIProgressView()
        progressView.progressTintColor = .systemBlue
        progressView.progressTintColor = .systemPink
        progressView.progress = 0.5
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        progressView.progress = 0
        updateUI()
        setupUI()
    }

    private func setupUI() {
        
        view.addSubview(bubbleImageView)
        NSLayoutConstraint.activate([
            bubbleImageView.heightAnchor.constraint(equalToConstant: 102),
            bubbleImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bubbleImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bubbleImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(questionLabel)
        stackView.addArrangedSubview(trueButton)
        stackView.addArrangedSubview(falseButton)
        stackView.addArrangedSubview(progressView)
        NSLayoutConstraint.activate([
            trueButton.heightAnchor.constraint(equalToConstant: 80),
            falseButton.heightAnchor.constraint(equalToConstant: 80),
            progressView.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        trueButton.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        falseButton.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        
    }
    
    @objc private func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle // true, false
        let actualQuestion = quiz[questionNumber]
        let actualAnswer = actualQuestion.answer
       
        if userAnswer == actualAnswer {
            sender.backgroundColor = .green
        } else {
            sender.backgroundColor = .red
        }
        
        if questionNumber == quiz.count - 1 {
            questionNumber = 0
        } else {
            questionNumber += 1
        }
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }

    @objc private func updateUI() {
        questionLabel.text = quiz[questionNumber].text

        trueButton.backgroundColor = .clear
        falseButton.backgroundColor = .clear
        
        progressView.progress = Float(questionNumber) / Float(quiz.count - 1)
    }
}

