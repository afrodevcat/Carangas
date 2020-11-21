//
//  CarAPIStub.swift
//  CarangasTests
//
//  Created by Eric Alves Brito on 21/11/20.
//  Copyright © 2020 Afrodev. All rights reserved.
//

import Foundation
@testable import Carangas

class CarAPIStub: NSObject, CarListingServiceProtocol {
    
    var cars: [Car] = {
        let car1 = Car()
        car1.name = "Porsche T1000"
        car1.brand = "Porsche"
        car1.gasType = 0
        car1.price = 270000

        let car2 = Car()
        car2.name = "CorInferno"
        car2.brand = "Corcel"
        car2.gasType = 1
        car2.price = 40000
        
        return [car1, car2]
    }()
    
    func loadCars(onComplete: @escaping (Result<[Car], CarAPIError>) -> Void) {
        onComplete(.success(cars))
    }
    
    func deleteCar(_ car: Car, onComplete: @escaping (Result<Void, CarAPIError>) -> Void) {
        onComplete(.success(()))
    }
    
    
}
