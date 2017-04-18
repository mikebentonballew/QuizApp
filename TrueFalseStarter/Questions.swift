//
//  Questions.swift
//  TrueFalseStarter
//
//  Created by MICHAEL BALLEW on 3/28/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation


struct Questions {
    let question: String
    let choices: [Int : String]
    let answer: Int
    
    func returnAnswerNumber() -> Int {
        return answer
    }
    func returnAnswerString() -> String {
        return choices[self.answer]!
    }
    func returnNumberOfChoices() -> Int {
        return choices.count
    }
    func returnQuestion() -> String {
        return firstQuestion.question
    }
    
}
let firstQuestion = Questions(question: "What is your name", choices: [1:"Mike",2:"John",3:"Bob",4:"Sue"], answer: 1)
let secondQuestion = Questions(question: "What's your middle name", choices: [1:"Bob",2:"Sue",3:"Benton"], answer: 3)
