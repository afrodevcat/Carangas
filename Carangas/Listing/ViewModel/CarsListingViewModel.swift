//
//  CarsListingViewModel.swift
//  Carangas
//
//  Created by Eric Alves Brito on 20/11/20.
//  Copyright © 2020 Afrodev. All rights reserved.
//

import Foundation

class CarsListingViewModel {
    
    private var cars: [Car] = [] {
        didSet {
            carsDidUpdate?()
        }
    }
    private var service = CarAPI()
    var carsDidUpdate: (() -> Void)?
    var fail: ((CarAPIError) -> Void)?
 
    var count: Int {
        cars.count
    }
    
    func loadCars() {
        service.loadCars {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let cars):
                self.cars = cars
            case .failure(let carApiError):
                self.fail?(carApiError)
            }
        }
    }
    
    private func getCar(at indexPath: IndexPath) -> Car {
        cars[indexPath.row]
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CarCellViewModel {
        CarCellViewModel(car: getCar(at: indexPath))
    }
    
    func deleteCar(at indexPath: IndexPath) {
        let car = getCar(at: indexPath)
        service.deleteCar(car) {[weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success:
                self.cars.remove(at: indexPath.row)
            case .failure:
                print("ERRRROOOOOOUUUU!")
            }
        }
    }
    
    func getCarVisualizationViewModel(for indexPath: IndexPath) -> CarVisualizationViewModel {
        CarVisualizationViewModel(car: getCar(at: indexPath))
    }
}
