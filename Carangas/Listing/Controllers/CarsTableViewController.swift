//
//  CarsTableViewController.swift
//  Carangas
//
//  Copyright © 2020 Afrodev. All rights reserved.
//

import UIKit

final class CarsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var viewModel = CarsListingViewModel()
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.carsDidUpdate = carsDidUpdate
        viewModel.fail = fail
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadCars()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? CarViewController
        vc?.viewModel = viewModel.getCarVisualizationViewModel(for: tableView.indexPathForSelectedRow!)
    }
    
    // MARK: - Methods
    private func carsDidUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func fail(error: CarAPIError) {
        switch error {
        case .badURL:
            print("URL inválida")
        case .decodeError:
            print("Erro de decoding!!")
        default:
            print("Erro desconhecido")
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarTableViewCell
        cell.configure(with: viewModel.cellViewModel(at: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteCar(at: indexPath)
        }
    }
}
