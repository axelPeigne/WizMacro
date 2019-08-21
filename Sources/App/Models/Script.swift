//
//  Script.swift
//  App
//
//  Created by Axel Peigné on 21/08/2019.
//

import FluentSQLite
import Vapor

final class Script: SQLiteModel {
    
    static let createdAtKey: TimestampKey? = \.createdAt
    static let updatedAtKey: TimestampKey? = \.updatedAt
    
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var identifier: ScriptIdentifier = .vrs08
    var schedule: ScriptSchedule = .daily

    
}

extension Script {
    var jobs: Children<Script, Job> {
        return children(\.scriptId)
    }
}

extension Script: Migration { }

extension Script: Content { }

extension Script: Parameter { }

enum ScriptIdentifier: String, Codable {
    case vrs08
    case manifest
}

extension ScriptIdentifier: ReflectionDecodable {
    static func reflectDecoded() throws -> (ScriptIdentifier, ScriptIdentifier) {
        return (.vrs08, .manifest)
    }
}

enum ScriptSchedule: String, Codable {
    case daily
    case hourly
}

extension ScriptSchedule: ReflectionDecodable {
    static func reflectDecoded() throws -> (ScriptSchedule, ScriptSchedule) {
        return (.daily, .hourly)
    }
}
