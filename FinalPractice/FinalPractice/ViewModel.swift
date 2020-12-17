//
//  ViewModel.swift
//  FinalPractice
//
//  Created by Student on 12/16/20.
//

import Foundation

class ViewModel: ObservableObject, Identifiable {
    
    // MARK: - Constants
    
    let id: UUID
    
    // MARK: - Properties
    
    @Published private var model = Model(variable1: 1)
    @Published var viewModelInt = 10
    @Published var viewModelString = "Hello my friend!"
    
    var audioPlayer = SoundPlayer()
    
    // MARK: - Initialization
    
    init(id: UUID? = nil) {
        self.id = id ?? UUID()
    }
    
    // MARK: - Model access
    
    var getVariable1: Int {
        model.variable1
    }
    
    // MARK: - Intents
    
    func addInnerObject() {
        model.addArray1()
    }
    
}
