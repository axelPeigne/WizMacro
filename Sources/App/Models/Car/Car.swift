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
// Egalement, le décodage devra prendre en compte le fait qu'un objet existe ou non dans la BDD. S'il existe, il devra simplement le mettre à jour et non créer un doublon.
final class Car: SQLiteModel {
    
    static let createdAtKey: TimestampKey? = \.createdAt
    static let updatedAtKey: TimestampKey? = \.updatedAt
    
    var id: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var licence: LicencePlate
    var status: CarStatus
    var color: String?
    var maker: String?
    var model: String?
    var checkinDate: String?
    var station: Station?
    var owner: Station?
    
    init(
        id: Int? = nil,
        licence: LicencePlate,
        status: CarStatus
        ) {
        self.id = id
        self.licence = licence
        self.status = status
    }
    
}

struct LicencePlate: Codable {
    
    public var value: String
    
    init?(value: String) {
        if LicencePlate.validate(value: value) {
            self.value = value
        } else {
            return nil
        }
    }
    
    static func validate(value: String) -> Bool {
        return value.range(of: "^[A-z]{2}-?[0-9]{3}-?[A-z]{2}$", options: .regularExpression) != nil
    }
}

enum CarStatus: String, Codable {
    case OnMove = "OM"
    case OnHand = "OH"
    case Overdue = "OVDU"
    case Disp = "DISP"
    case Error
}

extension CarStatus: ReflectionDecodable {
    static func reflectDecoded() throws -> (CarStatus, CarStatus) {
        return (.OnMove, .OnHand)
    }
}

// TODO: replace Station with a proper Model with validation and Macros to update all fields.
// Needs to handle all levels of hierarchy (eg: station, districts, car controls, countries...)
typealias Station = String

extension Car: Migration { }

extension Car: Content { }

extension Car: Parameter { }
