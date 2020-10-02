//
//  HighScoreViewModel.swift
//  Concentration
//
//  Created by Student on 9/29/20.
//

import SwiftUI

class HighScoreViewModel: ObservableObject {
    @Published var defaults = UserDefaults.standard
    var userDefault: UserDefaults {
        UserDefaults.standard
    }
}

