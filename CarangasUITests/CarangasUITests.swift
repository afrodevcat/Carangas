//
//  CarangasUITests.swift
//  CarangasUITests
//
//  Created by Eric Alves Brito on 21/11/20.
//  Copyright © 2020 Afrodev. All rights reserved.
//

import XCTest

class CarangasUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBizarrao() {
        
        
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["Carangas"].buttons["Add"].tap()
        app.textFields["Marca"].tap()
        
        let nomeTextField = app.textFields["Nome"]
        nomeTextField.tap()
        nomeTextField.typeText("Meu Carro")

        let marcaTextField = app.textFields["Marca"]
        marcaTextField.tap()
        marcaTextField.typeText("Minha Marca")

        
        let preOTextField = app.textFields["Preço"]
        preOTextField.tap()
        preOTextField.typeText("25000")
        
        let app2 = app
        app2/*@START_MENU_TOKEN@*/.buttons["Gasolina"]/*[[".segmentedControls.buttons[\"Gasolina\"]",".buttons[\"Gasolina\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.staticTexts["Cadastrar Carro"]/*[[".buttons[\"Cadastrar Carro\"].staticTexts[\"Cadastrar Carro\"]",".staticTexts[\"Cadastrar Carro\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Parabéns!"].scrollViews.otherElements.buttons["OK"].tap()
                
        
    }
    
    func testCarListAndVisualization() {
        //Given
        let app = XCUIApplication()
        app.launch()
        
        //When
        let cell = app.tables["carsTable"].cells.firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 5.0))
        
        let cellTitleLabelText = cell.staticTexts["carsCellTitle"].label
        XCTAssertFalse(cellTitleLabelText.isEmpty)
        cell.tap()
        
        //Then
        XCTAssertTrue(app.navigationBars[cellTitleLabelText].exists)
    }
}
