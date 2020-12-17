//
//  ToDoModel.swift
//  ToDo
//
//  Created by Student on 12/17/20.
//

import Foundation
import GRDB

struct ToDoModel {
    
    // MARK: Constants
    
    private let databaseHelper = DatabaseHelper.shared
    
    // MARK: Properties
    
    var toDoList = [ToDoItem]()
    
    // MARK: - Initialization
    
    init() {
        toDoList = databaseHelper.list()
    }
    
    // MARK: - Methods
    
    // Needs more work
    
    mutating func addListItem(_ item: ToDoItem) {
        databaseHelper.addListItem(item)
        toDoList.append(item)
    }

    mutating func deleteListItem(at index: Int) {
        if index >= 0 && index < toDoList.count {
            databaseHelper.deleteListItem(toDoList[index])
            toDoList.remove(at: index)
        }
    }
    
}

