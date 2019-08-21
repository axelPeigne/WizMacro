//
//  CarController.swift
//  App
//
//  Created by Axel Peigné on 21/08/2019.
//

import Vapor
import FluentSQLite

final class CarController {
    
    func index(_ req: Request) throws -> Future<[Car]> {
        return Car.query(on: req).all()
    }
    
}
