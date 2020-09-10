//
//  calculatorApp.swift
//  calculator
//
//  Created by Student on 9/10/20.
//

import SwiftUI

@main
struct calculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(result: calculationObj())
        }
    }
}
