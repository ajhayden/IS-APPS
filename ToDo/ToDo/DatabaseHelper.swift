//
//  DatabaseHelper.swift
//  ToDo
//
//  Created by Student on 12/17/20.
//

import Foundation
import GRDB

class DatabaseHelper {

    // MARK: - Constants

    struct Constant {
        static let fileName = "ToDoList1DB1"
        static let fileExtension = "sqlite"
    }

    // MARK: - Properties

    var dbQueue: DatabaseQueue

    // MARK: - Singleton

    static let shared = DatabaseHelper()

    private init() {
        if let directoryUrl = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ) {
            let fileUrl = directoryUrl
                .appendingPathComponent(Constant.fileName)
                .appendingPathExtension(Constant.fileExtension)
            let fileExists = FileManager.default.fileExists(atPath: fileUrl.path)

            if let queue = try? DatabaseQueue(path: fileUrl.path) {
                dbQueue = queue

                if !fileExists {
                    createListTable()
                }
                return
            }
        }

        fatalError("Unable to connect to database")
    }

    private func createListTable() {
        try? dbQueue.write { db in
            try? db.execute(sql: """
                                CREATE TABLE list(
                                    id TEXT PRIMARY KEY,
                                    description TEXT,
                                    dueDate TEXT,
                                    status TEXT)
                                """)
            try? db.execute(sql: """
                                INSERT INTO list VALUES (
                                    ?,
                                    'Task 1: Get food',
                                    '2020-11-23 07:23:45',
                                    'COMPLETE')
                                """,
                            arguments: [UUID()])
            try? db.execute(sql: """
                                INSERT INTO list VALUES (
                                    ?,
                                    'Task 2: Feed Dog',
                                    '2020-11-25 11:23:45',
                                    'INCOMPLETE')
                                """,
                            arguments: [UUID()])
            try? db.execute(sql: """
                                INSERT INTO list VALUES (
                                    ?,
                                    'Task 3: Dance',
                                    '2020-11-27 14:23:45',
                                    'COMPLETE')
                                """,
                            arguments: [UUID()])
        }
    }
    
    func list() -> [ToDoItem] {
        do {
            let list = try dbQueue.inDatabase { (db: Database) -> [ToDoItem] in
                var list = [ToDoItem]()

                let rows = try Row.fetchCursor(db, sql: "select * from list")

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
    
    // These need more work
    
    func deleteListItem(_ item: ToDoItem) {
        do {
            try dbQueue.write { db in
//                _ = try item.delete(db)
            }
        } catch {
            print("Error deleting record: \(error)")
        }
    }

    func addListItem(_ item: ToDoItem) {
        try? dbQueue.write { db in
//            try? item.insert(db)
        }
    }

    func editListItem(_ report: ToDoItem) {
        try? dbQueue.write { db in
//            try? item.update(db)
        }
    }
    
}
