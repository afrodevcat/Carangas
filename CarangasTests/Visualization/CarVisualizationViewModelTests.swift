//
//  CarVisualizationViewModelTests.swift
//  CarangasTests
//
//  Created by Eric Alves Brito on 21/11/20.
//  Copyright © 2020 Afrodev. All rights reserved.
//

import XCTest
@testable import Carangas

class CarVisualizationViewModelTests: XCTestCase {

    //System Under Test
    var sut: CarVisualizationViewModel!
    var car: Car!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        car = Car()
        car.name = "Civic"
        car.brand = "Honda"
        car.price = 65000
        car.gasType = 0
        
        sut = CarVisualizationViewModel(car: car)
    }

    override func tearDownWithError() throws {
        
        car = nil
        sut = nil
        
        try super.tearDownWithError()
    }

    func testBrand() {
        //Given
        //Viewmodel montada com um carro
        
        //When
        let brand = sut.brand
        
        //Then
        //brand == "Marca: Honda"
        XCTAssertEqual(brand, "Marca: Honda", "A marca retornada não condiz com o esperado")
        
    }
    
    func testTitle() {
        //Given
        //Viewmodel montada com um carro
        
        //When
        let title = sut.title
        
        //Then
        XCTAssertEqual(title, "Civic")
    }
}



//Dependecy Injection (Injeção de Dependência)
