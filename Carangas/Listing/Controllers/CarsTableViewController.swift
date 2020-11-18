//
//  CarsTableViewController.swift
//  Carangas
//
//  Copyright © 2020 Afrodev. All rights reserved.
//

import UIKit

final class CarsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var cars: [Car] = []
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
        
        //Modo PORKAUM, GEITO VIDA LOKA
        /*
        URLSession.shared.dataTask(with: URL(string: "https://carangas.herokuapp.com/cars")!) { (data, _, _) in
            self.cars = try! JSONDecoder().decode([Car].self, from: data!)
            DispatchQueue.main.async {self.tableView.reloadData()}
        }.resume()
        */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? CarViewController
        vc?.car = cars[tableView.indexPathForSelectedRow!.row]
    }
    
    // MARK: - Methods
    private func loadCars() {
        //Capture list
        CarAPI().loadCars {[weak self] (result) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let cars):
                self.cars = cars
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let carApiError):
                switch carApiError {
                case .badURL:
                    print("URL inválida!")
                case .invalidStatusCode(let statusCode):
                    print("O servidor retornou um status code inválido:", statusCode)
                default:
                    print("Erro descohecido")
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let car = cars[indexPath.row]
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = car.brand
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let car = cars[indexPath.row]
            CarAPI().deleteCar(car) { (result) in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.cars.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                case .failure:
                    print("ERRRROOOOOOUUUU!")
                }
            }
        }
        
    }
}
