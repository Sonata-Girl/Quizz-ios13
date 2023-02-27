//
//  QuizBrain.swift
//  Quizz-ios13
//
//  Created by Sonata Girl on 26.02.2023.
//

import Foundation

struct QuizBrain {

    let quiz = [
        Question(q: "Which is the largest organ in the human body?", answers: ["Heart", "Skin", "Large Intestine"], a: "Skin"),
        Question(q: "Five dollars is worth how many nickels?", answers: ["25", "50", "100"], a: "100"),
        Question(q: "What do the letters in the GMT time zone stand for?", answers: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], a: "Greenwich Mean Time"),
        Question(q: "What is the French word for 'hat'?", answers: ["Chapeau", "Écharpe", "Bonnet"], a: "Chapeau"),
        Question(q: "In past times, what would a gentleman keep in his fob pocket?", answers: ["Notebook", "Handkerchief", "Watch"], a: "Watch"),
        Question(q: "How would one say goodbye in Spanish?", answers: ["Au Revoir", "Adiós", "Salir"], a: "Adiós"),
        Question(q: "Which of these colours is NOT featured in the logo for Google?", answers: ["Green", "Orange", "Blue"], a: "Orange"),
        Question(q: "What alcoholic drink is made from molasses?", answers: ["Rum", "Whisky", "Gin"], a: "Rum"),
        Question(q: "What type of animal was Harambe?", answers: ["Panda", "Gorilla", "Crocodile"], a: "Gorilla"),
        Question(q: "Where is Tasmania located?", answers: ["Indonesia", "Australia", "Scotland"], a: "Australia")
    ]
    
    var rightAnswers = 0
    var questionNumber = 0
   
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if userAnswer == quiz[questionNumber].correctAnswer {
            rightAnswers += 1
            return true
        } else {
            return false
        }
    }
    
    func getQuestionText() -> String {
       return quiz[questionNumber].text
    }
    
    func getProgress() -> Float {
       return Float(questionNumber) / Float(quiz.count - 1)
    }
    
    mutating func nextQueston() {
        if questionNumber == quiz.count - 1 {
            questionNumber = 0
            rightAnswers = 0
        } else {
            questionNumber += 1
        }
    }
    
    func getScore() -> Int {
        return rightAnswers
    }
    
    func getAnswerForQuestion(at index: Int) -> String {
        return quiz[questionNumber].answers[index]
    }
}

