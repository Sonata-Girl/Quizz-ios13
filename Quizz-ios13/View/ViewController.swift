//
//  ViewController.swift
//  Quizz-ios13
//
//  Created by Sonata Girl on 20.02.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    var quizBrain = QuizBrain()
    var buttonsAnswer = [UIButton]()
    
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
    
    private var scoreLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Score:"
        label.textColor = .white
        return label
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
    
    private var answerButton1: UIButton = {
        var button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Choise 1", for: .normal)
        return button
    }()
    
    private var answerButton2: UIButton = {
        var button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Choise 2", for: .normal)
        return button
    }()
    
    private var answerButton3: UIButton = {
        var button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Choise 3", for: .normal)
        return button
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
        setupUI()
        updateUI()
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
        
        stackView.addArrangedSubview(scoreLabel)
        stackView.addArrangedSubview(questionLabel)
        stackView.addArrangedSubview(answerButton1)
        stackView.addArrangedSubview(answerButton2)
        stackView.addArrangedSubview(answerButton3)
        stackView.addArrangedSubview(progressView)
        NSLayoutConstraint.activate([
            scoreLabel.heightAnchor.constraint(equalToConstant: 20),
            answerButton1.heightAnchor.constraint(equalToConstant: 80),
            answerButton2.heightAnchor.constraint(equalToConstant: 80),
            answerButton3.heightAnchor.constraint(equalToConstant: 80),
            progressView.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        answerButton1.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        answerButton2.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        answerButton3.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        
        buttonsAnswer += [answerButton1, answerButton2, answerButton3]
    }
    
    @objc private func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle! // true, false
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
        
        sender.backgroundColor =  userGotItRight ? .green : .red
       
        quizBrain.nextQueston()
        
        for (index, button) in buttonsAnswer.enumerated() {
            button.setTitle(quizBrain.getAnswerForQuestion(at: index), for: .normal)
        }
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }

    @objc private func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        progressView.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        for (index, button) in buttonsAnswer.enumerated() {
            button.setTitle(quizBrain.getAnswerForQuestion(at: index), for: .normal)
        }
        
        answerButton1.backgroundColor = .clear
        answerButton2.backgroundColor = .clear
        answerButton3.backgroundColor = .clear
        
    }
}

