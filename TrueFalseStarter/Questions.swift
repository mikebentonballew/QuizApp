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
        return question
    }
    func returnChoice(choiceNumber : Int) -> String {
        return choices[choiceNumber]!
    }
    
}
