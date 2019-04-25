//
//  StateManager.swift
//  Quiz
//
//  Created by Axel Hirszson on 4/25/19.
//  Copyright © 2019 Axel Hirszson. All rights reserved.
//

import Foundation

class StateManager {
    
    static var questionIndexKey = "QuestionIndexKey"
    static var numCorrectKey = "NumberCOrrectKey"
    
    static func saveState(numCorrect:Int, questionIndex:Int) {
    
        let defaults = UserDefaults.standard
    
        defaults.set(questionIndex, forKey: questionIndexKey)
        defaults.set(numCorrect, forKey: numCorrectKey)
    
    }

    static func retrieveValue(key:String) -> Any? {
        
        let defaults = UserDefaults.standard
    
        return defaults.value(forKey: key)
    
    }

    static func clearState() {
        
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: questionIndexKey)
        defaults.removeObject(forKey: numCorrectKey)
        
    }

}
