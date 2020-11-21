//
//  FormViewController.swift
//  Carangas
//
//  Copyright © 2020 Afrodev. All rights reserved.
//

import UIKit

final class FormViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddEdit: UIButton!
    
    // MARK: - Properties
    var viewModel: CarFormViewModel = CarFormViewModel()
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        if viewModel.isEditing {
            tfName.text = viewModel.name
            tfBrand.text = viewModel.brand
            tfPrice.text = viewModel.price
            scGasType.selectedSegmentIndex = viewModel.gasType
        }
        btAddEdit.setTitle(viewModel.buttonTitle, for: .normal)
        title = viewModel.title
    }
    
    // MARK: - IBActions
    @IBAction func addEdit(_ sender: UIButton) {
        viewModel.saveCar(name: tfName.text!, brand: tfBrand.text!, gasType: scGasType.selectedSegmentIndex, price: tfPrice.text!)
    }
    
    // MARK: - Methods
    private func goBack() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /*
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.goBack()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    */
}

extension FormViewController: CarFormViewModelDelegate {
    func onCarCreated(result: Result<Void, CarAPIError>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                UIAlertController.showAlert(presenter: self, title: "Parabéns!", message: "Seu carro foi criado com sucesso!") { (_) in
                    self.goBack()
                }
                //self.showAlert(title: "Parabéns!", message: "Seu carro foi criado com sucesso!")
            case .failure(let carApiError):
                UIAlertController.showAlert(presenter: self, title: "Erro ao criar o carro!", message: carApiError.errorMessage)
                //self.showAlert(title: "Erro ao criar o carro!", message: carApiError.errorMessage)
            }
        }
    }
    
    func onCarUpdated(result: Result<Void, CarAPIError>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                UIAlertController.showAlert(presenter: self, title: "Sucesso!", message: "Seu carro foi atualizado!") { (_) in
                    self.goBack()
                }
                //self.showAlert(title: "Sucesso!", message: "Seu carro foi atualizado!")
            case .failure(let carApiError):
                UIAlertController.showAlert(presenter: self, title: "Erro ao atualizar o carro!", message: carApiError.errorMessage)
                //self.showAlert(title: "Erro ao atualizar o carro!", message: carApiError.errorMessage)
            }
        }
    }
}

