//
//  CarAPI.swift
//  Carangas
//
//  Created by Eric Alves Brito on 17/11/20.
//  Copyright © 2020 Afrodev. All rights reserved.
//

import Foundation

enum CarAPIError: Error {
    case badURL
    case taskError
    case noResponse
    case invalidStatusCode(Int)
    case noData
    case decodeError
    
    var errorMessage: String {
        switch self {
        case .badURL:
            return "URL Inválida"
        case .noResponse:
            return "O servidor não enviou uma resposta"
        case .taskError:
            return "Erro na conclusão do envio"
        case .invalidStatusCode(let statusCode):
            return "Status code inválido: \(statusCode)"
        case .noData:
            return "O servidor não enviou dados"
        case .decodeError:
            return "Dados inválidos retornados pelo servidor"
        }
    }
}

class CarAPI {
    
    private let basePath = "https://carangas.herokuapp.com/cars"
    private let sessionConfiguration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        configuration.timeoutIntervalForRequest = 60
        configuration.httpMaximumConnectionsPerHost = 4
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        return configuration
    }()
    private lazy var session = URLSession(configuration: sessionConfiguration)
    
    func loadCars(onComplete: @escaping (Result<[Car], CarAPIError>) -> Void) {
        
        guard let url = URL(string: basePath) else {
            onComplete(.failure(.badURL))
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                onComplete(.failure(.taskError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                onComplete(.failure(.noResponse))
                return
            }
            
            if !(200...299 ~= response.statusCode) {
                onComplete(.failure(.invalidStatusCode(response.statusCode)))
                return
            }
            
            guard let data = data else {
                onComplete(.failure(.noData))
                return
            }
            
            do {
                let cars = try JSONDecoder().decode([Car].self, from: data)
                onComplete(.success(cars))
                
            } catch {
                onComplete(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    
    func deleteCar(_ car: Car, onComplete: @escaping (Result<Void, CarAPIError>) -> Void) {
        request("DELETE", car: car, onComplete: onComplete)
    }
    
    func updateCar(_ car: Car, onComplete: @escaping (Result<Void, CarAPIError>) -> Void) {
        request("PUT", car: car, onComplete: onComplete)
    }
    
    func createCar(_ car: Car, onComplete: @escaping (Result<Void, CarAPIError>) -> Void) {
        request("POST", car: car, onComplete: onComplete)
    }
    
    private func request(_ httpMethod: String, car: Car, onComplete: @escaping (Result<Void, CarAPIError>) -> Void) {
        let urlString = basePath + "/" + (car._id ?? "")
        let url = URL(string: urlString)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.httpBody = try? JSONEncoder().encode(car)
        
        
        session.dataTask(with: urlRequest) { (data, _, _) in
            if data == nil {
                onComplete(.failure(.taskError))
            } else {
                onComplete(.success(()))
            }
        }.resume()
    }
    
    
}

extension CarAPI: CarListingServiceProtocol {}
