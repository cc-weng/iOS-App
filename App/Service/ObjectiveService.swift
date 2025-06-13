//
//  ObjectiveService.swift
//  focus
//
//  Created by ccweng on 2025/6/13.
//

import Foundation
import GRDB

struct ObjectiveService {
    private let dbQueue: DatabaseQueue
    
    init() throws {
        self.dbQueue = try AppDatabase.shared().dbQueue
    }
    
    func fetchAll() throws -> [ObjectiveModel] {
        try dbQueue.read { db in
            try ObjectiveModel.order(ObjectiveModel.Columns.createdAt.desc).fetchAll(db)
        }
    }
    
    func fetch(pagination: PaginationReq) throws -> PaginationRsp<ObjectiveModel> {
        try dbQueue.read { db in
            let list = try ObjectiveModel.order(ObjectiveModel.Columns.createdAt.desc).limit(pagination.pageSize, offset: pagination.offset).fetchAll(db)
            let total = try ObjectiveModel.fetchCount(db)
            return PaginationRsp(page: pagination.page, pageSize: pagination.pageSize, total: total, list: list)
        }
    }
        
    func create(_ item: inout ObjectiveModel) throws {
        try dbQueue.write { db in
            try item.save(db)
        }
    }
    
    func update(_ item: ObjectiveModel) throws {
        try dbQueue.write { db in
            try item.update(db)
        }
    }
    
    func delete(_ ids: [Int64]) throws {
        try dbQueue.write { db in
            for id in ids {
                try ObjectiveModel.deleteOne(db, id: id)
            }
        }
    }
}
