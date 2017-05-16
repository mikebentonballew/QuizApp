//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var gameSound: SystemSoundID = 0
    // array of available question index numbers
    var unusedQuestionIndexes = [Int]()
    
    let questionSet : [Questions] = [Questions(question: "The largest circular storm in our solar system is on the surface of which of the following planets?", choices: [1:"Jupiter",2:"Venus",3:"Uranus",4:"Earth"], answer: 1),
                                     Questions(question: "The rapidly moving stream of charged particles that is being driven away from the sun is known as what?", choices: [1:"Solar Wind",2:"Sun Blow",3:"The Winds of Sol",4:"Star Whisper"], answer: 1),
                                     Questions(question: "The biggest asteroid known is:", choices: [1:"Vesta",2:"Icarus",3:"Ceres",4:"Eros"], answer: 3),
                                     Questions(question: "Rounded to the nearest day, the Mercurian year is equal to:", choices: [1:"111",2:"88",3:"50",4:"25"], answer: 2),
                                     Questions(question: "One of the largest volcanos in our solar system-if not the largest-is named Olympus Mons. This volcano is located on:", choices: [1:"Jupiter's moon Callisto",2:"Venus",3:"Saturn's moon Titan",4:"Mars"], answer: 4),
                                     Questions(question: "One Jupiter day is equal to which of the following? ", choices: [1:"1d 6h 40m",2:"9h 50m",3:"3h 20m",4:"2d 4h 10m"], answer: 2),
                                     Questions(question: "The time interval between two successive occurrences of a specific type of alignment of a planet (or the moon) with the sun and the earth is referred to as:", choices: [1:"a conjunction",2:"an opposition",3:"a sidereal period",4:"a synodic period"], answer: 4),
                                     Questions(question: "During the period between 1979 and 1998, what was the farthest planet from the sun?", choices: [1:"Neptune",2:"Pluto",3:"Jupiter",4:"Mars"], answer: 1),
                                     Questions(question: "Of the following four times, which one best represents the time it takes energy generated in the core of the sun to reach the surface of the sun and be radiated?", choices: [1:"Three minutes",2:"Thirty Days",3:"One thousand years",4:"One million years"], answer: 4),
                                     Questions(question: "The sunspot cycle is:", choices: [1:"3 years",2:"11 years",3:"26 years",4:"49 years"], answer: 2),
                                     Questions(question: "The andromeda Galaxy is which of the following types of galaxies?", choices: [1:"elliptical",2:"spiral",3:"barred-spiral",4:"irregular"], answer: 2),
                                     Questions(question: "About how many light years across is the Milky Way?", choices: [1:"1000",2:"10000",3:"100000",4:"1000000"], answer: 3),
                                     Questions(question: "Which unlucky Apollo lunar landing was canceled after an oxygen tank exploded?", choices: [1:"Apollo 13",2:"Apollo 19",3:"Apollo 1",4:"Showtime at the Apollo"], answer: 1),
                                     Questions(question: "Heliocentric means around:", choices: [1:"Jupiter",2:"the Moon",3:"the Sun",4:"Neptune"], answer: 3),
                                     Questions(question: "Triton, Neptune's moon, has an ocean made of a liquid. What is this liquid?", choices: [1:"Nitrogen",2:"Wet",3:"Gold",4:"Methane"], answer: 1),
                                     Questions(question: "What is the star nearest to the sun? ", choices: [1:"Alpha Centauri/Proxima Centauri",2:"Betelgeuse",3:"Rigel",4:"Aldebaran"], answer: 1),
                                     Questions(question: "When the earth if farthest from the sun, what season is it in the Northern Hemisphere?", choices: [1:"Summer",2:"Fall",3:"Winter",4:"Spring"], answer: 1),
                                     Questions(question: "Of the nine known planets, seven have one or more natural satellites. Name the only two moonless planets.", choices: [1:"Venus and Mercury",2:"Jupiter and Mars",3:"Saturn and Earth",4:"Pluto and Uranus"], answer: 1),
                                     Questions(question: "A typical galaxy, such as our Milky Way galaxy, contains how many billion stars? Is it approximately:", choices: [1:"10 billion",2:"40 billion",3:"200 billion",4:"800 billion"], answer: 3)]

    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var answerStatus: UILabel!
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    @IBOutlet weak var choiceThree: UIButton!
    @IBOutlet weak var choiceFour: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        generateArrayOfQuestionIdexes()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //build array of available question indexes based on existing question set
    func generateArrayOfQuestionIdexes() {
        var i = 0
        while i < questionSet.count {
            unusedQuestionIndexes.append(i)
            i += 1
        }
    }
    
    func displayQuestion() {
        // get index of next question from the array of available question indexes and remove the index from the array so that it is not available again in this game
        indexOfSelectedQuestion = unusedQuestionIndexes.remove(at: GKRandomSource.sharedRandom().nextInt(upperBound: unusedQuestionIndexes.count))
        
        questionField.text = questionSet[indexOfSelectedQuestion].returnQuestion()
        answerStatus.isHidden = true
        
        // Reset all buttons to full brightness.
        choiceOne.alpha = 1
        choiceTwo.alpha = 1
        choiceThree.alpha = 1
        choiceFour.alpha = 1
        
        choiceOne.setTitle(questionSet[indexOfSelectedQuestion].returnChoice(choiceNumber: 1), for: UIControlState.normal)
        choiceTwo.setTitle(questionSet[indexOfSelectedQuestion].returnChoice(choiceNumber: 2), for: UIControlState.normal)
        choiceThree.setTitle(questionSet[indexOfSelectedQuestion].returnChoice(choiceNumber: 3), for: UIControlState.normal)
        choiceFour.setTitle(questionSet[indexOfSelectedQuestion].returnChoice(choiceNumber: 4), for: UIControlState.normal)
        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        let correctAnswer = questionSet[indexOfSelectedQuestion].returnAnswerNumber()
        if (sender === choiceOne && correctAnswer == 1) || (sender === choiceTwo && correctAnswer == 2) || (sender === choiceThree && correctAnswer == 3) || (sender === choiceFour && correctAnswer == 4){
            answerStatus.text = "Correct!"
            correctQuestions += 1
        } else {
            answerStatus.text = "Sorry, That is Not the Answer."
        }
        
        // Dim all answers except for the correct one.
        if correctAnswer == 1 {
            choiceTwo.alpha = 0.2
            choiceThree.alpha = 0.2
            choiceFour.alpha = 0.2
        } else if correctAnswer == 2 {
            choiceOne.alpha = 0.2
            choiceThree.alpha = 0.2
            choiceFour.alpha = 0.2
        } else if correctAnswer == 3 {
            choiceOne.alpha = 0.2
            choiceTwo.alpha = 0.2
            choiceFour.alpha = 0.2
        } else if correctAnswer == 4 {
            choiceOne.alpha = 0.2
            choiceTwo.alpha = 0.2
            choiceThree.alpha = 0.2
        }
        
        answerStatus.isHidden = false
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        // trueButton.isHidden = false
        // falseButton.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        //rebuild array of question indexes
        generateArrayOfQuestionIdexes()
        nextRound()
    }
    

    
    // MARK: Helper Methods

    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

