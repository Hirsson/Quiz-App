//
//  QuizModel.swift
//  Quiz
//
//  Created by MBP on 16/04/2019.
//  Copyright © 2019 Axel Hirszson. All rights reserved.
//

import Foundation

protocol QuizProtocol {
    func questionsRetrieved(questions:[Question])
}

class QuizModel {
    
    var delegate:QuizProtocol?
    
    func getQuestions() {
        
        // TODO: Go retrieve data
        getLocalJsonFile()
        
        // When it comes back, call the questionRetrieved method of the delegate
        //delegate?.questionsRetrieved(questions: [Question]())
        
    }
    
    func getLocalJsonFile() {
        
        // Get a path to the json file in our app bundle
        let path = Bundle.main.path(forResource: "QuestionData", ofType: ".json")
        
        guard path != nil else {
            print("Can't find the json file")
            return
            
        }
        
        // Create a URL object from that string path
        let url = URL(fileURLWithPath: path!)
        
         // Decode that data into instances of the Question Struct
        do {
            // Get the data from that URL
            let data = try Data(contentsOf: url)
        
            // Decode the json data
            let decoder = JSONDecoder()
            let array = try decoder.decode([Question].self, from: data)
            
            // Return the question struct to the view controller
            delegate?.questionsRetrieved(questions: array)
            
            }
            catch {
                print("Couldn't create Data object from file")
            }
            // Decode that data into instances of the Question Struct
         //   let decoder = JSONDecoder()
         //   let array = try decoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: data)
            
    }
    
    func getRemoteJsonFile() {
        
    }
    
}
 

