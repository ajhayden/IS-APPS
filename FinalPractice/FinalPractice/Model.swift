//
//  Model.swift
//  FinalPractice
//
//  Created by Student on 12/16/20.
//

import Foundation

struct Model {
    
    // MARK: Constants
    
    
    // MARK: Properties
    
    var variable1: Int
    var array1 = [InnerObject]()
    
    // MARK: - Initialization
    
    // MARK: - Model Structs
    
    struct InnerObject: Identifiable, Codable, Hashable {
        var id = UUID()
        let prop1: String
    }
    
    // MARK: - Methods
    
    var computedProp1: Int {
        2 + 2
    }
    
    mutating func addArray1() {
        array1.append(InnerObject(prop1: "hello"))
    }
    
    // MARK: - Private Helpers
    
}

// Find userdefaults example
// 
