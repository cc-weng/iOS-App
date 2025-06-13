//
//  StepService.swift
//  focus
//
//  Created by ccweng on 2025/6/13.
//

import Foundation
import GRDB
import SwiftUI

struct StepService {
    private let dbQueue: DatabaseQueue
    
    init() throws {
        self.dbQueue = try AppDatabase.shared().dbQueue
    }
    
    func fetchByObjective(_ item: ObjectiveModel) throws -> [StepModel] {
        try dbQueue.read { db in
            try StepModel
                .filter(Column(StepModel.Columns.objectiveId.name) == item.id)
                .order(StepModel.Columns.createdAt.desc)
                .fetchAll(db)
        }
    }
    
    func fetchAll() throws -> [StepModel] {
        try dbQueue.read { db in
            try StepModel.order(StepModel.Columns.createdAt.desc).fetchAll(db)
        }
    }
    
    func create(_ item: inout StepModel) throws {
        try dbQueue.write { db in
            try item.save(db)
        }
    }
    
    func update(_ item: StepModel) throws {
        try dbQueue.write { db in
            try item.update(db)
        }
    }
    
    func delete(_ ids: [Int64]) throws {
        try dbQueue.write { db in
            for id in ids {
                try StepModel.deleteOne(db, id: id)
            }
        }
    }
}
