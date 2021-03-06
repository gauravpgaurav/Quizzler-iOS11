//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstQuestion = allQuestions.list[questionNumber]
        questionLabel.text = firstQuestion.questionText
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag==1 {
            pickedAnswer = true
        } else {
            pickedAnswer = false
        }
        questionNumber+=1
        nextQuestion()
        checkAnswer(pickedAnswer: pickedAnswer)
        updateUI()
    }
    
    func updateUI() {
        scoreLabel.text = "\(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width/13) * CGFloat(questionNumber + 1)
    }
    
    func nextQuestion() {
        if questionNumber<(allQuestions.list.count - 1) {
            questionLabel.text = allQuestions.list[questionNumber].questionText
        } else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all questions, do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func checkAnswer(pickedAnswer: Bool) {
        if(pickedAnswer==allQuestions.list[questionNumber-1].answer){
            //Correct
            score += 1
            ProgressHUD.showSuccess("Correct!")
        } else {
            ProgressHUD.showError("Wrong!")
        }
    }
    
    func startOver() {
        questionNumber = 0
        score = 0
        viewDidLoad()
    }
    

    
}
