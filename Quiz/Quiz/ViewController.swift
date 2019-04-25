//
//  ViewController.swift
//  Quiz
//
//  Created by MBP on 16/04/2019.
//  Copyright © 2019 Axel Hirszson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuizProtocol, UITableViewDataSource, UITableViewDelegate, ResultViewControllerProtocol {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = QuizModel()
    var questions = [Question]()
    var questionIndex = 0
    var numCorrect = 0
    
    var resultVC:ResultViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set up result dialog view controller
        resultVC = storyboard?.instantiateViewController(withIdentifier: "ResultVC") as? ResultViewController
        resultVC?.delegate = self
        resultVC?.modalPresentationStyle = .overCurrentContext
        
        // Conform to the table view protocols
        tableView.dataSource = self
        tableView.delegate = self
        
        // Configure the tableview for dynamic row height
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        // Set self as delagate for model and call get questions
        model.delegate = self
        model.getQuestions()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any recources that can be recreated
    
    }
    
    func displayQuestion() {
        
        // Check that the current question index is not beyond the bounds of the question array
        guard questionIndex < questions.count else {
            print("Trying to display a question index that is out of bounds")
            return
            
        }
        
        // Display the question
        questionLabel.text = questions[questionIndex].question!
        
        // Display the answer
        tableView.reloadData()
        
    }
    
    // MARK: - QuizProtocol methods
    
    func questionsRetrieved(questions: [Question]) {
        
        // Set our questions property with the questions from quiz model
        self.questions = questions
    
        // Tell tableview to reload the data
        // tableView.reloadData()
        
        // Display the first question
        displayQuestion()
        
    }
    
    // MARK: - TableView Protocol methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard questions.count > 0 && questions[questionIndex].answers != nil else {
            return 0
        }
        
        return questions[questionIndex].answers!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        
        // Get the label
        let label = cell.viewWithTag(1) as! UILabel
        
        // TODO: Set the text for the label
        label.text = questions[questionIndex].answers![indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Check against question index being out of bounds
        guard questionIndex < questions.count else {
            return
        }
        
        // Declare variable for the popup
        var title:String = ""
        let message:String = questions[questionIndex].feedback!
        let action:String = "Next"
        
        
        // User has selected an answer
        if questions[questionIndex].correctAnswerIndex! == indexPath.row {
            
            // User has selected the correct answer
            numCorrect += 1
            
            // Set thr title for the popup
            title = "Correct!"
            
        }
        
        else {
            // User has selected the wrong answer
            
            // Set the title for the popup
            title = "Wrong!"
            
        }
     
        // Display the popup
        
        if resultVC != nil {
            
            // Let the main thread display the popup
           //     https://academy.codewithchris.com/courses/258388/lectures/4261621
            DispatchQueue.main.async {
                self.present(self.resultVC!, animated: true, completion: {
                    // Set the mesage for thr popup:
                    self.resultVC!.setPopup(withTitle: title, withMessage: message, withAction: action)
                    
                })
            }
            
        }
        
        // Increment the question index to advence to the next question
        questionIndex += 1
        // displayQuestion()
        
    }
    
    // MARK: - ResultViewControllerProtocol methods
    
    func resultViewDismissed() {
        
        // Check the question index
        
        // If the question index == question count then we have finished the last question
        if questionIndex == questions.count {
            
            // Show summary
            if resultVC != nil {
                present(resultVC!, animated: true, completion: {
                    
                    self.resultVC?.setPopup(withTitle: "Summary", withMessage: "You got\(self.numCorrect) out of \(self.questions.count) correct.",withAction: "Restart")
                    
                })
                
            }
            
            questionIndex += 1
            
        }
       
        else if questionIndex > questions.count {
            
            // Restart the quiz
            numCorrect = 0
            questionIndex = 0
            displayQuestion()
            
        }
      
        else {
            
            // Display the next question when the result view has been dismissed
            displayQuestion()
        }
        
    }
    
}

