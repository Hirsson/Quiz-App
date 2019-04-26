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
        
        // Get a URL object from a string
        let stringUrl = "https://codewithchris.com/code/QuestionData.json"
        let url = URL(string: stringUrl)
        
        guard url != nil else {
            print("couldn't get a URL object")
            return
        }
        
        // Get a URLSession object
        let session = URLSession.shared
        
        //Get a DataTask object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                // Create a json decoder
                let decoder = JSONDecoder()
                
                do {
                    
                    // Try to parse the data
                    let array = try decoder.decode([Question].self, from: data!)
                    
                    // Notify the victim controller with results by passing the date back to the main thread
                    DispatchQueue.main.async {
                        
                        self.delegate?.questionsRetrieved(questions: array)
                        
                    }
                    
                }
                catch {
                    print("Couldn't parse the json")
                    
                }
                
            }
            
            
        }
                
            
    
         // Call resume on the DataTask object
            dataTask.resume()
            
                
    }
    
}
 

