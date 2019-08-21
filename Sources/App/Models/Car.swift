//
//  Car.swift
//  App
//
//  Created by Axel Peigné on 21/08/2019.
//

import FluentSQLite
import Vapor

final class Car: SQLiteModel {
    
    static let createdAtKey: TimestampKey? = \.createdAt
    static let updatedAtKey: TimestampKey? = \.updatedAt
    
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var licence: LicencePlate?
    var color: String?
    var maker: String?
    var model: String?
    var checkinDate: String?
    var station: Station?
    var status: Status?
    var owner: String?
    
}

typealias LicencePlate = String
typealias Status = String

enum Station: String, Codable {
    case N0G, N8U, J16, Z48E, J09
}

extension Station: ReflectionDecodable {
    static func reflectDecoded() throws -> (Station, Station) {
        return (.N0G, .N8U)
    }
}

extension Car: Migration { }

extension Car: Content { }

extension Car: Parameter { }
