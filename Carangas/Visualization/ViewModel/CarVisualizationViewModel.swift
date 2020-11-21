//
//  CarVisualizationViewModel.swift
//  Carangas
//
//  Created by Eric Alves Brito on 20/11/20.
//  Copyright © 2020 Afrodev. All rights reserved.
//

import Foundation

struct CarVisualizationViewModel {
    
    private var car: Car
    
    init(car: Car) {
        self.car = car
    }
    
    var title: String {
        car.name
    }
    
    var brand: String {
        "Marca: \(car.brand)"
    }
    
    var gasType: String {
        "Combustível: \(car.fuel)"
    }
    
    var price: String {
        "Preço: R$ \(car.price)"
    }
    
    func getCarFormViewModel() -> CarFormViewModel {
        CarFormViewModel(car: car)
    }
}
