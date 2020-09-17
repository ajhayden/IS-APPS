//
//  Array+Only.swift
//  Concentration
//
//  Created by Student on 9/16/20.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first: nil
    }
}
