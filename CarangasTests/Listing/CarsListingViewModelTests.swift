//
//  CarsListingViewModelTests.swift
//  CarangasTests
//
//  Created by Eric Alves Brito on 21/11/20.
//  Copyright © 2020 Afrodev. All rights reserved.
//

import XCTest
@testable import Carangas

class CarsListingViewModelTests: XCTestCase {

    var sut: CarsListingViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CarsListingViewModel(service: CarAPIStub())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testCount() {
        //Given
        
        //When
        sut.loadCars()
        
        //Then
        XCTAssertEqual(2, sut.count, "Total de carros diferente do esperado")
    }

    func testCellViewModelForFirstCar() {
        //Given
        let indexPath = IndexPath(row: 0, section: 0)
        sut.loadCars()
        
        //When
        let cellViewModel = sut.cellViewModel(at: indexPath)
        
        //Then
        XCTAssertEqual(cellViewModel.name, "Porsche T1000")
        XCTAssertEqual(cellViewModel.brand, "Porsche")
    }
}
