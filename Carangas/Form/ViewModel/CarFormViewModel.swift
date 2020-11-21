//
//  CarFormViewModel.swift
//  Carangas
//
//  Created by Eric Alves Brito on 20/11/20.
//  Copyright © 2020 Afrodev. All rights reserved.
//

import Foundation

protocol CarFormViewModelDelegate: class {
    func onCarCreated(result: Result<Void, CarAPIError>)
    func onCarUpdated(result: Result<Void, CarAPIError>)
}

class CarFormViewModel {
    
    // MARK: - Properties
    private var car: Car
    private var service = CarAPI()
    weak var delegate: CarFormViewModelDelegate?
    
    init(car: Car? = nil) {
        self.car = car ?? Car()
    }
    
    var isEditing: Bool {
        car._id != nil
    }
    
    var name: String {
        car.name
    }
    
    var brand: String {
        car.brand
    }
    
    var price: String {
        "\(car.price)"
    }
    
    var gasType: Int {
        car.gasType
    }
    
    var title: String {
        isEditing ? "Alteração" : "Cadastro"
    }
    
    var buttonTitle: String {
        isEditing ? "Alterar Carro" : "Cadastrar Carro"
    }
    
    // MARK: - Methods
    func saveCar(name: String, brand: String, gasType: Int, price: String) {
        car.name = name
        car.brand = brand
        car.gasType = gasType
        car.price = Int(price) ?? 0
        if isEditing {
            service.updateCar(car) {[weak self] (result) in
                self?.delegate?.onCarUpdated(result: result)
            }
        } else {
            service.createCar(car) {[weak self] (result) in
                self?.delegate?.onCarCreated(result: result)
            }
        }
    }
}
