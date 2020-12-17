//
//  ToDoViewModel.swift
//  ToDo
//
//  Created by Student on 12/17/20.
//

import Foundation

class ToDoViewModel: ObservableObject, Identifiable {
    @Published var toDoModel = ToDoModel()
    @Published var currentListItem: ToDoItem
    
    // MARK: - Initialization
    
    init() {
        let model = ToDoModel()

        toDoModel = model
        currentListItem = ToDoItem() // Curently empty but I will change this later
    }
    
    // MARK: - Intents
    
    func deleteListItem(at index: Int) {
        toDoModel.deleteListItem(at: index)
    }

    func addListItem() {
        toDoModel.addListItem(currentListItem)
//        toDoModel = createListItem()
    }
    
    func editListItem() {
        // Needs more work
    }
    
    // MARK: - Helpers
    
    // Needs more work
    private func createListItem() -> ToDoItem {
        ToDoItem()
    }
    
}
