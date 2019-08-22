//
//  LicencePlateTests.swift
//  App
//
//  Created by Axel Peigné on 22/08/2019.
//

@testable import App
import Vapor
import XCTest
import FluentSQLite

final class LicencePlateTests: XCTestCase {
    
    func testLicencePlateValidation() throws {
        let correctValues = [
            "wx-457-ze",
            "DZ-878-YH",
            "QI782PU",
            "uf785oi",
            "RF-985-za",
            "os-475-VT",
            "ZE758-AS",
            "AZ-215ZE"
        ]
        
        for value in correctValues {
            let car = Car(licence: value, status: .OnHand)
            XCTAssertNoThrow(try car.validate())
        }
        
        let incorrectValues = [
            "edz-985-zd",
            "ZS9857AZ",
            "KS-984-PMd",
            "DA--7854-de",
            " SQ-743-ds",
            "@s-475-ks"
        ]
        
        for value in incorrectValues {
            let car = Car(licence: value, status: .OnHand)
            XCTAssertThrowsError(try car.validate())
        }
    }

}
