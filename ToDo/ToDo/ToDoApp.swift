//
//  ToDoApp.swift
//  ToDo
//
//  Created by Student on 12/17/20.
//

import SwiftUI

@main
struct ToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView(viewModel: ToDoViewModel())
        }
    }
}
