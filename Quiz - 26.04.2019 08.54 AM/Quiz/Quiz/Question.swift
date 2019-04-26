//
//  Question.swift
//  Quiz
//
//  Created by MBP on 16/04/2019.
//  Copyright © 2019 Axel Hirszson. All rights reserved.
//

import Foundation

struct Question: Codable {
    
    var question:String?
    var answers:[String]?
    var correctAnswerIndex:Int?
    var feedback:String?
    
    
}
