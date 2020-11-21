//
//  CarAPITests.swift
//  CarangasTests
//
//  Created by Eric Alves Brito on 21/11/20.
//  Copyright © 2020 Afrodev. All rights reserved.
//

import XCTest
@testable import Carangas

class CarAPITests: XCTestCase {

    var sut = CarAPI()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testLoadCarsResponseSuccess() {
        //Given
        let promise = expectation(description: "Sucesso")
        
        //When
        sut.loadCars { (result) in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let apiError):
                XCTFail(apiError.errorMessage)
            }
            promise.fulfill()
        }
        
        //Then
        wait(for: [promise], timeout: 3.0)
    }

}
