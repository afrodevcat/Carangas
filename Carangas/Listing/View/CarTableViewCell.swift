//
//  CarTableViewCell.swift
//  Carangas
//
//  Created by Eric Alves Brito on 20/11/20.
//  Copyright © 2020 Afrodev. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    func configure(with viewModel: CarCellViewModel) {
        textLabel?.text = viewModel.name
        detailTextLabel?.text = viewModel.brand
    }

}
