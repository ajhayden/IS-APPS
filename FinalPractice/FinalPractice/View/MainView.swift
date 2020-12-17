//
//  ContentView.swift
//  FinalPractice
//
//  Created by Student on 12/16/20.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text(" Variable 1: \(viewModel.getVariable1)")
            Text(" View Model Int: \(viewModel.viewModelInt)")
            Text(" View Model String: \(viewModel.viewModelString)")
        }
        .onAppear {
            // Do something here!
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
