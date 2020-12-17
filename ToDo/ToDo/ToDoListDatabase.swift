//
//  ToListDatabase.swift
//  ToDo
//
//  Created by Student on 12/17/20.
//

import Foundation
import GRDB

class ToDoListDatabase {

    // MARK: - Constants

    struct Constant {
        static let fileName = "ToDoListDB"
        static let fileExtension = "sqlite"
    }
    
    // MARK: - Properties

    var dbQueue: DatabaseQueue

    // MARK: - Singleton

    static let shared = ToDoListDatabase()

    private init() {
        if let path = Bundle.main.path(forResource: Constant.fileName,
                                       ofType: Constant.fileExtension) {
            if let queue = try? DatabaseQueue(path: path) {
                dbQueue = queue
                return
            }
        }

        fatalError("Unable to connect to database")
    }

    // MARK: - Helpers
    
    //
    // Return an array of strings listing the titles of all scripture volumes.
    //
    func list() -> [ToDoItem] {
        do {
            let list = try dbQueue.inDatabase { (db: Database) -> [ToDoItem] in
                var list = [ToDoItem]()

                let rows = try Row.fetchCursor(db,
                                               sql: """
                                                    select * from \(ToDoItem.Table.databaseTableName) \
                                                    order by \(ToDoItem.Table.id)
                                                    """)
                while let row = try rows.next() {
                    list.append(ToDoItem(row: row))
                }

                return list
            }

            return list
        } catch {
            return []
        }
    }
}

// SCHEMA

//CREATE TABLE list (description TEXT, dueDate NUMERIC, status TEXT);
