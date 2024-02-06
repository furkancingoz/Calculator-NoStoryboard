//
//  Calculator.swift
//  HesapMakTest
//
//  Created by Furkan Cingöz on 4.02.2024.
//

import Foundation

class Calculator {
    var firstNumber: Int = 0
    var resultNumber: Int = 0
    var currentOperation: Operation?


    func calculate(secondNumber: Int) -> Int {
        switch currentOperation {
        case .add: resultNumber = firstNumber + secondNumber
        case .subtract: resultNumber = firstNumber - secondNumber
        case .multiply: resultNumber = firstNumber * secondNumber
        case .divide: resultNumber = firstNumber / secondNumber
         default:
          break
        }
        return resultNumber
    }

    
}

