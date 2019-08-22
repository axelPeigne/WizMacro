//
//  CarData.swift
//  App
//
//  Created by Axel Peigné on 22/08/2019.
//

import Foundation

struct CarData: Codable {
    
    enum CarDataErrors: Error {
        case cantCreateLicencePlate
    }
    
    var licence: String?
    var color: String?
    var maker: String?
    var model: String?
    var checkinDate: String?
    var station: String?
    var status: String?
    var owner: String?
    
    var licencePlate: LicencePlate? {
        if let licence = licence,
            let licencePlate = LicencePlate(value: licence) {
            return licencePlate
        } else {
            return nil
        }
    }
    
    var carStatus: CarStatus {
        if let status = status,
            let carStatus = CarStatus(rawValue: status) {
            return carStatus
        } else {
            return .Error
        }
    }
    
    mutating func toCar() throws -> Car {
        self.trimAll()
        
        guard let licencePlate = self.licencePlate else {
            throw CarDataErrors.cantCreateLicencePlate
        }
        
        let car = Car(licence: licencePlate, status: carStatus)
        
        do {
            try self.update(car: car)
        }
        
        return car
    }
    
    mutating func update(car: Car) throws {
        self.trimAll()
        
        guard let licencePlate = self.licencePlate else {
            throw CarDataErrors.cantCreateLicencePlate
        }
        
        car.licence = licencePlate
        car.status = carStatus
        car.color = color
        car.maker = maker
        car.model = model
        car.station = station
        car.owner = owner
    }
    
    mutating func trimAll() {
        let characterSet: CharacterSet = [" "]
        self.licence = licence?.trimmingCharacters(in: characterSet)
        self.color = color?.trimmingCharacters(in: characterSet)
        self.maker = maker?.trimmingCharacters(in: characterSet)
        self.model = model?.trimmingCharacters(in: characterSet)
        self.checkinDate = model?.trimmingCharacters(in: characterSet)
        self.station = status?.trimmingCharacters(in: characterSet)
        self.status = status?.trimmingCharacters(in: characterSet)
        self.owner = owner?.trimmingCharacters(in: characterSet)
    }
    
}
