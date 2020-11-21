//
//  CarVisualizationViewControllerTests.swift
//  CarangasTests
//
//  Created by Eric Alves Brito on 21/11/20.
//  Copyright © 2020 Afrodev. All rights reserved.
//

import XCTest
@testable import Carangas

class CarViewControllerTests: XCTestCase {
    
    var sut: CarViewController!
    var car: Car!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        car = Car()
        car.name = "Civic"
        car.brand = "Honda"
        car.price = 65000
        car.gasType = 0
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CarViewController") as? CarViewController
    }

    override func tearDownWithError() throws {
        sut = nil
        car = nil
        try super.tearDownWithError()
    }
    
    func testCarVisualization() {
        //Given
        sut.viewModel = CarVisualizationViewModel(car: car)
        sut.loadView()
        
        //When
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        //Then
        XCTAssertEqual(sut.title, "Civic")
        XCTAssertEqual(sut.lbBrand.text!, "Marca: Honda")
        XCTAssertEqual(sut.lbGasType.text!, "Combustível: Flex")
        XCTAssertEqual(sut.lbPrice.text!, "Preço: R$ 65000")
    }
}
