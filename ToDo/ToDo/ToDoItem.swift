//
//  ToDoItem.swift
//  ToDo
//
//  Created by Student on 12/17/20.
//

import Foundation
import GRDB

struct ToDoItem : Identifiable, Hashable {
    
    // MARK: - Constants

    struct Table {
        static let databaseTableName = "ToDoItem"

        static let id = "ID"
        static let description = "Description"
        static let dueDate = "DueDate"
        static let status = "Status"
    }

    // MARK: - Properties
    
    var id: Int
    var description: String
    var dueDate: String
    var status: String
    
    // MARK: - Initialization
    
    init() {
        id = 0
        description = ""
        dueDate = ""
        status = ""
    }

    init(id: Int, title: String) {
        self.id = id
        description = ""
        dueDate = title
        status = title
    }

    init(row: Row) {
        id = row[Table.id]
        description = row[Table.description]
        dueDate = row[Table.dueDate]
        status = row[Table.status]
    }
}
