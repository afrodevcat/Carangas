//
//  ViewController.swift
//  Carangas
//
//  Copyright © 2020 Afrodev. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lbBrand: UILabel!
    @IBOutlet weak var lbGasType: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    // MARK: - Properties
    var car: Car!
    
    // MARK: - Super Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = car.name
        lbBrand.text = "Marca: \(car.brand)"
        lbGasType.text = "Combustível: \(car.fuel)"
        lbPrice.text = "Preço: R$ \(car.price)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? FormViewController
        vc?.car = car
    }
}
