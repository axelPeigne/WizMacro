//
//  Job.swift
//  App
//
//  Created by Axel Peigné on 21/08/2019.
//

import FluentSQLite
import Vapor

final class Job: SQLiteModel {
    
    static let createdAtKey: TimestampKey? = \.createdAt
    static let updatedAtKey: TimestampKey? = \.updatedAt
    
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var startedAt: Date?
    var finishedAt: Date?
    var jsonResult: Data?
    var status: JobStatus
    var scriptId: Int
    
    init(id: Int? = nil, scriptId: Int) {
        self.id = id
        self.createdAt = Date()
        self.status = .created
        self.scriptId = scriptId
    }
}

extension Job {
    var script: Parent<Job, Script> {
        return parent(\.scriptId)
    }
}

enum JobStatus: String, Codable {
    case created
    case succeded
    case errored
    case empty
}

extension JobStatus: ReflectionDecodable {
    static func reflectDecoded() throws -> (JobStatus, JobStatus) {
        return (.created, .succeded)
    }
}

extension Job: Migration { }

extension Job: Content { }

extension Job: Parameter { }

