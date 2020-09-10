//
//  Array+Index.swift
//  Concentration
//
//  Created by Student on 9/10/20.
//

import Foundation

extension Array where Element: Identifiable {
    func index(of element: Element) -> Int? {
        for index in 0..<self.count {
            if cards[index].id == card.id {
                return index
            }
        }
        
        return nil
    }
}
