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
    var car: Car!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if car != nil {
            tfName.text = car.name
            tfBrand.text = car.brand
            tfPrice.text = "\(car.price)"
            scGasType.selectedSegmentIndex = car.gasType
            btAddEdit.setTitle("Aletrar carro", for: .normal)
            title = "Alteração"
        }
    }
    
    // MARK: - IBActions
    @IBAction func addEdit(_ sender: UIButton) {
        if car == nil {
            car = Car()
        }
        
        car.name = tfName.text!
        car.brand = tfBrand.text!
        car.gasType = scGasType.selectedSegmentIndex
        car.price = Int(tfPrice.text!) ?? 0
        
        if car._id == nil {
            
            CarAPI().createCar(car) { (_) in
                self.goBack()
            }
            
        } else {
            CarAPI().updateCar(car) { (_) in
                self.goBack()
            }
        }
    }
    
    // MARK: - Methods
    private func goBack() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
