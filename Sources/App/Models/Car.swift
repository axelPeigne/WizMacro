//
//  Car.swift
//  App
//
//  Created by Axel Peigné on 21/08/2019.
//

import FluentSQLite
import Vapor

// Stratégie :
// Pour le moment cette classe est relativement stupide, elle ne fait aucune validation ni recoupement par rapport à d'autres BDD (stations, statuts, etc...).
// A terme, l'idée est d'avoir un Model très fortement Typé avec des validations fortes. Le décodage des données devrait donc se faire plutôt en passant par un autre struct (type CarData) moins fortement Typé qui serait ensuite en charge de faire la conversion vers la classe Model.
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
