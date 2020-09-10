//
//  calculations.swift
//  calculator
//
//  Created by Student on 9/10/20.
//

import Foundation
import SwiftUI

class calculationObj: ObservableObject {
    @Published var value: String = "0"
    
    func calculateDisplay(value_str: String) {
        if(self.value == "0") {
            self.value = ""
        }
        self.value += value_str
    }
    
    func calculateResult() {
        let stringWithMathematicalOperation = self.value
        
        let exp: NSExpression = NSExpression(format: stringWithMathematicalOperation)
        let result: Double = exp.expressionValue(with:nil, context: nil) as! Double
        
        if(String(result).suffix(2) == ".0") {
            self.value = String(Int(result))
        } else {
            self.value = String(result)
        }
    }
    
    func clearResult() {
        self.value = "0"
    }
    
    func removeLastCharacter() {
        var fullStr = self.value
        fullStr.removeLast()
        self.value = fullStr
    }
}

