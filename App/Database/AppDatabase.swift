//
//  AppDatabase.swift
//  focus
//
//  Created by ccweng on 2025/6/12.
//

import Foundation
import GRDB

final class AppDatabase {
  let dbQueue: DatabaseQueue

  private static var instance: AppDatabase?

  private init(_ dbQueue: DatabaseQueue) throws {
    self.dbQueue = dbQueue
    try migrator.migrate(dbQueue)
  }

  private var migrator: DatabaseMigrator {
    var migrator = DatabaseMigrator()

    #if DEBUG
      migrator.eraseDatabaseOnSchemaChange = true
    #endif

    migrator.registerMigration("v1") { db in
      try db.create(table: "objective") { t in
        t.column("id", .integer).primaryKey()
        t.column("name", .text).notNull()
        t.column("helper", .text).notNull()
        t.column("goal", .double).notNull()
        t.column("defaultStepValue", .double).notNull()
        t.column("createdAt", .datetime).notNull()
      }

      try db.create(table: "step") { t in
        t.column("id", .integer).primaryKey()
        t.column("objectiveId", .integer).notNull()
        t.column("helper", .text).notNull()
        t.column("value", .double).notNull()
        t.column("createdAt", .datetime).notNull()
      }
    }

    return migrator
  }

  static func shared() throws -> AppDatabase {

    if AppDatabase.instance != nil {
      return AppDatabase.instance!
    }

    let databaseUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    var config = Configuration.init()
    config.readonly = false

    let dbQueue = try DatabaseQueue(path: databaseUrl.path, configuration: config)
    AppDatabase.instance = try AppDatabase(dbQueue)

    return AppDatabase.instance!
  }
}
