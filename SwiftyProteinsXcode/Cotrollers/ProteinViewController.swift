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
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = ligandModel.name
        
        //Parse and set array of atoms
        ligandModel.parseAtomAndConnections()
    }
    
    
}

