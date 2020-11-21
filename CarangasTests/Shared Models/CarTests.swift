//
//  CarTests.swift
//  CarangasTests
//
//  Created by Eric Alves Brito on 21/11/20.
//  Copyright © 2020 Afrodev. All rights reserved.
//

import XCTest
@testable import Carangas

class CarTests: XCTestCase {

    var sut: Car!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFuel() throws {
        //Give
        let car = Car()
        car.gasType = 0
        
        //When
        let fuel = car.fuel
        
        //Then
        XCTAssertEqual(fuel, "Flex")
    }
}
