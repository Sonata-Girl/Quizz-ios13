//
//  Question.swift
//  Quizz-ios13
//
//  Created by Sonata Girl on 27.02.2023.
//

import Foundation

struct Question {
    
    let text: String
    let answers: [String]
    let correctAnswer: String
    
    init(q: String, answers: [String], a: String) {
        text = q
        self.answers = answers
        correctAnswer = a
    }
}
