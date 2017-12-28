//
//  ProteinViewController.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/25/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class ProteinViewController: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    var ligandModel = Ligand()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = ligandModel.name
        nameLbl.textColor = UIColor.green
    }

}

