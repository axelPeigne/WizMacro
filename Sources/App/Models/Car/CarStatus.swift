//
//  CarStatus.swift
//  App
//
//  Created by Axel Peigné on 22/08/2019.
//

import Foundation
import Vapor

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
