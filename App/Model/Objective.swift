//
//  Target.swift
//  focus
//
//  Created by ccweng on 2025/6/12.
//

import Foundation
import GRDB

struct ObjectiveModel: Identifiable, Codable, FetchableRecord, PersistableRecord {
    var id: Int64
    var name: String
    var helper: String
    var createdAt: Date
    var goal: Double
    var defaultStepValue: Double
}

extension ObjectiveModel {
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let name = Column(CodingKeys.name)
        static let helper = Column(CodingKeys.helper)
        static let goal = Column(CodingKeys.goal)
        static let defaultStepValue = Column(CodingKeys.defaultStepValue)
        static let createdAt = Column(CodingKeys.createdAt)
    }
    
    mutating func didInsert(_ inserted: InsertionSuccess) {
        id = inserted.rowID
    }
}

