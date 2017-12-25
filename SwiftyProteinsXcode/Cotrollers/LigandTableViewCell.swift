//
//  LigandTableViewCell.swift
//  SwiftyProteinsXcode
//
//  Created by Vetaliy Poltavets on 12/25/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class LigandTableViewCell: UITableViewCell {

    @IBOutlet weak var ligandLbl: UILabel!
    
    func setLigandName (ligand: String) {
        ligandLbl.text = ligand
    }
}
