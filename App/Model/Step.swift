//
//  Step.swift
//  focus
//
//  Created by ccweng on 2025/6/13.
//

import Foundation
import GRDB

struct StepModel: Identifiable, Codable, FetchableRecord, PersistableRecord {
    var id: Int64
    var objectiveId: Int64
    var helper: String
    var createdAt: Date
    var value: Double
}

extension StepModel {
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let helper = Column(CodingKeys.helper)
        static let value = Column(CodingKeys.value)
        static let objectiveId = Column(CodingKeys.objectiveId)
        static let createdAt = Column(CodingKeys.createdAt)
    }
    
    mutating func didInsert(_ inserted: InsertionSuccess) {
        id = inserted.rowID
    }
}

